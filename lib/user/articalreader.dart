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
      appBar: AppBar(
        title: const Text('Articles'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              onChanged: (value) => setState(() => searchQuery = value),
              decoration: InputDecoration(
                hintText: 'Search by genre or title...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children:
                  categories.entries.map((entry) {
                    final genre = entry.key;
                    final genreArticles = entry.value;

                    return Padding(
                      padding: const EdgeInsets.only(left: 12, bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            genre,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            height: 200,
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
                                    width: 150,
                                    margin: const EdgeInsets.only(right: 12),
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.teal.shade50,
                                      borderRadius: BorderRadius.circular(10),
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
                                          color: Colors.teal.shade100,
                                          child: const Icon(
                                            Icons.article,
                                            size: 40,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          article['title'],
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
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
              backgroundColor: Colors.teal,
            ),
          ),
        ),
      ),
    );
  }
}

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
      appBar: AppBar(
        title: const Text("Article"),
        backgroundColor: Colors.teal,
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
