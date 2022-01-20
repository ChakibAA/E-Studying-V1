// ignore_for_file: file_names

// ignore_for_file: invalid_use_of_protected_member

import 'package:estudyingv1/Model/Category.dart';

import 'package:flutter/material.dart';

import 'package:get/state_manager.dart';

import '../Service/ApiService.dart';

class SearchController extends GetxController {
  final ScrollController scrollController = ScrollController();

  RxList<Category> data = <Category>[].obs;
  APIService apiService = APIService();

  RxBool loadingProduct = true.obs;
  RxBool loadingPag = false.obs;
  int page = 1;
  bool getData = false;

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
      if (!getData) {
        await refetchData();
        page++;
      }
    }
  }

  fetchData() async {
    data.value = await apiService.getCategory();
    loadingProduct.value = false;
    page = 2;
    update();
  }

  refetchData() async {
    getData = true;
    List<Category> tempdata = [];

    tempdata = await apiService.getCategory();

    data.addAll(tempdata);
    loadingPag.value = false;
    getData = false;

    update();
  }
}
