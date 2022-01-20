// ignore_for_file: file_names
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:estudyingv1/Controller/SearchController.dart';
import 'package:estudyingv1/Screen/Course/CourseCategory.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Service/SizeConfig.dart';
import '../../Widget/Tile.dart';
import 'SearchResult.dart';

class Search extends StatelessWidget {
  Search({Key? key}) : super(key: key);
  final TextEditingController searchFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchController>(
        init: SearchController(),
        builder: (c) => Scaffold(
              appBar: SearchAppbar(context),
              body: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'Parcourir les catégories',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                        child: c.loadingProduct.value
                            ? Center(
                                child: CircularProgressIndicator(
                                color: Theme.of(context).primaryColor,
                              ))
                            : ListView.builder(
                                controller: c.scrollController,
                                itemCount: c.data.length,
                                itemBuilder: (context, index) {
                                  return Tile(
                                    value: c.data[index].name!,
                                    ontap: () {
                                      Get.to(() => CourseCategory(
                                            parameters: c.data[index].slug!,
                                            title: c.data[index].name!,
                                          ));
                                    },
                                  );
                                })),
                  ],
                ),
              ),
            ));
  }

  // ignore: non_constant_identifier_names
  AppBar SearchAppbar(context) {
    return AppBar(
      toolbarHeight: 60,
      elevation: 0.1,
      backgroundColor: Theme.of(context).bottomAppBarColor,
      title: AnimSearchBar(
        textInputAction: TextInputAction.search,
        animationDurationInMilli: 500,
        helpText: "Rechercher",
        closeSearchOnSuffixTap: false,
        onSubmitted: (String query) {
          Get.to(() => SearchResult(
                query: query,
              ));
          searchFieldController.clear();
        },
        prefixIcon: Icon(
          Icons.search,
          color: Theme.of(context).indicatorColor,
        ),
        suffixIcon: Icon(
          Icons.close,
          color: Theme.of(context).indicatorColor,
        ),
        searchColor: Theme.of(context).indicatorColor,
        color: Theme.of(context).bottomAppBarColor,
        width: getProportionateScreenWidth(400),
        textController: searchFieldController,
        onSuffixTap: () {
          searchFieldController.clear();
        },
      ),
    );
  }
}
