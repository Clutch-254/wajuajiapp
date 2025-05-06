import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mjuajiapp0/user/solutions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _NewsHomeScreenState();
}

class _NewsHomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();

  final List<Map<String, dynamic>> _newsItems = [
    //place holders for the content before we complete it and make it more functional
    {
      'creatorName': 'Dr. Alice Waweru',
      'avatar':
          null, // tutareplace with actual image baadae its just a place  holder
      'caption': 'Endometriosis Awareness - Live Now!',
      'isLive': true,
      'isVideo': true,
      'bgColor': Colors.teal.shade200,
    },
    {
      'creatorName': 'Health Weekly',
      'avatar': null, // same here
      'caption': 'New research shows promising treatment options',
      'isLive': false,
      'isVideo': true,
      'bgColor': Colors.blue.shade200,
    },
    {
      'creatorName': 'Politics Daily',
      'avatar': null,
      'caption': 'Breaking down the new healthcare policy',
      'isLive': false,
      'isVideo': false,
      'bgColor': Colors.deepOrange.shade200,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        controller: _pageController,
        itemCount: _newsItems.length,
        itemBuilder: (context, index) {
          final item = _newsItems[index];
          return NewsContentCard(
            backgroundColor: item['bgColor'],
            creatorName: item['creatorName'],
            caption: item['caption'],
            isLive: item['isLive'],
            isVideo: item['isVideo'],
            onAvatarTap: () {
              // Placeholder for avatar/username navigation
              debugPrint('will navigate to creator profile');
            },
            onCaptionTap: () {
              // Placeholder for caption navigation
              debugPrint('will mavigate to full post');
            },
            onReadArticle: () {
              // Placeholder for article navigation
              debugPrint('Will navigate to article');
            },
            onSolution: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Solutions()),
              );
            },
          );
        },
      ),
    );
  }
}

class NewsContentCard extends StatelessWidget {
  final Color backgroundColor;
  final String creatorName;
  final String caption;
  final bool isLive;
  final bool isVideo;
  final VoidCallback onAvatarTap;
  final VoidCallback onCaptionTap;
  final VoidCallback onReadArticle;
  final VoidCallback onSolution;

  const NewsContentCard({
    Key? key,
    required this.backgroundColor,
    required this.creatorName,
    required this.caption,
    required this.isLive,
    required this.isVideo,
    required this.onAvatarTap,
    required this.onCaptionTap,
    required this.onReadArticle,
    required this.onSolution,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Stack(
        children: [
          Center(
            child:
                isVideo
                    ? Icon(
                      isLive ? Icons.wifi_tethering : Icons.play_circle_fill,
                      size: 100,
                      color: Colors.white,
                    )
                    : Icon(
                      Icons.article_outlined,
                      size: 100,
                      color: Colors.white,
                    ),
          ),
          Positioned(
            left: 16,
            bottom: 140,
            child: GestureDetector(
              onTap: onAvatarTap,
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, color: Colors.black),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    creatorName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  if (isLive)
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
              onTap: onCaptionTap,
              child: Text(
                caption,
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
            bottom: 30,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //navigates user to the article where they can read more
                ElevatedButton.icon(
                  onPressed: onReadArticle,
                  icon: const Icon(Icons.chrome_reader_mode),
                  label: const Text("Read Article"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.8),
                    foregroundColor: Colors.black,
                  ),
                ),

                //button that will navigate user to the solution page of that specific issue or content
                ElevatedButton.icon(
                  onPressed: onSolution,
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
