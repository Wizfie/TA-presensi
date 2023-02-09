import 'package:get/get.dart';
import 'package:presensi/routes/route.dart';

void changeIndex(int i) async {
  switch (i) {
    case 1:
      Get.toNamed(RouteName.profile);

      break;
    default:
      Get.toNamed(RouteName.homeView);
  }
}
