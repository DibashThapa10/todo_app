import 'package:flutter/material.dart';

class DrawerList extends StatelessWidget {
  final String text;
  final Icon icon;
  final Function()? ontap;

  const DrawerList(
      {super.key, required this.text, required this.icon, this.ontap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon,
      title: Text(
        text,
        style: const TextStyle(fontSize: 16),
      ),
      onTap: ontap,
    );
  }
}