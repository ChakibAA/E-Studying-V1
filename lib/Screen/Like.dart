// ignore_for_file: file_names

import 'package:demoji/demoji.dart';
import 'package:estudyingv1/Controller/LikeController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Widget/AppBar.dart';
import '../Widget/CourseCard.dart';

class Like extends StatelessWidget {
  const Like({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LikeController>(
      init: LikeController(),
      builder: (c) => Scaffold(
          appBar: appBar(value: 'Liste des favoris', context: context),
          body: c.loadingProduct.value
              ? Center(
                  child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ))
              : c.data.isNotEmpty
                  ? Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            controller: c.scrollController,
                            padding: const EdgeInsets.only(top: 12, bottom: 35),
                            itemBuilder: (context, index) {
                              return CourseCard(
                                data: c.data[index],
                                index: index,
                                fromList: false,
                                fromdl: false,
                                fromheart: true,
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
                    )
                  : const Center(
                      child: Text(
                      'Votre liste des favoris \n est vide ... ${Demoji.cry}',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 22,
                      ),
                      textAlign: TextAlign.center,
                    ))),
    );
  }
}
