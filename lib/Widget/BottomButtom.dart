// ignore_for_file: file_names
import 'package:flutter/material.dart';

class BottomButton extends StatelessWidget {
  const BottomButton({Key? key, required this.label, required this.suffixIcon})
      : super(key: key);

  final String label;
  final Icon suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      color: Theme.of(context).bottomAppBarColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 8),
          suffixIcon
        ],
      ),
    );
  }
}
