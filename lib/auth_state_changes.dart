import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'features/chat/presentation/screens/chat_screen.dart';


class AuthStateChangesScreen extends StatelessWidget {

  final Widget authWidget;

  const AuthStateChangesScreen({Key? key, required this.authWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) => StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            return snapshot.hasData ? const ChatScreen() : authWidget;
          } else {
            return const Scaffold(
                body: Center(child: CircularProgressIndicator()));
          }
        },
      );
}
