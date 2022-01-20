// ignore_for_file: file_names

// ignore_for_file: invalid_use_of_protected_member

import 'package:estudyingv1/Model/Course.dart';
import 'package:flutter/material.dart';

import 'package:get/state_manager.dart';

import '../Service/ApiService.dart';

class SearchResultController extends GetxController {
  final ScrollController scrollController = ScrollController();

  RxList<Course> data = <Course>[].obs;
  APIService apiService = APIService();

  RxBool loadingProduct = true.obs;
  RxBool loadingPag = false.obs;
  int page = 1;
  bool getData = false;

  String query;

  SearchResultController({required this.query});

  @override
  void onInit() {
    super.onInit();

    scrollController.addListener(_scrollListener);

    fetchData();
  }

  void _scrollListener() async {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      loadingPag.value = true;
      update();
      if (!getData) {
        await refetchData();
        page++;
      }
    }
  }

  fetchData() async {
    data.value = await apiService.getQueryCourse(query: query);
    loadingProduct.value = false;
    page = 2;
    update();
  }

  refetchData() async {
    getData = true;
    List<Course> tempdata = [];

    tempdata = await apiService.getQueryCourse(query: query, page: page);

    data.addAll(tempdata);
    loadingPag.value = false;
    getData = false;

    update();
  }
}
