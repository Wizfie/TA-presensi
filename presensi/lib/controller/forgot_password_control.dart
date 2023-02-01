// ignore_for_file: avoid_print, unrelated_type_equality_checks

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

RxBool isLoading = false.obs;
final emailReset = TextEditingController();

FirebaseAuth auth = FirebaseAuth.instance;

void resetPassword() {
  Get.defaultDialog(
      title: "Reset password",
      content: TextField(
        controller: emailReset,
        decoration: const InputDecoration(
            labelText: "Email", border: OutlineInputBorder()),
      ),
      actions: [
        OutlinedButton(
          onPressed: () {
            isLoading.value = false;
            Get.back();
          },
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.black),
          ),
        ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.black),
          ),
          onPressed: () async {
            if (emailReset.text.isNotEmpty) {
              try {
                await auth.sendPasswordResetEmail(email: emailReset.text);
                Get.back();
                Get.snackbar(
                    margin: const EdgeInsets.only(top: 10, left: 40, right: 40),
                    backgroundColor: Colors.grey.shade500,
                    "Success",
                    "Check your Email for Reset");
                isLoading.value = false;
              } on FirebaseAuthException catch (e) {
                isLoading.value = false;
                if (e.code == 'user-not-found') {
                  Get.snackbar(
                      margin:
                          const EdgeInsets.only(top: 10, left: 40, right: 40),
                      backgroundColor: Colors.grey.shade500,
                      "Warning",
                      "Email not registered");
                } else {
                  Get.snackbar(
                      margin:
                          const EdgeInsets.only(top: 10, left: 40, right: 40),
                      backgroundColor: Colors.grey.shade500,
                      "Warning ",
                      "Please input correct email!");
                }
              }
            } else {
              Get.snackbar(
                  margin: const EdgeInsets.only(top: 10, left: 40, right: 40),
                  backgroundColor: Colors.grey.shade500,
                  "Warning",
                  "Email Required");
            }
          },
          child: const Text("Send Reset"),
        ),
      ]);
  // if (emailReset.text.isNotEmpty) {
  //   try {
  //     await auth.sendPasswordResetEmail(email: emailReset.text);
  //     print("sended");
  //     emailReset.clear();
  //     Get.back();
  //     Get.snackbar(
  //         margin: const EdgeInsets.only(top: 10, left: 40, right: 40),
  //         backgroundColor: Colors.grey.shade500,
  //         "Success",
  //         "Check your email");
  //   } on FirebaseAuthException catch (e) {
  //     print(e.code);
  //     Get.snackbar(
  //         margin: const EdgeInsets.only(top: 10, left: 40, right: 40),
  //         backgroundColor: Colors.grey.shade500,
  //         "Something Problem",
  //         "Contact Adnmin");
  //   } finally {
  //     isLoading.value = false;
  //   }
  // } else {
  //   Get.snackbar(
  //       margin: const EdgeInsets.only(top: 10, left: 40, right: 40),
  //       backgroundColor: Colors.grey.shade500,
  //       "Error",
  //       "Email Required");
  // }
}
