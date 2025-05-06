
import 'package:flutter/material.dart';

class Entertainmenthub extends StatefulWidget {
  const Entertainmenthub({super.key});

  @override
  State<Entertainmenthub> createState() => _EntertainmenthubState();
}

class _EntertainmenthubState extends State<Entertainmenthub> {
  final TextEditingController _searchController = TextEditingController();
  String selectedCategory = 'Comics';

  final List<String> categories = ['Comics', 'Manga', 'Webtoons', 'Novels'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entertainment Hub'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search by title or genre...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) {
                // Implement search filtering logic here
              },
            ),
          ),

          // Category Filter Row
          SizedBox(
            height: 50,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = selectedCategory == category;
                return ChoiceChip(
                  label: Text(category),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      selectedCategory = category;
                      // Refresh content for selected category
                    });
                  },
                  selectedColor: Colors.deepPurpleAccent,
                  backgroundColor: Colors.grey[200],
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 20),

          // Category Content Placeholder
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: 5, // Adjust based on data
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: ListTile(
                    leading: Container(
                      width: 60,
                      height: 60,
                      color: Colors.deepPurple[100],
                      child: const Icon(Icons.book),
                    ),
                    title: Text('$selectedCategory Title ${index + 1}'),
                    subtitle: const Text('Genre • Author • Description...'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      // Navigate to content details
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
