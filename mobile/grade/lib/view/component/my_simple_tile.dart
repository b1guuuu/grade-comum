import 'package:flutter/material.dart';

class MySimpleTile extends StatelessWidget {
  final void Function()? onTap;
  final void Function()? onLongPress;
  final Widget? title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? trailing;

  const MySimpleTile(
      {super.key,
      this.onTap,
      this.title,
      this.subtitle,
      this.leading,
      this.trailing,
      this.onLongPress});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: const BorderRadius.all(Radius.circular(5))),
      child: ListTile(
        enableFeedback: true,
        style: ListTileStyle.list,
        onTap: onTap,
        title: title,
        subtitle: subtitle,
        leading: leading,
        trailing: trailing,
        onLongPress: onLongPress,
      ),
    );
  }
}
