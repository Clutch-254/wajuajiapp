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
      appBar: AppBar(
        title: const Text('Curated News'),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              onChanged: (value) => setState(() => searchQuery = value),
              decoration: InputDecoration(
                hintText: 'Search news, genres, or creators...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
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
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 220,
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
                                    color: Colors.deepPurple.shade50,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
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
                                                  ? Colors.red.shade200
                                                  : Colors.grey.shade300,
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
                                      const SizedBox(height: 10),
                                      Text(
                                        item['title']!,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
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
                                      Text(
                                        item['description']!,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(fontSize: 12),
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
    );
  }
}
