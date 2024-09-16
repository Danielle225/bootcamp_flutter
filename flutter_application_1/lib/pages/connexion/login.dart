import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Fonction pour se connecter avec email et mot de passe
  Future<void> _signInWithEmailPassword() async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        // Redirection après connexion réussie
        Navigator.pushReplacementNamed(context, '/messagerie');
      } catch (e) {
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Erreur lors de la connexion'),
        ));
      }
    }
  }

  // Connexion avec Google
  Future<void> _signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        await _auth.signInWithCredential(credential);
        Navigator.pushReplacementNamed(context, '/messagerie');
      }
    } catch (e) {
      print(e);
    }
  }

  // Connexion avec Facebook
  Future<void> _signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        final credential = FacebookAuthProvider.credential(result.accessToken!.token);
        await _auth.signInWithCredential(credential);
        Navigator.pushReplacementNamed(context, '/messagerie');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Connexion')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: EmailValidator(errorText: "Email non valide"),
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Mot de passe'),
                obscureText: true,
                validator: RequiredValidator(errorText: "Mot de passe requis"),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _signInWithEmailPassword,
                child: Text('Connexion'),
              ),
              SizedBox(height: 10),
              ElevatedButton.icon(
                icon: Icon(Icons.login),
                onPressed: _signInWithGoogle,
                label: Text('Se connecter avec Google'),
              ),
              ElevatedButton.icon(
                icon: Icon(Icons.facebook),
                onPressed: _signInWithFacebook,
                label: Text('Se connecter avec Facebook'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
