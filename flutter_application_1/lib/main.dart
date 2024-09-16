import 'package:flutter/material.dart';
import 'pages/chat_screen.dart';
 // Assure-toi que l'import correspond au bon chemin

void main() {
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Messagerie',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'CustomFont', // Utilise ici le nom de la famille de police que tu as défini
        textTheme: const TextTheme(
        ),
      ),
      home: const ConversationListScreen(),
    );
  }
}

class ConversationListScreen extends StatefulWidget {
  const ConversationListScreen({super.key});

  @override
  _ConversationListScreenState createState() => _ConversationListScreenState();
}

class _ConversationListScreenState extends State<ConversationListScreen> {
  List<Map<String, String>> conversations = [
    {'name': 'Alice', 'image': 'assets/profile1.png'},
    {'name': 'Bob', 'image': 'assets/profile2.png'},
    {'name': 'Charlie', 'image': 'assets/profile3.png'},
    {'name': 'David', 'image': 'assets/profile4.png'},
    {'name': 'Eve', 'image': 'assets/profile5.png'},
  ];

  TextEditingController searchController = TextEditingController();
  List<Map<String, String>> filteredConversations = [];

  @override
  void initState() {
    super.initState();
    filteredConversations = conversations;
  }

  void _filterConversations(String query) {
    setState(() {
      filteredConversations = conversations
          .where((conversation) =>
              conversation['name']!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Conversations récentes"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: _filterConversations,
              decoration: const InputDecoration(
                hintText: 'Rechercher des conversations...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredConversations.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(filteredConversations[index]['image']!),
                  ),
                  title: Text(filteredConversations[index]['name']!),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(
                          userName: filteredConversations[index]['name']!,
                          profileImage: filteredConversations[index]['image']!,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
