
import 'package:flutter/material.dart';

class Entertaimentcreation extends StatefulWidget {
  const Entertaimentcreation({super.key});

  @override
  State<Entertaimentcreation> createState() => _EntertaimentcreationState();
}

class _EntertaimentcreationState extends State<Entertaimentcreation> {
  String selectedType = 'Novel';
  final List<String> contentTypes = ['Novel', 'Comic', 'Manga', 'Webtoon'];

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController genreController = TextEditingController();

  void handleSubmit() {
    // Logic to upload or save content
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Content submitted!')),
    );

    // Clear form
    titleController.clear();
    descriptionController.clear();
    genreController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Content'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              'Select Content Type',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Wrap(
              spacing: 10,
              children: contentTypes.map((type) {
                return ChoiceChip(
                  label: Text(type),
                  selected: selectedType == type,
                  onSelected: (selected) {
                    setState(() {
                      selectedType = type;
                    });
                  },
                  selectedColor: Colors.deepPurpleAccent,
                );
              }).toList(),
            ),
            const SizedBox(height: 20),

            // Title
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),

            // Genre
            TextField(
              controller: genreController,
              decoration: const InputDecoration(
                labelText: 'Genre',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),

            // Description or Story
            TextField(
              controller: descriptionController,
              maxLines: 6,
              decoration: InputDecoration(
                labelText: selectedType == 'Novel'
                    ? 'Write your story'
                    : 'Description or upload instructions',
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Submit Button
            ElevatedButton.icon(
              onPressed: handleSubmit,
              icon: const Icon(Icons.publish),
              label: const Text('Publish'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),

            const SizedBox(height: 20),

            // Placeholder for future image/file upload
            Container(
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: Text(
                selectedType == 'Novel'
                    ? 'Text-only content'
                    : 'Tap to upload pages or cover (coming soon)',
                style: const TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
