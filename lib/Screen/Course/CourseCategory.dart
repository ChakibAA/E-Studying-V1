// ignore_for_file: file_names

import 'package:estudyingv1/Controller/CourseController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Widget/AppBar.dart';
import '../../Widget/CourseCard.dart';

class CourseCategory extends StatelessWidget {
  const CourseCategory(
      {Key? key, required this.parameters, required this.title})
      : super(key: key);

  final String parameters;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CourseController>(
        init: CourseController(category: parameters),
        builder: (c) => Scaffold(
            appBar: appBar(value: title, context: context),
            body: c.loadingProduct.value
                ? Center(
                    child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ))
                : Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          controller: c.scrollController,
                          padding: const EdgeInsets.only(top: 12, bottom: 35),
                          itemBuilder: (context, index) {
                            return CourseCard(
                              data: c.data[index],
                              index: index,
                              fromList: true,
                              fromdl: false,
                              fromheart: false,
                            );
                          },
                          itemCount: c.data.length,
                        ),
                      ),
                      c.loadingPag.value
                          ? Center(
                              child: CircularProgressIndicator(
                              color: Theme.of(context).primaryColor,
                            ))
                          : Container()
                    ],
                  )));
  }
}
