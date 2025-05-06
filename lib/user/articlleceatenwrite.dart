import 'package:flutter/material.dart';

class Articlleceatenwrite extends StatefulWidget {
  const Articlleceatenwrite({super.key});

  @override
  State<Articlleceatenwrite> createState() => _ArticlleceatenwriteState();
}

class _ArticlleceatenwriteState extends State<Articlleceatenwrite> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  final List<Map<String, String>> _articles = [];

  void _submitArticle() {
    if (_titleController.text.isNotEmpty &&
        _contentController.text.isNotEmpty) {
      setState(() {
        _articles.add({
          'title': _titleController.text,
          'content': _contentController.text,
        });
        _titleController.clear();
        _contentController.clear();
      });
    }
  }

  void _addChart() {
    // Placeholder for chart logic
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Insert Pie Chart / Bar Graph - Coming Soon!'),
      ),
    );
  }

  void _addMedia() {
    // Placeholder for media logic
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Insert Image / Video - Coming Soon!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Article Creator"),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: const Icon(Icons.pie_chart),
            onPressed: _addChart,
            tooltip: "Add Data Visualization",
          ),
          IconButton(
            icon: const Icon(Icons.image),
            onPressed: _addMedia,
            tooltip: "Add Images/Videos",
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text(
              "Write New Article",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Title input
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            // Content input
            TextField(
              controller: _contentController,
              decoration: const InputDecoration(
                labelText: 'Content',
                border: OutlineInputBorder(),
              ),
              maxLines: 6,
            ),
            const SizedBox(height: 10),

            ElevatedButton.icon(
              onPressed: _submitArticle,
              icon: const Icon(Icons.send),
              label: const Text("Publish Article"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
              ),
            ),

            const Divider(height: 30),

            const Text(
              "Previously Written Articles",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            if (_articles.isEmpty)
              const Text(
                "No articles yet. Start writing!",
                textAlign: TextAlign.center,
              )
            else
              ..._articles.map((article) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: Text(article['title'] ?? ''),
                    subtitle: Text(
                      article['content']!.length > 100
                          ? "${article['content']!.substring(0, 100)}..."
                          : article['content']!,
                    ),
                    trailing: const Icon(Icons.article),
                  ),
                );
              }),
          ],
        ),
      ),
    );
  }
}
