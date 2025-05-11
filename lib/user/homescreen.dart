import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mjuajiapp0/user/solutions.dart';
import 'package:video_player/video_player.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _NewsHomeScreenState();
}

class _NewsHomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  List<Map<String, dynamic>> _newsItems = [];

  @override
  void initState() {
    super.initState();
    _fetchPosts();
  }

  Future<void> _fetchPosts() async {
    final snapshot =
        await FirebaseFirestore.instance
            .collection('posts')
            .orderBy('timestamp', descending: true)
            .get();

    final List<Map<String, dynamic>> fetchedPosts =
        snapshot.docs.map((doc) {
          final data = doc.data();
          return {
            'creatorName': data['userId'] ?? 'Unknown',
            'caption': data['caption'] ?? '',
            'videoUrl': data['videoUrl'] ?? '',
            'isVideo': true,
            'isLive': false,
            'likes': 0,
            'liked': false,
            'saved': false,
            'comments': 0,
            'bgColor': Colors.black,
          };
        }).toList();

    final placeholderPosts = [
      {
        'creatorName': 'Dr. Alice Waweru',
        'caption': 'Endometriosis Awareness - Live Now!',
        'isLive': true,
        'isVideo': true,
        'bgColor': Colors.teal.shade200,
        'likes': 1245,
        'liked': false,
        'saved': false,
        'comments': 85,
      },
      {
        'creatorName': 'Health Weekly',
        'caption': 'New research shows promising treatment options',
        'isLive': false,
        'isVideo': true,
        'bgColor': Colors.blue.shade200,
        'likes': 876,
        'liked': false,
        'saved': false,
        'comments': 42,
      },
    ];

    if (!mounted) return;
    setState(() {
      _newsItems = [...fetchedPosts, ...placeholderPosts];
    });
  }

  void _toggleLike(int index) {
    setState(() {
      _newsItems[index]['liked'] = !_newsItems[index]['liked'];
      if (_newsItems[index]['liked']) {
        _newsItems[index]['likes']++;
      } else {
        _newsItems[index]['likes']--;
      }
    });
  }

  void _toggleSave(int index) {
    setState(() {
      _newsItems[index]['saved'] = !_newsItems[index]['saved'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          _newsItems.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : PageView.builder(
                scrollDirection: Axis.vertical,
                controller: _pageController,
                itemCount: _newsItems.length,
                itemBuilder: (context, index) {
                  final item = _newsItems[index];
                  return NewsContentCard(
                    backgroundColor: item['bgColor'],
                    creatorName: item['creatorName'],
                    caption: item['caption'],
                    videoUrl: item['videoUrl'],
                    isLive: item['isLive'],
                    isVideo: item['isVideo'],
                    likes: item['likes'],
                    isLiked: item['liked'],
                    isSaved: item['saved'],
                    comments: item['comments'],
                    onAvatarTap: () {},
                    onCaptionTap: () {},
                    onReadArticle: () {},
                    onSolution: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Solutions(),
                        ),
                      );
                    },
                    onLike: () => _toggleLike(index),
                    onComment: () {},
                    onShare: () {},
                    onSave: () => _toggleSave(index),
                  );
                },
              ),
    );
  }
}

class NewsContentCard extends StatefulWidget {
  final Color backgroundColor;
  final String creatorName;
  final String caption;
  final bool isLive;
  final bool isVideo;
  final String? videoUrl;
  final int likes;
  final bool isLiked;
  final bool isSaved;
  final int comments;
  final VoidCallback onAvatarTap;
  final VoidCallback onCaptionTap;
  final VoidCallback onReadArticle;
  final VoidCallback onSolution;
  final VoidCallback onLike;
  final VoidCallback onComment;
  final VoidCallback onShare;
  final VoidCallback onSave;

  const NewsContentCard({
    super.key,
    required this.backgroundColor,
    required this.creatorName,
    required this.caption,
    this.videoUrl,
    required this.isLive,
    required this.isVideo,
    required this.likes,
    required this.isLiked,
    required this.isSaved,
    required this.comments,
    required this.onAvatarTap,
    required this.onCaptionTap,
    required this.onReadArticle,
    required this.onSolution,
    required this.onLike,
    required this.onComment,
    required this.onShare,
    required this.onSave,
  });

  @override
  State<NewsContentCard> createState() => _NewsContentCardState();
}

class _NewsContentCardState extends State<NewsContentCard> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    if (widget.videoUrl != null && widget.videoUrl!.isNotEmpty) {
      _controller = VideoPlayerController.network(widget.videoUrl!)
        ..initialize().then((_) {
          setState(() {
            _controller!.play();
            _controller!.setLooping(true);
          });
        });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.backgroundColor,
      child: Stack(
        children: [
          Center(
            child:
                widget.isVideo
                    ? (_controller != null && _controller!.value.isInitialized
                        ? GestureDetector(
                          onTap: () {
                            setState(() {
                              if (_controller!.value.isPlaying) {
                                _controller!.pause();
                              } else {
                                _controller!.play();
                              }
                            });
                          },
                          onDoubleTap: widget.onLike,
                          child: AspectRatio(
                            aspectRatio: _controller!.value.aspectRatio,
                            child: VideoPlayer(_controller!),
                          ),
                        )
                        : const CircularProgressIndicator())
                    : const Icon(
                      Icons.article_outlined,
                      size: 100,
                      color: Colors.white,
                    ),
          ),
          Positioned(
            left: 16,
            bottom: 140,
            child: GestureDetector(
              onTap: widget.onAvatarTap,
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, color: Colors.black),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    widget.creatorName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  if (widget.isLive)
                    Container(
                      margin: const EdgeInsets.only(left: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'LIVE',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 16,
            bottom: 90,
            right: 16,
            child: GestureDetector(
              onTap: widget.onCaptionTap,
              child: Text(
                widget.caption,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
          Positioned(
            left: 16,
            bottom: 190,
            child: Row(
              children: [
                InkWell(
                  onTap: widget.onLike,
                  child: Row(
                    children: [
                      Icon(
                        widget.isLiked ? Icons.favorite : Icons.favorite_border,
                        color: widget.isLiked ? Colors.red : Colors.white,
                        size: 24,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        widget.likes.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                InkWell(
                  onTap: widget.onComment,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.comment_outlined,
                        color: Colors.white,
                        size: 24,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        widget.comments.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                InkWell(
                  onTap: widget.onShare,
                  child: const Icon(
                    Icons.share_outlined,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 20),
                InkWell(
                  onTap: widget.onSave,
                  child: Icon(
                    widget.isSaved ? Icons.bookmark : Icons.bookmark_border,
                    color: widget.isSaved ? Colors.yellow : Colors.white,
                    size: 24,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 16,
            bottom: 30,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: widget.onReadArticle,
                  icon: const Icon(Icons.chrome_reader_mode),
                  label: const Text("Read Article"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.8),
                    foregroundColor: Colors.black,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: widget.onSolution,
                  icon: const Icon(Icons.lightbulb),
                  label: const Text("Solution"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.8),
                    foregroundColor: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
