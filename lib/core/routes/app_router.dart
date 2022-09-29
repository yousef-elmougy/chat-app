import 'package:chat_app/core/routes/routes.dart';
import 'package:flutter/material.dart';

import '../../auth_state_changes.dart';
import '../../features/auth/data/model/user_model.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/chat/presentation/screens/chat_details_screen.dart';

class AppRouter {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {

      /// LOGIN SCREEN
      case Routes.loginScreen:
        return MaterialPageRoute(
            builder: (_) =>
                const AuthStateChangesScreen(authWidget: LoginScreen()));

      /// REGISTER SCREEN
      case Routes.registerScreen:
        return MaterialPageRoute(
            builder: (_) =>
                const AuthStateChangesScreen(authWidget: RegisterScreen()));

    /// CHAT DETAILS SCREEN
      case Routes.chatDetailsScreen:
        final userModel = settings.arguments as UserModel;
        return MaterialPageRoute(
            builder: (_) => ChatDetailsScreen(userModel: userModel));




      default:
        return _defaultRoute();
    }
  }

  static MaterialPageRoute<dynamic> _defaultRoute() => MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(title: const Text('ERROR : Route Not Found')),
          body: const Center(
            child: Text(
              'ERROR : Route Not Found',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      );
}
