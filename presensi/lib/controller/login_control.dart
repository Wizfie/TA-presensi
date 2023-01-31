import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presensi/routes/route.dart';

final emailC = TextEditingController();
final passwordC = TextEditingController();
RxBool isLoading = false.obs;
FirebaseAuth auth = FirebaseAuth.instance;

Future<void> login() async {
  if (emailC.text.isNotEmpty && passwordC.text.isNotEmpty) {
    isLoading.value = true;
    // aksi
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: emailC.text, password: passwordC.text);
      if (userCredential.user != null) {
        if (userCredential.user!.emailVerified == true) {
          isLoading.value = false;

          if (passwordC.text == 'password') {
            Get.toNamed(RouteName.form);
          } else {
            Get.toNamed(RouteName.admin);
          }
        } else {
          Get.defaultDialog(
              title: "Verify Required",
              middleText: "verify your email !",
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
                    try {
                      await userCredential.user!.sendEmailVerification();
                      Get.back();
                      Get.snackbar(
                          margin: const EdgeInsets.only(
                              top: 10, left: 40, right: 40),
                          backgroundColor: Colors.grey.shade500,
                          "Success",
                          "Check your Email for verification");
                      isLoading.value = false;
                    } catch (e) {
                      isLoading.value = false;
                      Get.snackbar(
                          margin: const EdgeInsets.only(
                              top: 10, left: 40, right: 40),
                          backgroundColor: Colors.grey.shade500,
                          "Something Wrong ",
                          "Contact Admin");
                    }
                  },
                  child: const Text("Send Verify"),
                ),
              ]);
        }
        isLoading.value = false;
      }
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      if (e.code == 'user-not-found') {
        Get.snackbar(
            margin: const EdgeInsets.only(top: 10, left: 40, right: 40),
            backgroundColor: Colors.grey.shade500,
            "Warning",
            "Email not registered");
        // print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Get.snackbar(
            margin: const EdgeInsets.only(top: 10, left: 40, right: 40),
            backgroundColor: Colors.grey.shade500,
            "Error",
            "Wrong Password ");
        // print('Wrong password provided for that user.');
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        margin: const EdgeInsets.only(top: 10, left: 40, right: 40),
        backgroundColor: Colors.grey.shade500,
        "Error",
        "Contact Admin ",
      );
    }
  } else {
    Get.snackbar(
        margin: const EdgeInsets.only(top: 10, left: 40, right: 40),
        backgroundColor: Colors.grey.shade500,
        "Error",
        "Email & Password Required");
  }
}

void logOut() {
  auth.signOut();
  Get.offAllNamed(RouteName.login);
}
