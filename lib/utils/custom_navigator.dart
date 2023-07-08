import 'package:flutter/material.dart';

class CustomPageRoute<T> extends PageRouteBuilder<T> {
  final Widget page;

  CustomPageRoute(this.page)
      : super(
          pageBuilder: (context, animation, anotherAnimation) => page,
          transitionDuration: const Duration(milliseconds: 1000),
          reverseTransitionDuration: const Duration(milliseconds: 400),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
              curve: Curves.fastLinearToSlowEaseIn,
              parent: animation,
              reverseCurve: Curves.fastOutSlowIn,
            );
            return SlideTransition(
              position: Tween(
                begin: const Offset(1.0, 0.0),
                end: const Offset(0.0, 0.0),
              ).animate(animation),
              child: child,
            );
          },
        );

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  bool get fullscreenDialog => false;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return page;
  }
}
