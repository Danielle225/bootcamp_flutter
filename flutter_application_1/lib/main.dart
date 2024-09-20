import 'package:flutter/material.dart';
import 'pages/chat_screen.dart'; // Assure-toi que l'import correspond au bon chemin
// import 'pages/user_profile_screen.dart';  // Assure-toi d'importer l'écran de profil, si nécessaire

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
        primaryColor: const Color(0xFF075E54),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: const Color(0xFF25D366),
        ),
        fontFamily: 'CustomFont', // Utilise ici le nom de la famille de police que tu as définie
      ),
      home: const ConversationListScreen(), // Page d'accueil
      // Supprime ou remplace la route pour le profil utilisateur si elle n'est plus nécessaire
      // routes: {
      //   '/profile': (context) => UserProfileScreen(), // Si l'écran n'existe plus, retire ceci
      // },
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
    {'name': 'Alice', 'image': 'assets/profile1.png', 'message': 'Hey!'},
    {'name': 'Bob', 'image': 'assets/profile2.png', 'message': 'How are you?'},
    {'name': 'Charlie', 'image': 'assets/profile3.png', 'message': 'Let\'s meet tomorrow.'},
    {'name': 'David', 'image': 'assets/profile4.png', 'message': 'I\'m on my way.'},
    {'name': 'Eve', 'image': 'assets/profile5.png', 'message': 'Can you call me?'},
    {'name': 'Eve', 'image': 'assets/profile5.png', 'message': 'Can you call me?'},
  ];

  TextEditingController searchController = TextEditingController();
  List<Map<String, String>> filteredConversations = [];
  bool _showSearchBar = false;

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

  void _toggleSearchBar() {
    setState(() {
      _showSearchBar = !_showSearchBar;
      if (!_showSearchBar) {
        // Réinitialise la recherche quand la barre de recherche est fermée
        filteredConversations = conversations;
        searchController.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF075E54),
        title: const Text("Chats"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: _toggleSearchBar,
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          if (_showSearchBar)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                onChanged: _filterConversations,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredConversations.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    const Divider(height: 1),
                    ListTile(
                      leading: CircleAvatar(
                        radius: 28,
                        backgroundImage:
                            AssetImage(filteredConversations[index]['image']!),
                        onBackgroundImageError: (exception, stackTrace) {
                          print(
                              'Image not found for ${filteredConversations[index]['name']}');
                        },
                      ),
                      title: Text(
                        filteredConversations[index]['name']!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        filteredConversations[index]['message']!,
                        style: const TextStyle(color: Colors.grey),
                      ),
                      trailing: const Text(
                        '12:30 PM',
                        style: TextStyle(color: Colors.grey),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatScreen(
                              userName: filteredConversations[index]['name']!,
                              profileImage:
                                  filteredConversations[index]['image']!,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
