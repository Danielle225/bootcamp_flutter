import 'package:flutter/material.dart';

class SocialLoginButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.account_circle),
          onPressed: () {
            // Simule une connexion Google
            print('Connexion avec Google');
          },
        ),
        IconButton(
          icon: Icon(Icons.facebook),
          onPressed: () {
            // Simule une connexion Facebook
            print('Connexion avec Facebook');
          },
        ),
      ],
    );
  }
}
