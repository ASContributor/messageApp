import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:message_app/blocs/post/post_bloc.dart';
import 'package:message_app/route/custome_route_animation.dart';
import 'package:message_app/services/firestore_service.dart';

import '../ui/views/chatscreen.dart';
import '../ui/views/login_view.dart';
import '../ui/views/signup_view.dart';

class AppRoutes {
  static const String login = '/login';
  static const String signup = '/signup';
  static const String chat = '/chat';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return CustomeRouteAnimation(
            pageRouteBuilder: (context, animation, secondAnimation) =>
                LoginView());
      case signup:
        return CustomeRouteAnimation(
            pageRouteBuilder: (context, animation, secondAnimation) =>
                SignUpView());
      case chat:
        return CustomeRouteAnimation(
          pageRouteBuilder: (context, animation, secondAnimation) =>
              BlocProvider(
                  create: (context) =>
                      PostBloc(FirestoreService())..add(LoadPosts()),
                  child: Chat()),
        );
      default:
        return CustomeRouteAnimation(
          pageRouteBuilder: (context, animation, secondAnimation) => Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text('No route defined for ${settings.name}'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
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
