import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mjuajiapp0/user/post_video_screen.dart';

class Profilescreen extends StatefulWidget {
  const Profilescreen({super.key});

  @override
  State<Profilescreen> createState() => _ProfilescreenState();
}

class _ProfilescreenState extends State<Profilescreen> {
  String username = '';
  String bio = '';
  int subscriberCount = 0;
  int collaboratorCount = 0;
  bool showCreatedContent = false;
  bool showSavedContent = false;

  // Fetch user data from Firestore
  Future<void> _fetchUserProfile() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final doc =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .get();

      if (doc.exists) {
        setState(() {
          username = doc['username'] ?? 'User123';
          bio = doc['bio'] ?? 'This is a short bio about the user.';
          subscriberCount = doc['subscriberCount'] ?? 0;
          collaboratorCount = doc['collaboratorCount'] ?? 0;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  // Content creation options dialog
  void _showContentCreationOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Create Content',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 20),
              _buildContentOption(
                context,
                Icons.videocam_outlined,
                'Post Video',
                () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => PostVideoScreen()),
                  );
                },
              ),
              _buildContentOption(
                context,
                Icons.live_tv_outlined,
                'Start Live',
                () {
                  Navigator.pop(context);
                },
              ),
              _buildContentOption(
                context,
                Icons.article_outlined,
                'Write Article',
                () {
                  Navigator.pop(context);
                },
              ),
              _buildContentOption(
                context,
                Icons.movie_creation_outlined,
                'Post Entertainment',
                () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Helper method to build content creation options
  Widget _buildContentOption(
    BuildContext context,
    IconData icon,
    String title,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(title),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Colors.black),
            onPressed: () {
              // TODO: Navigate to settings
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Profile Picture
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.black,
                child: const Icon(Icons.person, size: 50, color: Colors.white),
              ),
            ),
            const SizedBox(height: 10),
            // Username and Edit Profile
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Text(
                    username,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          // TODO: Implement edit profile
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.black),
                          foregroundColor: Colors.black,
                        ),
                        child: const Text("Edit Profile"),
                      ),
                      const SizedBox(width: 10),
                      OutlinedButton(
                        onPressed: () {
                          // TODO: Implement collaborate functionality
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.black),
                          foregroundColor: Colors.black,
                        ),
                        child: const Text("Collaborate"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Bio
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
              child: Text(
                bio,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ),
            const SizedBox(height: 10),
            // Subscriber and Collaborator Count Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    // TODO: Show subscriber list
                  },
                  style: TextButton.styleFrom(foregroundColor: Colors.black),
                  child: Text('$subscriberCount Subscribers'),
                ),
                const SizedBox(width: 16),
                TextButton(
                  onPressed: () {
                    // TODO: Show collaborator list
                  },
                  style: TextButton.styleFrom(foregroundColor: Colors.black),
                  child: Text('$collaboratorCount Collaborators'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Action Buttons: Create, Bookmark, and Created Content
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    _showContentCreationOptions(context);

                    setState(() {
                      showCreatedContent = false;
                      showSavedContent = false;
                    });
                  },
                  icon: const Icon(
                    Icons.add_circle_outline,
                    color: Colors.black,
                  ),
                  tooltip: 'Create Content',
                  iconSize: 30,
                ),
                const SizedBox(width: 30),
                IconButton(
                  onPressed: () {
                    setState(() {
                      showSavedContent = !showSavedContent;
                      showCreatedContent = false;
                    });
                  },
                  icon: Icon(
                    showSavedContent ? Icons.bookmark : Icons.bookmark_border,
                    color: Colors.black,
                  ),
                  tooltip: 'Saved Content',
                  iconSize: 30,
                ),
                const SizedBox(width: 30),
                IconButton(
                  onPressed: () {
                    setState(() {
                      showCreatedContent = !showCreatedContent;
                      showSavedContent = false;
                    });
                  },
                  icon: Icon(
                    showCreatedContent
                        ? Icons.grid_on
                        : Icons.grid_view_rounded,
                    color: Colors.black,
                  ),
                  tooltip: 'My Content',
                  iconSize: 30,
                ),
              ],
            ),
            const Divider(height: 40, color: Colors.black12),
            // Conditional Content Display
            if (showCreatedContent)
              _buildCreatedContentSection()
            else if (showSavedContent)
              _buildSavedContentSection()
            else
              const Padding(
                padding: EdgeInsets.all(20),
                child: Center(
                  child: Text(
                    "Select an option above to view your content",
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Created Content Section
  Widget _buildCreatedContentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "My Created Content",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        Container(
          height: 100,
          margin: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black12),
          ),
          child: const Center(child: Text("Created content placeholder")),
        ),
      ],
    );
  }

  // Saved Content Section
  Widget _buildSavedContentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "Saved Videos",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        Container(
          height: 100,
          margin: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black12),
          ),
          child: const Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.play_circle_outline, color: Colors.black),
                SizedBox(width: 8),
                Text("Video content placeholder"),
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "Saved Comics",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        Container(
          height: 100,
          margin: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black12),
          ),
          child: const Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.auto_stories_outlined, color: Colors.black),
                SizedBox(width: 8),
                Text("Comics content placeholder"),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
