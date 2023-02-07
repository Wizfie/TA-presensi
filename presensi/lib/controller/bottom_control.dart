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

List<double> plantI = [-6.1929342, 106.5650222];
List<double> politeknik = [-6.1929811, 106.5690568];
List<double> musholapoltek = [-6.1929884, 106.5690719];
List<double> musholaRumah = [-6.2023946, 106.5334841];

String status = "outside the coverage area";
// String Ket = "07";

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

        // Set Coverage
        double distance = Geolocator.distanceBetween(politeknik[0],
            politeknik[1], position.latitude, position.longitude);

        await presence(position, address, distance);

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

Future<void> updateLocation(Position position, String address) async {
  String uid = await auth.currentUser!.uid;
  await firestore.collection("siswa").doc(uid).update({
    "position": {
      "lat": position.latitude,
      "long": position.longitude,
    },
    "address": address,
    "status": status
  });
}

Future<void> presence(
    Position position, String address, double distance) async {
  //
  String uid = await auth.currentUser!.uid;
  DateTime now = DateTime.now();

  CollectionReference<Map<String, dynamic>> colRef =
      await firestore.collection('siswa').doc(uid).collection("presence");

  QuerySnapshot<Map<String, dynamic>> snapPresence = await colRef.get();

  String dayDocID = DateFormat.yMd().format(now).replaceAll("/", '-');

  if (distance <= 300) {
    status = "in the coverage area";
    if (snapPresence.docs.isEmpty) {
      // if ()
      print("Masuk");
      colRef.doc(dayDocID).set(
        {
          "date": now.toIso8601String(),
          "IN": {
            "date": now.toIso8601String(),
            "Lat": position.latitude,
            "long": position.longitude,
            "Status": status,
            "distance": distance,
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
                "Status": status,
                "distance": distance,
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
              "Status": status,
              "distance": distance,
            }
          },
        );
        //
      }
    }
  } else {
    Get.snackbar("Warning", "You are outside the presence area");
  }
}
