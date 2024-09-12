import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_typing_uninitialized_variables
    var emailValidator;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Connectez-vous', style: TextStyle(fontSize: 24)),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                validator: emailValidator,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Mot de passe'),
                obscureText: true,
                validator: (value) =>
                    value!.isEmpty ? 'Mot de passe requis' : null,
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () {
                  // Appel à la méthode de connexion avec email/mot de passe
                },
                child: const Text('Connexion'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.g_mobiledata,
                      color: Colors.yellow,
                    ),
                    onPressed: () {
                      // Connexion via Google
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.facebook,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      // Connexion via Facebook
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main(List<String> args) async{
WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Home());
}
