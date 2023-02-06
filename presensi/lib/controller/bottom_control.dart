// ignore_for_file: avoid_print

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:presensi/component/maps.dart';
import 'package:presensi/routes/route.dart';

RxInt index = 0.obs;

void changeIndex(int i) async {
  switch (i) {
    case 1:
      print("Present");
      // determinePosition();
      Position position = await determinePosition();
      print("${position.latitude}  ,  ${position.longitude}");
      break;
    case 2:
      Get.offAllNamed(RouteName.profile);

      break;
    default:
      Get.offAllNamed(RouteName.admin);
  }
}
