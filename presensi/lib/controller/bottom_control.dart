// ignore_for_file: avoid_print, await_only_futures

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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

        List<Placemark> placemarks = await placemarkFromCoordinates(
            position.latitude, position.longitude);

        String address =
            "${placemarks[0].thoroughfare} ${placemarks[0].subThoroughfare},  ${placemarks[0].subAdministrativeArea}";
        await updateLocation(position, address);

        await presence(position, address);

        // Get.snackbar("Success", "Presence success");
        print(placemarks);
      } else {
        Get.snackbar("Warning", "Cannot get your Location");
      }

      break;
    case 2:
      Get.offAllNamed(RouteName.profile);

      break;
    default:
      Get.offAllNamed(RouteName.admin);
  }
}

List<String> PlantI = ["-6.1929342", "106.5650222"];
List<String> Politeknik = ['-6.1929811', '106.5690568'];
List<String> Musholapoltek = ['-6.1929884', '106.5690719'];

Future<void> updateLocation(Position position, String address) async {
  String uid = await auth.currentUser!.uid;
  await firestore.collection("siswa").doc(uid).update({
    "position": {
      "lat": position.latitude,
      "long": position.longitude,
    },
    "address": address
  });
}

Future<void> presence(Position position, String address) async {
  String uid = await auth.currentUser!.uid;

  CollectionReference<Map<String, dynamic>> colRef =
      await firestore.collection('siswa').doc(uid).collection("presence");

  QuerySnapshot<Map<String, dynamic>> snapPresence = await colRef.get();

  DateTime now = DateTime.now();
  String dayDocID = DateFormat.yMd().format(now).replaceAll("/", '-');

  if (snapPresence.docs.length == 0) {
    print("Masuk");
    colRef.doc(dayDocID).set(
      {
        "date": now.toIso8601String(),
        "IN": {
          "date": now.toIso8601String(),
          "Lat": position.latitude,
          "long": position.longitude,
          "Status": "on area",
        }
      },
    );
    Get.snackbar("Success", "Presence IN");
  } else {
    // sudah masuk & keluar
    DocumentSnapshot<Map<String, dynamic>> dayDoc =
        await colRef.doc(dayDocID).get();

    if (dayDoc.exists == true) {
      Map<String, dynamic>? dataToday = dayDoc.data();

      if (dataToday?['Out'] != null) {
        //
        Get.snackbar("Warning", "You has presence in and out today !");
      } else {
        //
        print('Keluar');
        colRef.doc(dayDocID).update(
          {
            "date": now.toIso8601String(),
            "Out": {
              "date": now.toIso8601String(),
              "Lat": position.latitude,
              "long": position.longitude,
              "Status": "on area",
            }
          },
        );
        Get.snackbar("Success", "Presence OUT");
      }
      //
    } else {
      print("Next Day");
      colRef.doc(dayDocID).set(
        {
          "date": now.toIso8601String(),
          "IN": {
            "date": now.toIso8601String(),
            "Lat": position.latitude,
            "long": position.longitude,
            "Status": "on area",
          }
        },
      );
      //
    }
  }
}
