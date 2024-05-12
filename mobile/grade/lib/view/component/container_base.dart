import 'package:flutter/material.dart';

class ContainerBase extends StatelessWidget {
  final Widget child;

  const ContainerBase({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: child,
    );
  }
}
