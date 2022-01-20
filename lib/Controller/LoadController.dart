// ignore_for_file: file_names
import 'package:get/get.dart';

class LoadController extends GetxController {
  RxDouble prc = 0.0.obs;

  LoadController();

  progress(recieve, total) {
    prc.value = recieve / total;
    update();
  }
}
