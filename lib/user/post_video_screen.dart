import 'dart:io' as io;
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';
// ignore: deprecated_member_use, avoid_web_libraries_in_flutter
import 'dart:html' as html; // Only used on web for Blob URL preview

class PostVideoScreen extends StatefulWidget {
  const PostVideoScreen({super.key});

  @override
  State<PostVideoScreen> createState() => _PostVideoScreenState();
}

class _PostVideoScreenState extends State<PostVideoScreen> {
  io.File? _videoFile; // Only used for mobile/desktop
  Uint8List? _videoBytes; // Used for web uploads
  VideoPlayerController? _controller;
  final TextEditingController _captionController = TextEditingController();
  bool _isUploading = false;

  @override
  void dispose() {
    _controller?.dispose();
    _captionController.dispose();
    super.dispose();
  }

  Future<void> _pickVideo() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.video);
    if (result != null) {
      final pickedFile = result.files.single;

      if (kIsWeb) {
        if (pickedFile.bytes != null) {
          _videoBytes = pickedFile.bytes;

          final blob = html.Blob([_videoBytes!]);
          final url = html.Url.createObjectUrlFromBlob(blob);

          // ignore: deprecated_member_use
          _controller = VideoPlayerController.network(url)
            ..initialize().then((_) {
              setState(() {
                _videoFile = null;
                _controller!.play();
                _controller!.setLooping(true);
              });
            });
        }
      } else {
        if (pickedFile.path != null) {
          final file = io.File(pickedFile.path!);
          _controller = VideoPlayerController.file(file)
            ..initialize().then((_) {
              setState(() {
                _videoFile = file;
                _controller!.play();
                _controller!.setLooping(true);
              });
            });
        }
      }
    }
  }

  Future<void> _uploadPost() async {
    final caption = _captionController.text.trim();
    final user = FirebaseAuth.instance.currentUser;

    if ((kIsWeb && _videoBytes == null) ||
        (!kIsWeb && _videoFile == null) ||
        caption.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select a video and write a caption"),
        ),
      );
      return;
    }

    setState(() => _isUploading = true);

    try {
      final uuid = const Uuid().v4();
      final fileExt =
          kIsWeb
              ? 'mp4' // default extension
              : _videoFile!.path.split('.').last;
      final filePath = 'videos/$uuid.$fileExt';

      final supabase = Supabase.instance.client;

      // Upload video
      await supabase.storage
          .from('videos')
          .uploadBinary(
            filePath,
            kIsWeb ? _videoBytes! : await _videoFile!.readAsBytes(),
            fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
          );

      // Get public URL
      final publicUrl = supabase.storage.from('videos').getPublicUrl(filePath);

      // Save post to Firestore
      await FirebaseFirestore.instance.collection('posts').add({
        'videoUrl': publicUrl,
        'caption': caption,
        'userId': user?.uid,
        'timestamp': FieldValue.serverTimestamp(),
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Video uploaded successfully")),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      debugPrint('Upload error: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Upload failed: $e")));
    } finally {
      setState(() => _isUploading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Post a Video")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton.icon(
              onPressed: _pickVideo,
              icon: const Icon(Icons.video_file),
              label: const Text("Select Video"),
            ),
            const SizedBox(height: 10),
            if (_controller != null && _controller!.value.isInitialized)
              Container(
                width: double.infinity,
                constraints: const BoxConstraints(
                  maxHeight: 400, // Prevents it from overflowing
                ),
                child: AspectRatio(
                  aspectRatio: _controller!.value.aspectRatio,
                  child: VideoPlayer(_controller!),
                ),
              ),
            const SizedBox(height: 10),
            TextField(
              controller: _captionController,
              maxLines: 2,
              decoration: const InputDecoration(
                labelText: 'Write a caption...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child:
                  _isUploading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                        onPressed: _uploadPost,
                        child: const Text("Post Video"),
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
