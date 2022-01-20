// ignore_for_file: file_names
import 'package:estudyingv1/Controller/LikeController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import '../Model/Course.dart';

import '../Screen/Course/CourseDetail.dart';
import '../Screen/DL/DLInfo.dart';
import 'BottomButtom.dart';
import 'BottomSheet.dart';

class CourseCard extends StatelessWidget {
  const CourseCard(
      {Key? key,
      required this.data,
      required this.fromList,
      required this.fromheart,
      required this.index,
      required this.fromdl})
      : super(key: key);

  final Course data;
  final bool fromList;
  final bool fromdl;
  final bool fromheart;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (fromList) fromListFunc();
        if (fromdl) {
          Get.to(() => DLInfo(data: data, index: index));
        }
        if (fromheart) fromListLike();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        padding: const EdgeInsets.all(12),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${data.title}',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              '${data.description}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                data.youtubeLink == null
                    ? data.youtubeLink == ""
                        ? Container()
                        : const Icon(
                            LineIcons.pdfFileAlt,
                            color: Colors.white,
                            size: 33,
                          )
                    : Container(),
                data.courseRar == null
                    ? Container()
                    : const Icon(
                        LineIcons.pdfFileAlt,
                        color: Colors.white,
                        size: 30,
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  fromListLike() {
    final c = Get.put(LikeController());
    if (data.youtubeLink != null) {
      if (data.youtubeLink == '') {
        Get.bottomSheet(BottomSheetCourse(
          data: data,
          button2: GestureDetector(
            onTap: () {
              data.removeLike();
              c.clearCourse(index);
            },
            child: const BottomButton(
              label: 'Retirer des favoris',
              suffixIcon: Icon(LineIcons.heart),
            ),
          ),
        ));
      } else {
        Get.to(() => CourseDetail(
              data: data,
              like: true,
            ));
      }
    } else {
      Get.to(() => CourseDetail(
            data: data,
            like: true,
          ));
    }
  }

  fromListFunc() {
    if (data.youtubeLink != null) {
      if (data.youtubeLink == '') {
        Get.bottomSheet(BottomSheetCourse(
          data: data,
          button2: GestureDetector(
            onTap: () => data.like(),
            child: const BottomButton(
              label: 'Ajouter aux favoris',
              suffixIcon: Icon(LineIcons.heart),
            ),
          ),
        ));
      } else {
        Get.to(() => CourseDetail(
              data: data,
            ));
      }
    } else {
      Get.to(() => CourseDetail(
            data: data,
          ));
    }
  }
}
