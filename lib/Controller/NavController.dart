// ignore_for_file: file_names
import 'package:get/get.dart';

class NavController extends GetxController {
  RxInt? index = 0.obs;

  NavController({this.index});

  increment(int value) {
    index = value.obs;
    update();
  }
}
