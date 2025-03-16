import 'package:flutter/material.dart';

class CustomeRouteAnimation extends PageRouteBuilder {
  final RoutePageBuilder pageRouteBuilder;
  CustomeRouteAnimation({required this.pageRouteBuilder})
      : super(
            pageBuilder: pageRouteBuilder,
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              final tween = Tween<double>(begin: 0, end: 1).animate(
                  CurvedAnimation(parent: animation, curve: Curves.bounceIn));
              return FadeTransition(opacity: tween, child: child);
            });
}
