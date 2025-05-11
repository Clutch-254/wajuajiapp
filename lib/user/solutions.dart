import 'package:flutter/material.dart';

class Solutions extends StatefulWidget {
  const Solutions({super.key});

  @override
  State<Solutions> createState() => _SolutionsState();
}

class _SolutionsState extends State<Solutions> {
  final List<String> categories = ['Health', 'Housing', 'Justice', 'Education'];
  String selectedCategory = 'Health';

  final Map<String, List<Map<String, dynamic>>> categorizedIssues = {
    'Health': [
      {
        'title': 'Endometriosis Awareness',
        'description': 'Struggles with diagnosis and affordable treatment.',
        'solutions': [
          {
            'text': 'Partner with clinics for subsidized exams.',
            'replies': ['Great idea!', 'Could also offer mobile clinics.'],
          },
        ],
      },
    ],
    'Housing': [
      {
        'title': 'Urban Homelessness',
        'description': 'Need long-term shelter and job support systems.',
        'solutions': [
          {
            'text': 'Crowdfund tiny home villages.',
            'replies': [
              'Similar project worked in Austin!',
              'Need zoning approvals.',
            ],
          },
        ],
      },
    ],
    'Justice': [],
    'Education': [],
  };

  void _addIssue() {
    // TODO: Navigate to add issue screen
  }

  void _addSolution(int issueIndex, String category) {
    // TODO: Navigate to add solution screen
  }

  @override
  Widget build(BuildContext context) {
    final issues = categorizedIssues[selectedCategory]!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Solutions Hub'),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search issues or solutions...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),

          // Horizontal Category Buttons (Like TikTok Discover)
          SizedBox(
            height: 45,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = category == selectedCategory;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCategory = category;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.teal : Colors.grey[300],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        category,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 10),

          // List of Issues
          Expanded(
            child:
                issues.isEmpty
                    ? const Center(
                      child: Text('No issues found in this category.'),
                    )
                    : ListView.builder(
                      itemCount: issues.length,
                      itemBuilder: (context, index) {
                        final issue = issues[index];
                        return Card(
                          margin: const EdgeInsets.all(10),
                          child: ExpansionTile(
                            title: Text(issue['title']),
                            subtitle: Text(issue['description']),
                            children: [
                              const Divider(),
                              ...issue['solutions'].map<Widget>((solution) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '• ${solution['text']}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      ...solution['replies'].map<Widget>(
                                        (reply) => Padding(
                                          padding: const EdgeInsets.only(
                                            left: 12,
                                            top: 4,
                                          ),
                                          child: Text(
                                            '- $reply',
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              // TODO: Add donation logic
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Colors.orangeAccent,
                                            ),
                                            child: const Text('Donate'),
                                          ),
                                          const SizedBox(width: 12),
                                          TextButton(
                                            onPressed: () {
                                              _addSolution(
                                                index,
                                                selectedCategory,
                                              );
                                            },
                                            child: const Text('Add Solution'),
                                          ),
                                        ],
                                      ),
                                      const Divider(),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ],
                          ),
                        );
                      },
                    ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addIssue,
        backgroundColor: Colors.teal,
        tooltip: 'Add New Issue',
        child: const Icon(Icons.add),
      ),
    );
  }
}
