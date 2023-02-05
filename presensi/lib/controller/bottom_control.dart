// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:presensi/routes/route.dart';

RxInt index = 0.obs;

void changeIndex(int i) {
  print("clikindex=$i");

  switch (i) {
    case 1:
      print("Present");
      break;
    case 2:
      Get.offAllNamed(RouteName.profile);

      break;
    default:
      Get.offAllNamed(RouteName.admin);
  }
}
