import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SocialLoginButtons extends StatelessWidget {
  const SocialLoginButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.account_circle),
          onPressed: () {
            // Simule une connexion Google
            if (kDebugMode) {
              print('Connexion avec Google');
            }
          },
        ),
        IconButton(
          icon: const Icon(Icons.facebook),
          onPressed: () {
            // Simule une connexion Facebook
            if (kDebugMode) {
              print('Connexion avec Facebook');
            }
          },
        ),
      ],
    );
  }
}
