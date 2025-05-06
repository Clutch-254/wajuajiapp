import 'package:flutter/material.dart';
import 'package:mjuajiapp0/user/articlleceatenwrite.dart';

class ArticleReader extends StatefulWidget {
  const ArticleReader({super.key});

  @override
  State<ArticleReader> createState() => _ArticleReaderState();
}

class _ArticleReaderState extends State<ArticleReader> {
  String searchQuery = '';

  final List<Map<String, dynamic>> articles = [
    {
      'title': 'Understanding Endometriosis',
      'genre': 'Health',
      'author': 'Dr. Alice Waweru',
      'content':
          'Endometriosis is a painful condition that affects 1 in 10 women. In this article, we break down the symptoms, treatments, and ongoing research...',
      'thumbnail': null,
    },
    {
      'title': 'Healthcare Policy Updates 2025',
      'genre': 'Politics',
      'author': 'Health Weekly',
      'content':
          'The new healthcare policies proposed this year aim to improve accessibility and reduce cost. Here’s what you need to know...',
      'thumbnail': null,
    },
    {
      'title': 'Eating Healthy on a Budget',
      'genre': 'Health',
      'author': 'Nutrition Daily',
      'content':
          'Many think eating healthy is expensive, but there are ways to make it affordable. This article explores tips and tricks...',
      'thumbnail': null,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredArticles =
        articles.where((article) {
          final query = searchQuery.toLowerCase();
          return article['title'].toLowerCase().contains(query) ||
              article['genre'].toLowerCase().contains(query);
        }).toList();

    final categories = {
      for (var article in filteredArticles)
        article['genre']:
            filteredArticles
                .where((a) => a['genre'] == article['genre'])
                .toList(),
    };

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                children: const [
                  Text(
                    'Articles',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),

            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: TextField(
                onChanged: (value) => setState(() => searchQuery = value),
                decoration: InputDecoration(
                  hintText: 'Search by genre or title...',
                  hintStyle: TextStyle(color: Colors.grey[600]),
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Article List by Genre
            Expanded(
              child: ListView(
                children:
                    categories.entries.map((entry) {
                      final genre = entry.key;
                      final genreArticles = entry.value;

                      return Padding(
                        padding: const EdgeInsets.only(left: 12, bottom: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              genre,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              height: 220,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: genreArticles.length,
                                itemBuilder: (context, index) {
                                  final article = genreArticles[index];

                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (_) => ArticleDetailScreen(
                                                title: article['title'],
                                                author: article['author'],
                                                content: article['content'],
                                              ),
                                        ),
                                      );
                                    },
                                    child: Container(
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
                                              color: Colors.grey[400],
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: const Center(
                                              child: Icon(
                                                Icons.article,
                                                size: 40,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            article['title'],
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
                                            article['author'],
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
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

      // Write Article Button
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Articlleceatenwrite(),
                ),
              );
            },
            icon: const Icon(Icons.edit),
            label: const Text("Write"),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

// Detailed View for Articles
class ArticleDetailScreen extends StatelessWidget {
  final String title;
  final String author;
  final String content;

  const ArticleDetailScreen({
    super.key,
    required this.title,
    required this.author,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Article"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              "By $author",
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            Text(content, style: const TextStyle(fontSize: 16, height: 1.5)),
          ],
        ),
      ),
    );
  }
}
