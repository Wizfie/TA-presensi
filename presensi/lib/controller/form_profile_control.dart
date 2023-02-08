// ignore_for_file: non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presensi/routes/route.dart';

FirebaseAuth auth = FirebaseAuth.instance;

final newpasssC = TextEditingController();

void CompleteProfile() async {
  if (newpasssC.text.isNotEmpty) {
    if (newpasssC.text != "password") {
      try {
        String email = auth.currentUser!.email!;

        await auth.currentUser!.updatePassword(newpasssC.text);

        await auth.signOut();

        await auth.signInWithEmailAndPassword(
            email: email, password: newpasssC.text);

        Get.offAllNamed(RouteName.homeView);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Get.snackbar(
              margin: const EdgeInsets.only(top: 10, left: 100, right: 100),
              backgroundColor: Colors.grey.shade500,
              "Warning",
              "password to short");
        }
      } catch (e) {
        Get.snackbar(
            margin: const EdgeInsets.only(top: 10, left: 100, right: 100),
            backgroundColor: Colors.grey.shade500,
            "Error",
            "Contact Admin");
      }
    } else {
      Get.snackbar(
          margin: const EdgeInsets.only(top: 10, left: 100, right: 100),
          backgroundColor: Colors.grey.shade500,
          "Error",
          "password has been used before");
    }
  } else {
    Get.snackbar(
        margin: const EdgeInsets.only(top: 10, left: 100, right: 100),
        backgroundColor: Colors.grey.shade500,
        "Error",
        "Field Cannot Empty");
  }
}
