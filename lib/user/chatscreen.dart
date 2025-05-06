
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
    {
      'title': 'New message in Pop Culture Forum',
      'time': '5m ago',
    },
    {
      'title': 'Mentioned in a thread: Flutter Help',
      'time': '1h ago',
    },
    {
      'title': 'New reply from AnimeFan2025',
      'time': '3h ago',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats & Notifications'),
        backgroundColor: Colors.deepPurple,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Chats'),
            Tab(text: 'Notifications'),
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
                  child: Icon(chat['isGroup'] ? Icons.group : Icons.person),
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
                leading: const Icon(Icons.notifications),
                title: Text(notif['title']),
                trailing: Text(
                  notif['time'],
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Create new chat, navigate to new message screen, etc.
        },
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.chat),
      ),
    );
  }
}
