import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presensi/controller/stream_user.dart';

RxBool isLoading = false.obs;
TextEditingController currPass = TextEditingController();
TextEditingController newPass = TextEditingController();
TextEditingController rePass = TextEditingController();

FirebaseAuth auth = FirebaseAuth.instance;

void updatePassword() async {
  if (currPass.text.isNotEmpty &&
      newPass.text.isNotEmpty &&
      rePass.text.isNotEmpty) {
    if (newPass.text == rePass.text) {
      isloading.value = true;
      try {
        //aksi
        String emailUser = auth.currentUser!.email!;

        await auth.signInWithEmailAndPassword(
            email: emailUser, password: currPass.text);

        await auth.currentUser!.updatePassword(newPass.text);

        Get.back();

        Get.snackbar(
            margin: const EdgeInsets.only(top: 10, left: 100, right: 100),
            backgroundColor: Colors.grey.shade500,
            "Success",
            "Password Updated");
      } on FirebaseAuthException catch (e) {
        // error khusus
        if (e.code == 'wrong-password') {
          isloading.value = false;
          Get.snackbar(
              margin: const EdgeInsets.only(top: 10, left: 100, right: 100),
              backgroundColor: Colors.grey.shade500,
              "Warning",
              " Wrong current password ");
          //
        } else {
          isloading.value = false;
          Get.snackbar(
              margin: const EdgeInsets.only(top: 10, left: 100, right: 100),
              backgroundColor: Colors.grey.shade500,
              "Warning",
              " Wrong password ");
        }
      } catch (e) {
        // error
        isloading.value = false;
        Get.snackbar(
            margin: const EdgeInsets.only(top: 10, left: 100, right: 100),
            backgroundColor: Colors.grey.shade500,
            "Warning",
            "Update password failed , Try Again");
      }
    } else {
      isloading.value = false;
      Get.snackbar(
          margin: const EdgeInsets.only(top: 10, left: 100, right: 100),
          backgroundColor: Colors.grey.shade500,
          "Warning",
          "New password & Confirm Password not  the same");
    }
  } else {
    Get.snackbar(
        margin: const EdgeInsets.only(top: 10, left: 100, right: 100),
        backgroundColor: Colors.grey.shade500,
        "Warning",
        "Update Password Failed");
  }
}
