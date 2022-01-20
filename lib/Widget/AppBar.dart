// ignore_for_file: file_names
import 'package:flutter/material.dart';

AppBar appBar(
    {required String value,
    required BuildContext context,
    IconButton? iconButton1}) {
  return AppBar(
    backgroundColor: Theme.of(context).bottomAppBarColor,
    toolbarHeight: 60,
    elevation: 0.2,
    title: Text(
      value,
      style: TextStyle(color: Theme.of(context).indicatorColor),
    ),
    actions: [iconButton1 ?? Container()],
    iconTheme: IconThemeData(color: Theme.of(context).indicatorColor),
  );
}
