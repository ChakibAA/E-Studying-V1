// ignore_for_file: file_names
import 'dart:io';

import 'package:estudyingv1/Model/Course.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:open_file/open_file.dart';

import '../../Widget/AppBar.dart';
import '../../Widget/Tile.dart';
import '../Navigation.dart';

class DLInfo extends StatelessWidget {
  const DLInfo({Key? key, required this.data, required this.index})
      : super(key: key);

  final Course data;
  final int index;

  delete() {
    if (data.allFiles != null) {
      for (var path in data.allFiles!) {
        File(path).delete();
      }
    }
    if (data.zipPath != null) {
      File(data.zipPath!).delete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(
            value: data.title!,
            context: context,
            iconButton1: IconButton(
                onPressed: () {
                  deletePopUp(context);
                },
                icon: const Icon(CupertinoIcons.trash))),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return Tile(
              value: data.allFiles![index].split('/').last,
              ontap: () => OpenFile.open(data.allFiles![index]),
            );
          },
          itemCount: data.allFiles?.length,
        ));
  }

  Future<dynamic> deletePopUp(BuildContext context) {
    return Get.defaultDialog(
        title: 'Supprimer ce cours',
        content: const Text('Voulez vous supprimer ce cours ?'),
        actions: [
          TextButton(
            onPressed: () {
              final box = GetStorage();
              List listdl = box.read('dl');

              listdl.removeAt(index);

              box.write('dl', listdl);

              delete();
              Get.offAll(() => Navigation(
                    screenIndex: 2,
                  ));
            },
            child: Text(
              'OUI',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          ),
          TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text(
                'NON',
                style: TextStyle(color: Colors.redAccent),
              ))
        ]);
  }
}
