// ignore_for_file: file_names
import 'package:estudyingv1/Controller/SearchResultController.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Widget/AppBar.dart';
import '../../Widget/CourseCard.dart';

class SearchResult extends StatelessWidget {
  const SearchResult({Key? key, required this.query}) : super(key: key);

  final String query;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchResultController>(
        init: SearchResultController(query: query),
        builder: (c) => Scaffold(
            appBar: appBar(value: 'Resultat : $query', context: context),
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
