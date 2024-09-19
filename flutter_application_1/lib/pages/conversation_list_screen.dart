import 'package:flutter/material.dart';

class ConversationListScreen extends StatefulWidget {
  const ConversationListScreen({super.key});

  @override
  _ConversationListScreenState createState() => _ConversationListScreenState();
}

class _ConversationListScreenState extends State<ConversationListScreen> {
  List<Map<String, String>> conversations = [
    {'name': 'Alice', 'image': 'assets/profile1.png', 'message': 'Hey!'},
    {'name': 'Bob', 'image': 'assets/profile2.png', 'message': 'How are you?'},
    // ... autres conversations
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF075E54),
        title: const Text("Chats"),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserProfileScreen(), // Ouvrir l'écran de profil utilisateur
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: conversations.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(conversations[index]['image']!),
            ),
            title: Text(conversations[index]['name']!),
            subtitle: Text(conversations[index]['message']!),
            // Gérer les actions de l'item ici
          );
        },
      ),
    );
  }
}
