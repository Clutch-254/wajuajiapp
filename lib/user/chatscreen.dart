import 'package:flutter/material.dart';

class Chatscreen extends StatefulWidget {
  const Chatscreen({super.key});

  @override
  State<Chatscreen> createState() => _ChatscreenState();
}

class _ChatscreenState extends State<Chatscreen> with TickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> chats = [
    {
      'name': 'Flutter Devs Forum',
      'lastMessage': 'Let\'s discuss the new update...',
      'timestamp': '2h ago',
      'isGroup': true,
    },
    {
      'name': 'Anime World Community',
      'lastMessage': 'Episode 1000 was insane!',
      'timestamp': '5h ago',
      'isGroup': true,
    },
    {
      'name': 'Alex_32',
      'lastMessage': 'Are you joining the live stream?',
      'timestamp': '1d ago',
      'isGroup': false,
    },
  ];

  final List<Map<String, dynamic>> notifications = [
    {'title': 'New message in Pop Culture Forum', 'time': '5m ago'},
    {'title': 'Mentioned in a thread: Flutter Help', 'time': '1h ago'},
    {'title': 'New reply from AnimeFan2025', 'time': '3h ago'},
  ];

  final List<Map<String, String>> solutions = [
    {
      'issue': 'Homelessness in Urban Areas',
      'solution': 'City-funded shelters and job programs.',
    },
    {
      'issue': 'Endometriosis Awareness',
      'solution': 'Educational campaigns and subsidized healthcare.',
    },
    {
      'issue': 'Climate Change',
      'solution': 'Community tree planting initiatives.',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.black,
          tabs: const [
            Tab(icon: Icon(Icons.chat_bubble_outline)),
            Tab(icon: Icon(Icons.notifications_outlined)),
            Tab(icon: Icon(Icons.lightbulb_outline)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Chats Tab
          ListView.builder(
            itemCount: chats.length,
            itemBuilder: (context, index) {
              final chat = chats[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.black,
                  child: Icon(
                    chat['isGroup'] ? Icons.group : Icons.person,
                    color: Colors.white,
                  ),
                ),
                title: Text(chat['name']),
                subtitle: Text(chat['lastMessage']),
                trailing: Text(chat['timestamp']),
                onTap: () {
                  // TODO: Navigate to chat detail screen
                },
              );
            },
          ),

          // Notifications Tab
          ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notif = notifications[index];
              return ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.black,
                  child: Icon(
                    Icons.notifications_outlined,
                    color: Colors.white,
                  ),
                ),
                title: Text(notif['title']),
                trailing: Text(
                  notif['time'],
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              );
            },
          ),

          // Solutions Tab
          ListView.builder(
            itemCount: solutions.length,
            itemBuilder: (context, index) {
              final item = solutions[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  title: Text(
                    item['issue']!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(item['solution']!),
                  trailing: const Icon(
                    Icons.lightbulb_outline,
                    color: Colors.black,
                  ),
                  onTap: () {
                    // TODO: Navigate to full solution detail or discussion
                  },
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Create new chat or add solution
        },
        backgroundColor: Colors.black,
        child: const Icon(Icons.chat, color: Colors.white),
      ),
    );
  }
}
