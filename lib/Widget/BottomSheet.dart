// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import '../Model/Course.dart';
import 'BottomButtom.dart';

class BottomSheetCourse extends StatelessWidget {
  const BottomSheetCourse({
    Key? key,
    required this.data,
    required this.button2,
  }) : super(key: key);

  final Course data;
  final Widget button2;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(12),
      ),
      child: Container(
        padding: const EdgeInsets.only(bottom: 12),
        color: Theme.of(context).bottomAppBarColor,
        height: 215,
        child: Column(
          children: [
            GestureDetector(
              onTap: () async {
                try {
                  await data.openFile(context);

                  Get.back();
                  Get.snackbar('Téléchargement',
                      'Le cours a était télécharger avec succes',
                      snackPosition: SnackPosition.BOTTOM);
                } catch (e) {
                  Get.back();
                  Get.snackbar(
                      'Erreur', 'erreur dans le téléchargement de ce cours',
                      snackPosition: SnackPosition.BOTTOM);
                  // ignore: avoid_print
                  print(e);
                }
              },
              child: BottomButton(
                label: 'Télécharger les ${data.type!.name}',
                suffixIcon: const Icon(LineIcons.fileDownload),
              ),
            ),
            Divider(color: Theme.of(context).indicatorColor, height: 1),
            button2
          ],
        ),
      ),
    );
  }
}
