import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String userName;
  final String profileImage;

  const ChatScreen({
    Key? key,
    required this.userName,
    required this.profileImage,
  }) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<String> messages = [];
  TextEditingController messageController = TextEditingController();

  void _sendMessage() {
    String newMessage = messageController.text.trim();

    if (newMessage.isNotEmpty) {
      setState(() {
        messages.add(newMessage); // Ajoute le message à la liste des messages
        messageController.clear(); // Vide le champ de saisie après l'envoi
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(widget.profileImage),
              onBackgroundImageError: (exception, stackTrace) {
                print('Image not found for ${widget.userName}');
              },
            ),
            const SizedBox(width: 10),
            Text(widget.userName),
          ],
        ),
        backgroundColor: const Color(0xFF075E54),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 10.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFF25D366),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Text(
                      messages[index],
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: "Type your message...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 15.0),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  icon: const Icon(Icons.send),
                  color: const Color(0xFF25D366),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}