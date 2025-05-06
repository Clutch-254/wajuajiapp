import 'package:flutter/material.dart';

class Newsection extends StatefulWidget {
  const Newsection({super.key});

  @override
  State<Newsection> createState() => _NewsectionState();
}

class _NewsectionState extends State<Newsection> {
  String searchQuery = '';

  final List<Map<String, String>> newsContent = [
    {
      'title': 'Election 2025: What to Expect',
      'category': 'Politics',
      'creator': 'KTN Politics',
      'type': 'recorded',
      'description': 'A deep dive into what this year\'s election holds...',
    },
    {
      'title': 'AnimeCon Live Coverage',
      'category': 'Anime',
      'creator': 'Otaku Central',
      'type': 'live',
      'description': 'Live from the AnimeCon stage, bringing exclusive news...',
    },
    {
      'title': 'Taylor Swift Breaks Records',
      'category': 'Pop Culture',
      'creator': 'NTV News',
      'type': 'recorded',
      'description': 'Her latest tour sets historic new numbers...',
    },
    {
      'title': 'New One Piece Episode Explained',
      'category': 'Anime',
      'creator': 'AnimeExplained',
      'type': 'recorded',
      'description':
          'A breakdown of the major moments in the latest episode...',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredNews =
        newsContent.where((news) {
          final query = searchQuery.toLowerCase();
          return news['title']!.toLowerCase().contains(query) ||
              news['category']!.toLowerCase().contains(query) ||
              news['creator']!.toLowerCase().contains(query);
        }).toList();

    final categories = {
      for (var item in filteredNews)
        item['category']!:
            filteredNews
                .where((n) => n['category'] == item['category'])
                .toList(),
    };

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // AppBar replacement
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                children: const [
                  Text(
                    'News Feed',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),

            // Search bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: TextField(
                onChanged: (value) => setState(() => searchQuery = value),
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: 'Search news, genres, or creators...',
                  hintStyle: TextStyle(color: Colors.grey[600]),
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // News categories + items
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(bottom: 16),
                children:
                    categories.entries.map((entry) {
                      final category = entry.key;
                      final newsList = entry.value;

                      return Padding(
                        padding: const EdgeInsets.only(left: 12, bottom: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              category,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              height: 250, // Increased to fix overflow
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: newsList.length,
                                itemBuilder: (context, index) {
                                  final item = newsList[index];
                                  final isLive = item['type'] == 'live';

                                  return Container(
                                    width: 180,
                                    margin: const EdgeInsets.only(right: 12),
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 4,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 100,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color:
                                                isLive
                                                    ? Colors.red.shade400
                                                    : Colors.grey.shade400,
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              isLive ? 'LIVE' : 'RECORDED',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          item['title']!,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          item['creator']!,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Expanded(
                                          child: Text(
                                            item['description']!,
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
