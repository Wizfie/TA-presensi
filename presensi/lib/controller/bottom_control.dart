// ignore_for_file: avoid_print, await_only_futures

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:presensi/component/maps.dart';
import 'package:presensi/routes/route.dart';

RxInt index = 0.obs;
FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;

void changeIndex(int i) async {
  switch (i) {
    case 1:
      Map<String, dynamic> response = await determinePosition();
      if (response['error'] != true) {
        print("Present");
        Position position = response['position'];
        await updateLocation(position);

        List<Placemark> placemarks = await placemarkFromCoordinates(
            position.latitude, position.longitude);

        print(placemarks);

        // Get.snackbar("${response['message']}", 'Succes ');
      } else {
        Get.snackbar("Warning", response['message']);
      }

      break;
    case 2:
      Get.offAllNamed(RouteName.profile);

      break;
    default:
      Get.offAllNamed(RouteName.admin);
  }
}

Future<void> updateLocation(Position position) async {
  String uid = await auth.currentUser!.uid;
  await firestore.collection("siswa").doc(uid).update({
    "position": {
      "lat": position.latitude,
      "long": position.longitude,
    }
  });
}
