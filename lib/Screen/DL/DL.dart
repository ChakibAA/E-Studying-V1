// ignore_for_file: file_names
import 'dart:io';

import 'package:demoji/demoji.dart';
import 'package:estudyingv1/Model/Course.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../Widget/AppBar.dart';
import '../../Widget/CourseCard.dart';

class DL extends StatefulWidget {
  const DL({Key? key}) : super(key: key);

  @override
  State<DL> createState() => _DLState();
}

class _DLState extends State<DL> {
  @override
  void initState() {
    super.initState();
    final box = GetStorage();
    final listdl = box.read('dl');

    if (listdl != null) {
      toModel(listdl);
    }
  }

  List<Course> courses = [];

  toModel(List<dynamic> data) {
    for (var item in data) {
      setState(() {
        courses.add(Course.fromJson(item));
      });
    }
  }

  delete() {
    for (var item in courses) {
      if (item.allFiles != null) {
        for (var path in item.allFiles!) {
          File(path).delete().catchError((onError) {
            // ignore: avoid_print
            print(onError);
          });
        }
      }
      if (item.zipPath != null) {
        File(item.zipPath!).delete();
      }
    }
    setState(() {
      courses = [];
      deleteLoading = false;
    });
  }

  bool deleteLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
          value: 'Liste des téléchargements',
          context: context,
          iconButton1: courses.isEmpty ? null : trashButton(context)),
      body: Center(
        // ignore: unnecessary_null_comparison
        child: courses.isNotEmpty
            ? ListView.builder(
                padding: const EdgeInsets.only(top: 12, bottom: 35),
                itemBuilder: (context, index) {
                  return CourseCard(
                    data: courses[index],
                    index: index,
                    fromList: false,
                    fromdl: true,
                    fromheart: false,
                  );
                },
                itemCount: courses.length,
              )
            : const Text(
                'Votre liste des téléchargements \n est vide ... ${Demoji.cry}',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                ),
                textAlign: TextAlign.center,
              ),
      ),
    );
  }

  IconButton trashButton(BuildContext context) {
    return IconButton(
        onPressed: () {
          Get.defaultDialog(
              title: 'Supprimer tout les cours',
              content: deleteLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                      ),
                    )
                  : const Text('Voulez vous supprimer tout les cours ?'),
              actions: [
                TextButton(
                  onPressed: () {
                    if (courses.isNotEmpty) {
                      setState(() {
                        deleteLoading = true;
                      });
                      final box = GetStorage();
                      box.write('dl', null);

                      delete();
                      Get.back();
                    } else {
                      Get.back();
                    }
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
        },
        icon: const Icon(CupertinoIcons.trash));
  }
}
