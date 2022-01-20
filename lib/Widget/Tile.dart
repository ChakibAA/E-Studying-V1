import 'package:flutter/material.dart';

class Tile extends StatelessWidget {
  const Tile({Key? key, required this.value, required this.ontap})
      : super(key: key);

  final String value;
  final void Function() ontap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        value,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      trailing: const Icon(
        Icons.keyboard_arrow_right,
      ),
      onTap: ontap,
    );
  }
}
// ignore_for_file: file_names
