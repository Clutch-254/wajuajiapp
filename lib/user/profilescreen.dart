import 'package:flutter/material.dart';

class Profilescreen extends StatefulWidget {
  const Profilescreen({super.key});

  @override
  State<Profilescreen> createState() => _ProfilescreenState();
}

class _ProfilescreenState extends State<Profilescreen> {
  String username = 'User123';
  String bio = 'This is a short bio about the user.';
  int subscriberCount = 128;
  int collaboratorCount = 14;
  bool showCreatedContent = false;

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
                    // TODO: Navigate to content creation
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
                    // TODO: Navigate to saved/bookmarked content
                  },
                  icon: const Icon(Icons.bookmark_border, color: Colors.black),
                  tooltip: 'Saved Content',
                  iconSize: 30,
                ),
                const SizedBox(width: 30),
                IconButton(
                  onPressed: () {
                    setState(() {
                      showCreatedContent = !showCreatedContent;
                    });
                  },
                  icon: const Icon(
                    Icons.grid_view_rounded,
                    color: Colors.black,
                  ),
                  tooltip: 'My Content',
                  iconSize: 30,
                ),
              ],
            ),

            const Divider(height: 40, color: Colors.black12),

            // Conditional: Created Content or Saved Content
            if (showCreatedContent)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "My Created Content",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
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
                      child: Text("Created content placeholder"),
                    ),
                  ),
                ],
              )
            else
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "Saved Videos",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
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
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
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
                          Icon(
                            Icons.auto_stories_outlined,
                            color: Colors.black,
                          ),
                          SizedBox(width: 8),
                          Text("Comics content placeholder"),
                        ],
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "Saved Articles",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
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
                          Icon(Icons.article_outlined, color: Colors.black),
                          SizedBox(width: 8),
                          Text("Article content placeholder"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
