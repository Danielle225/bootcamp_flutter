import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  File? _profileImage;
  TextEditingController nameController = TextEditingController();
  TextEditingController statusController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialisation avec des informations utilisateur fictives
    nameController.text = "John Doe";
    statusController.text = "Hey there! I'm using the chat app.";
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  void _saveProfile() {
    // Logique de sauvegarde des informations
    String updatedName = nameController.text;
    String updatedStatus = statusController.text;

    // Affiche un message de confirmation pour montrer que les données sont enregistrées
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Profile updated!')),
    );
    
    // Tu peux ajouter la logique pour enregistrer ces informations dans Firebase ou une base de données
  }

  void _sendMessage() {
    // Logique pour envoyer un message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Message envoyé !')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        backgroundColor: const Color(0xFF075E54),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveProfile, // Sauvegarde des informations
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: _pickImage, // Choisir une nouvelle image
              child: CircleAvatar(
                radius: 60,
                backgroundImage: _profileImage != null
                    ? FileImage(_profileImage!)
                    : const AssetImage('assets/default_profile.png')
                        as ImageProvider,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomRight,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 18,
                        child: const Icon(
                          Icons.camera_alt,
                          color: Color(0xFF075E54),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Name",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: statusController,
              decoration: const InputDecoration(
                labelText: "Status",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.info),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: _saveProfile,
              icon: const Icon(Icons.save),
              label: const Text("Save"),
              style: ElevatedButton.styleFrom(
                primary: const Color(0xFF25D366),
              ),
            ),
            const SizedBox(height: 20),
            // Nouveau bouton pour envoyer un message
            ElevatedButton.icon(
              onPressed: _sendMessage, // Logique pour envoyer un message
              icon: const Icon(Icons.message),
              label: const Text("Envoyer un nouveau message"),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue, // Couleur du bouton
              ),
            ),
          ],
        ),
      ),
    );
  }
}
