// ignore_for_file: avoid_print, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presensi/controller/forgot_password_control.dart';

TextEditingController updateNim = TextEditingController();
TextEditingController updateName = TextEditingController();
TextEditingController updateEmail = TextEditingController();

FirebaseFirestore firestore = FirebaseFirestore.instance;
void updateProfile(String uid) async {
  if (updateNim.text.isNotEmpty &&
      updateName.text.isNotEmpty &&
      updateEmail.text.isNotEmpty) {
    isLoading.value = true;
    try {
      await firestore.collection('siswa').doc(uid).update({
        'name': updateName.text,
      });
      Get.snackbar(
          margin: const EdgeInsets.only(top: 10, left: 100, right: 100),
          backgroundColor: Colors.grey.shade500,
          "Success",
          "Profile Updated");
      print("Sukses");
    } catch (e) {
      Get.snackbar(
          margin: const EdgeInsets.only(top: 10, left: 100, right: 100),
          backgroundColor: Colors.grey.shade500,
          "Warning",
          "Update profile failed");
    }
  } else {
    print("gagal");
  }
}

void updatePict() {
  //
  Get.defaultDialog(
      title: 'Choose Image',
      content: ElevatedButton(
          onPressed: () {},
          child: Container(
            margin: const EdgeInsets.only(left: 25),
            // padding: const EdgeInsets.only(left: 30, right: 40),
            child: Row(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const Icon(Icons.upload),
                const Text(
                  '       upload image',
                )
              ],
            ),
          )));
}
