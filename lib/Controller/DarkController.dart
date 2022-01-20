// ignore_for_file: file_names

import 'package:get/get.dart';

class DarkController extends GetxController {
  RxBool stat = false.obs;

  change(value) {
    stat.value = value;

    update();
  }
}
