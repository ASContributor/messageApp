import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:message_app/blocs/post/post_bloc.dart';
import 'package:message_app/services/firestore_service.dart';

import 'ui/views/chatscreen.dart';
import 'ui/views/login_view.dart';
import 'ui/views/signup_view.dart';

class AppRoutes {
  static const String login = '/login';
  static const String signup = '/signup';
  static const String chat = '/chat';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => LoginView());
      case signup:
        return MaterialPageRoute(builder: (_) => SignUpView());
      case chat:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (context) =>
                    PostBloc(FirestoreService())..add(LoadPosts()),
                child: Chat()));
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text('No route defined for ${settings.name}'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        _,
                        MaterialPageRoute(builder: (_) => LoginView()),
                        (_) => false);
                  },
                  child: Text('Go to Login'),
                ),
              ],
            ),
          ),
        );
    }
  }
}
