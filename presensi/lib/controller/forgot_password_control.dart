// ignore_for_file: avoid_print, unrelated_type_equality_checks

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

RxBool isLoading = false.obs;
final emailReset = TextEditingController();

FirebaseAuth auth = FirebaseAuth.instance;

void resetPassword() async {
  if (emailReset.text.isNotEmpty) {
    try {
      await auth.sendPasswordResetEmail(email: emailReset.text);
      print("sended");
      emailReset.clear();
      Get.back();
      Get.snackbar(
          margin: const EdgeInsets.only(top: 10, left: 40, right: 40),
          backgroundColor: Colors.grey.shade500,
          "Success",
          "Check your email");
    } catch (e) {
      Get.snackbar(
          margin: const EdgeInsets.only(top: 10, left: 40, right: 40),
          backgroundColor: Colors.grey.shade500,
          "Something Problem",
          "Contact Adnmin");
    } finally {
      isLoading.value = false;
    }
  } else {
    Get.snackbar(
        margin: const EdgeInsets.only(top: 10, left: 40, right: 40),
        backgroundColor: Colors.grey.shade500,
        "Error",
        "Email Required");
  }
}
