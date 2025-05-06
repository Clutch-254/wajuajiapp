
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
        title: const Text("Profile"),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Profile Picture
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey[300],
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
                        child: const Text("Edit Profile"),
                      ),
                      const SizedBox(width: 10),
                      OutlinedButton(
                        onPressed: () {
                          // TODO: Implement collaborate functionality
                        },
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
                  child: Text('$subscriberCount Subscribers'),
                ),
                const SizedBox(width: 16),
                TextButton(
                  onPressed: () {
                    // TODO: Show collaborator list
                  },
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
                  icon: const Icon(Icons.add_circle_outline),
                  tooltip: 'Create Content',
                  iconSize: 30,
                ),
                const SizedBox(width: 30),
                IconButton(
                  onPressed: () {
                    // TODO: Navigate to saved/bookmarked content
                  },
                  icon: const Icon(Icons.bookmark_border),
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
                  icon: const Icon(Icons.grid_view_rounded),
                  tooltip: 'My Content',
                  iconSize: 30,
                ),
              ],
            ),

            const Divider(height: 40),

            // Conditional: Created Content or Saved Content
            if (showCreatedContent)
              Column(
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
                    color: Colors.teal[50],
                    child: const Center(child: Text("Created content placeholder")),
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
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  Container(
                    height: 100,
                    margin: const EdgeInsets.all(12),
                    color: Colors.grey[200],
                    child: const Center(child: Text("Video content placeholder")),
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
                    color: Colors.grey[200],
                    child: const Center(child: Text("Comics content placeholder")),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "Saved Articles",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  Container(
                    height: 100,
                    margin: const EdgeInsets.all(12),
                    color: Colors.grey[200],
                    child: const Center(child: Text("Article content placeholder")),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
