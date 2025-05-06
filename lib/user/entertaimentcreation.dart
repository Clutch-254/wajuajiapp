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
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Content submitted!')));

    // Clear form
    titleController.clear();
    descriptionController.clear();
    genreController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create New Content',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
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
              children:
                  contentTypes.map((type) {
                    return ChoiceChip(
                      label: Text(
                        type,
                        style: TextStyle(
                          color:
                              selectedType == type
                                  ? Colors.white
                                  : Colors.black,
                        ),
                      ),
                      selected: selectedType == type,
                      onSelected: (selected) {
                        setState(() {
                          selectedType = type;
                        });
                      },
                      selectedColor: Colors.black,
                      backgroundColor: Colors.grey[200],
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
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Genre
            TextField(
              controller: genreController,
              decoration: const InputDecoration(
                labelText: 'Genre',
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Description or Story
            TextField(
              controller: descriptionController,
              maxLines: 6,
              decoration: InputDecoration(
                labelText:
                    selectedType == 'Novel'
                        ? 'Write your story'
                        : 'Description or upload instructions',
                border: const OutlineInputBorder(),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Submit Button
            ElevatedButton.icon(
              onPressed: handleSubmit,
              icon: const Icon(Icons.publish),
              label: const Text('Publish'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Placeholder for future image/file upload
            Container(
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black12),
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    selectedType == 'Novel'
                        ? Icons.text_fields
                        : Icons.file_upload_outlined,
                    color: Colors.black54,
                    size: 28,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    selectedType == 'Novel'
                        ? 'Text-only content'
                        : 'Tap to upload pages or cover (coming soon)',
                    style: const TextStyle(color: Colors.black54),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    genreController.dispose();
    super.dispose();
  }
}
