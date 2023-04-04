import 'package:flutter/material.dart';

class HeroDialogPageRoute<T> extends PageRoute<T> {
  final Widget child;

  HeroDialogPageRoute(this.child);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => true;

  @override
  Color? get barrierColor => Colors.black54;

  @override
  String? get barrierLabel => 'Diálogo abierto';

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  bool get maintainState => true;

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return child;
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    // return FadeTransition(
    //   opacity: animation,
    //   child: child,
    // );
    return child;
  }
}
