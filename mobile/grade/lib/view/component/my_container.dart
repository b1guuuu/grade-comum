import 'package:flutter/material.dart';

class MyContainer extends StatelessWidget {
  final double mainContainerWidth;
  final double mainContainerHeight;
  final double contentContainerWidth;
  final double contentContainerHeight;
  final Widget child;

  const MyContainer(
      {super.key,
      required this.mainContainerWidth,
      required this.mainContainerHeight,
      required this.contentContainerWidth,
      required this.contentContainerHeight,
      required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: mainContainerHeight,
      width: mainContainerWidth,
      child: Container(
        decoration: const BoxDecoration(
            color: Color.fromARGB(50, 166, 166, 166),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Center(
          child: SizedBox(
            height: contentContainerHeight,
            width: contentContainerWidth,
            child: child,
          ),
        ),
      ),
    );
  }
}
