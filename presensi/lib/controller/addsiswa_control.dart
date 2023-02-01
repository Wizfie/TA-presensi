// ignore_for_file: prefer_const_constructors, unused_local_variable, unnecessary_string_interpolations

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Text Field
TextEditingController nameC = TextEditingController();
TextEditingController nimC = TextEditingController();
TextEditingController emailC = TextEditingController();
TextEditingController passAdmin = TextEditingController();

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;

// Fucntion Addsiswa
void addSiswa() async {
  if (nameC.text.isNotEmpty && nimC.text.isNotEmpty && emailC.text.isNotEmpty) {
    Get.defaultDialog(
        title: "Admin Validasi",
        content: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const Text('Create account validation'),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: passAdmin,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "password",
              ),
              obscureText: true,
            )
          ],
        ),
        actions: [
          OutlinedButton(
            onPressed: () => Get.back(),
            child: Text(
              "Cancel",
              style: TextStyle(color: Colors.black),
            ),
          ),
          ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black),
              ),
              onPressed: () {
                createSiswa();
              },
              child: Text('Create'))
        ]);
    //  Aksi
    // }
  } else {
    Get.snackbar(
        margin: const EdgeInsets.only(top: 10, left: 40, right: 40),
        backgroundColor: Colors.grey.shade500,
        'Warning',
        'Field cannot empty',
        snackPosition: SnackPosition.TOP,
        colorText: Colors.black);
  }
}

Future<void> createSiswa() async {
  if (passAdmin.text.isNotEmpty) {
    try {
      String emailAdmin = auth.currentUser!.email!;
      UserCredential userCredentialadmin =
          await auth.signInWithEmailAndPassword(
              email: emailAdmin, password: passAdmin.text);

      UserCredential siswaCredential =
          await auth.createUserWithEmailAndPassword(
              email: emailC.text, password: "password");

      if (siswaCredential.user != null) {
        String uid = siswaCredential.user!.uid;

        await firestore.collection('siswa').doc(uid).set({
          "nim": nimC.text,
          "name": nameC.text,
          "email": emailC.text,
          "role": "siswa",
          "uid": uid,
          "createAt": DateTime.now().toIso8601String(),
        });

        // await userCredential.user!.sendEmailVerification();
        await auth.signOut();

        UserCredential userCredentialadmin =
            await auth.signInWithEmailAndPassword(
                email: emailAdmin, password: passAdmin.text);

        Get.back(); // Close Dialog
        Get.back(); // to home
        Get.snackbar(
            margin: const EdgeInsets.only(top: 10, left: 40, right: 40),
            backgroundColor: Colors.grey.shade500,
            "Success",
            'Account has been created');
      }
      // print(userCredential);
    } on FirebaseAuthException catch (e) {
      // print(e.code);
      if (e.code == 'weak-password') {
        Get.snackbar(
            margin: const EdgeInsets.only(top: 10, left: 40, right: 40),
            backgroundColor: Colors.grey.shade500,
            'Warning',
            'Password must 6 character');
        // print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar(
            margin: const EdgeInsets.only(top: 10, left: 40, right: 40),
            backgroundColor: Colors.grey.shade500,
            'Warning',
            'Email already used');
        // print('The account already exists for that email.');
      } else if (e.code == 'wrong-password') {
        Get.snackbar(
            margin: const EdgeInsets.only(top: 10, left: 40, right: 40),
            backgroundColor: Colors.grey.shade500,
            "Warning",
            'Wrong password');
      } else {
        Get.snackbar(
            margin: const EdgeInsets.only(top: 10, left: 40, right: 40),
            backgroundColor: Colors.grey.shade500,
            "Warning",
            '${e.code}');
      }
    } catch (e) {
      Get.snackbar(
          margin: const EdgeInsets.only(top: 10, left: 40, right: 40),
          backgroundColor: Colors.grey.shade500,
          'Warning',
          'Try again');
    }
  } else {
    Get.snackbar(
        margin: const EdgeInsets.only(top: 10, left: 40, right: 40),
        backgroundColor: Colors.grey.shade500,
        "Warning",
        "Password Required");
  }
}
