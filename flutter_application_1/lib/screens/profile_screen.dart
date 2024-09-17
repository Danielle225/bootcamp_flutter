import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _name = 'John Doe';
  String _status = 'En ligne';
  final String _profilePic = 'https://via.placeholder.com/150';

  void _logout() {
    Navigator.pop(context); // Retour à l'écran précédent
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Utilisateur'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(_profilePic),
            ),
            const SizedBox(height: 20),
            // Champ pour nom utilisateur
            TextFormField(
              initialValue: _name,
              decoration: const InputDecoration(labelText: 'Nom'),
              onChanged: (value) {
                setState(() {
                  _name = value;
                });
              },
            ),
            // Champ pour statut utilisateur
            TextFormField(
              initialValue: _status,
              decoration: const InputDecoration(labelText: 'Statut'),
              onChanged: (value) {
                setState(() {
                  _status = value;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Logique de sauvegarde des informations modifiées
                if (kDebugMode) {
                  print('Informations sauvegardées');
                }
              },
              child: const Text('Sauvegarder'),
            ),
          ],
        ),
      ),
    );
  }
}
