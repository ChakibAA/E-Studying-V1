// ignore_for_file: file_names

import 'package:estudyingv1/Model/Course.dart';

import 'package:flutter/material.dart';

import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';

import '../Service/ApiService.dart';

class LikeController extends GetxController {
  final ScrollController scrollController = ScrollController();

  RxList<Course> data = <Course>[].obs;
  APIService apiService = APIService();

  RxBool loadingProduct = true.obs;
  RxBool loadingPag = false.obs;
  int page = 1;
  bool getData = false;

  List? listLike;

  @override
  void onInit() {
    super.onInit();
    final box = GetStorage();
    listLike = box.read('like');

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

  clearCourse(index) {
    data.removeAt(index);
    update();
  }

  fetchData() async {
    if (listLike != null) {
      if (listLike!.isNotEmpty) {
        data.value = await apiService.getLikedCourse(list: listLike!);

        page = 2;
      }
    }
    loadingProduct.value = false;
    update();
  }

  refetchData() async {
    getData = true;
    List<Course> tempdata = [];

    tempdata = await apiService.getLikedCourse(
        list: listLike as List<int>, page: page);

    data.addAll(tempdata);
    loadingPag.value = false;
    getData = false;

    update();
  }
}
