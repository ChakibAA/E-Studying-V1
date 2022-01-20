// ignore_for_file: file_names, unnecessary_null_comparison

import 'dart:io';

import 'package:archive/archive.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

// import 'package:flutter_archive/flutter_archive.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';

import '../Controller/LoadController.dart';

import 'CourseRAR.dart';
import 'Module.dart';

class Course {
  int? id;
  String? title;
  Module? module;
  Module? type;
  Module? category;
  String? description;
  String? postLink;
  String? status;
  String? youtubeLink;
  CourseRar? courseRar;
  List<dynamic>? allFiles;
  String? zipPath;

  Course(
      {this.id,
      this.title,
      this.module,
      this.type,
      this.category,
      this.description,
      this.postLink,
      this.status,
      this.youtubeLink,
      this.allFiles,
      this.courseRar});

  Course.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    title = title?.replaceAll('&#8211;', '-');
    module = json['module'] != null ? Module.fromJson(json['module']) : null;
    type = json['type'] != null ? Module.fromJson(json['type']) : null;
    category =
        json['faculty'] != null ? Module.fromJson(json['faculty']) : null;
    description = json['description'];
    postLink = json['post_link'];
    status = json['status'];
    youtubeLink = json['youtube_link'];

    courseRar = json['course_rar'] != null
        ? json['course_rar'] == false
            ? null
            : CourseRar.fromJson(json['course_rar'])
        : null;

    allFiles = json['data'];
    zipPath = json['zipPath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    if (module != null) {
      data['module'] = module!.toJson();
    }
    if (type != null) {
      data['type'] = type!.toJson();
    }
    if (category != null) {
      data['faculty'] = category!.toJson();
    }
    data['description'] = description;
    data['post_link'] = postLink;
    data['status'] = status;
    data['youtube_link'] = youtubeLink;
    if (courseRar != null) {
      data['course_rar'] = courseRar!.toJson();
    }
    return data;
  }

  removeLike() {
    final box = GetStorage();
    List listLike = box.read('like');
    if (listLike == null) {
      return Get.snackbar(
          'Erreur', "Ce cours n'est pas dans votre liste des favoris",
          snackPosition: SnackPosition.BOTTOM);
    } else {
      if (listLike.contains(id)) {
        int index = listLike.indexOf(id);
        listLike.removeAt(index);

        box.write('like', listLike);
        Get.back();
      } else {
        return Get.snackbar(
            'Erreur', "Ce cours n'est pas dans votre liste des favoris",
            snackPosition: SnackPosition.BOTTOM);
      }
    }
  }

  like() {
    final box = GetStorage();
    var listLike = box.read('like');
    if (listLike == null) {
      listLike = [id!];
    } else {
      if (listLike.contains(id)) {
        return Get.snackbar(
            'Erreur', 'Ce cours est deja dans votre liste des favoris',
            snackPosition: SnackPosition.BOTTOM);
      } else {
        listLike.add(id!);
      }
    }
    box.write('like', listLike);
    Get.back();
  }

  Future openFile(
    BuildContext context,
  ) async {
    bool dl = await checkIfDl();
    if (dl) {
      final loadcontroller = Get.put(LoadController());
      Get.defaultDialog(
          title: 'Telechargement',
          content: Padding(
              padding: const EdgeInsets.all(8),
              child: Obx(
                () => LinearProgressIndicator(
                  backgroundColor: Colors.grey,
                  value: loadcontroller.prc.value,
                  color: Theme.of(context).primaryColor,
                ),
              )),
          barrierDismissible: false);
      final file = await downloadFile(loadcontroller);

      if (file == null) return;

      final allFiles = await ext(file.path);

      if (allFiles == null) return;

      await saveFilesPath(allFiles, file.path);
      Get.back();
    } else {
      Get.snackbar('Erreur', 'Vous avez deja télécharger ce cours',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<bool> checkIfDl() async {
    final box = GetStorage();

    var data = box.read('dl');
    if (data == null) {
      return true;
    } else {
      for (var item in data) {
        if (item['id'] == id) {
          Get.snackbar('Erreur', 'Vous avez deja télécharger ce cours',
              snackPosition: SnackPosition.BOTTOM);
          return false;
        }
      }
    }
    return true;
  }

  saveFilesPath(List<String> allFiles, String zipPath) async {
    final box = GetStorage();
    var data = box.read('dl');
    final appStorage = await getApplicationDocumentsDirectory();
    String destinationPath = appStorage.path + '/' + title!;
    if (data == null) {
      data = [
        {
          'id': id,
          'title': title,
          'description': description,
          'data': allFiles,
          'pathFile': destinationPath,
          'zipPath': zipPath,
        }
      ];
    } else {
      data.add({
        'id': id,
        'title': title,
        'description': description,
        'data': allFiles,
        'pathFile': destinationPath,
        'zipPath': zipPath,
      });
    }
    box.write('dl', data);
  }

  Future<List<String>?> ext(String zipPath) async {
    final bytes = File(zipPath).readAsBytesSync();
    final archive = ZipDecoder().decodeBytes(bytes);
    final appStorage = await getApplicationDocumentsDirectory();
    String destinationPath = appStorage.path + '/' + title!;
    List<String> allFiles = [];
    try {
      for (final file in archive) {
        final filename = file.name;

        if (filename.contains('.pdf')) {
          if (file.isFile) {
            final data = file.content as List<int>;
            File('$destinationPath/' + filename)
              ..createSync(recursive: true)
              ..writeAsBytesSync(data);
          } else {
            Directory('$destinationPath/' + filename).create(recursive: true);
          }
          allFiles.add('$destinationPath/' + filename);
        }
      }
      return allFiles;
    } catch (e) {
      return [];
    }
  }

  Future<File?> downloadFile(LoadController loadcontroller) async {
    try {
      if (courseRar != null) {
        final nameFile = courseRar!.url!.split('/').last;
        final appStorage = await getApplicationDocumentsDirectory();
        final file = File('${appStorage.path}/$nameFile');

        final response = await Dio().get(
          courseRar!.url!,
          onReceiveProgress: loadcontroller.progress,
          options: Options(
              responseType: ResponseType.bytes,
              followRedirects: false,
              receiveTimeout: 0),
        );

        final raf = file.openSync(mode: FileMode.write);
        raf.writeFromSync(response.data);
        await raf.close();

        return file;
      }
    } catch (e) {
      Get.snackbar('Erreur', "le Téléchargement n'a pas pu être terminer",
          snackPosition: SnackPosition.BOTTOM);
      return null;
    }
  }
}
