// ignore_for_file: file_names, avoid_print

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:estudyingv1/Model/Category.dart';
import 'package:get/get.dart';

import '../Model/Course.dart';
import 'Config.dart';

class APIService {
  BaseOptions optionsAPI = BaseOptions(
    connectTimeout: 5000,
    receiveTimeout: 3000,
  );

  Future<List<Course>> getCourse({required String category, int? page}) async {
    List<Course> data = [];

    try {
      String parameter = "";

      parameter += "faculty=$category";
      if (page != null) {
        parameter += '&page=$page';
      }

      String url = Config.url + Config.course + "?$parameter";

      var response = await Dio(optionsAPI).get(
        url,
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        data = (response.data as List)
            .map(
              (i) => Course.fromJson(i),
            )
            .toList();
      }
    } on DioError catch (e) {
      Get.snackbar('Erreur', "Error 101", snackPosition: SnackPosition.BOTTOM);

      // ignore: unnecessary_string_interpolations
      print("${e.message}");
    }

    return data;
  }

  Future<List<Category>> getCategory() async {
    List<Category> data = [];

    try {
      String url = Config.url + Config.category;

      var response = await Dio(optionsAPI).get(
        url,
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        data = (response.data as List)
            .map(
              (i) => Category.fromJson(i),
            )
            .toList();
      }
    } on DioError catch (e) {
      Get.snackbar('Erreur', "erreur de connection",
          snackPosition: SnackPosition.BOTTOM);

      print(e.message);
    }

    return data;
  }

  Future<List<Course>> getLikedCourse({required List list, int? page}) async {
    List<Course> data = [];

    try {
      String parameter = "id=";

      for (int item in list) {
        parameter += "$item,";
      }

      if (page != null) {
        parameter += '&page=$page';
      }

      String url = Config.url + Config.courses + "?$parameter";

      var response = await Dio(optionsAPI).get(
        url,
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        data = (response.data as List)
            .map(
              (i) => Course.fromJson(i),
            )
            .toList();
      }
    } on DioError catch (e) {
      Get.snackbar('Erreur', "erreur de connection",
          snackPosition: SnackPosition.BOTTOM);
      // ignore: unnecessary_string_interpolations
      print(e.message);
    }

    return data;
  }

  Future<List<Course>> getQueryCourse(
      {required String query, int? page}) async {
    List<Course> data = [];

    try {
      String parameter = "query=$query";

      if (page != null) {
        parameter += '&page=$page';
      }

      String url = Config.url + Config.courses + "?$parameter";

      var response = await Dio().get(
        url,
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        data = (response.data as List)
            .map(
              (i) => Course.fromJson(i),
            )
            .toList();
      }
    } on DioError catch (e) {
      Get.snackbar('Erreur', "erreur de connection",
          snackPosition: SnackPosition.BOTTOM);
      // ignore: unnecessary_string_interpolations
      print("${e.message}");
    }

    return data;
  }
}




