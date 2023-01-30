// ignore_for_file: must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presensi/controller/update_profile_control.dart';

class UpdateProfile extends StatelessWidget {
  final controller = Get.put(UpdateProfileController(String));

  Map<String, dynamic> user = Get.arguments;
  @override
  Widget build(BuildContext context) {
    controller.updateNim.text = user['nim'];
    controller.updateName.text = user['name'];
    controller.updateEmail.text = user['email'];

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: const Text('Update Profile'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: controller.updateNim,
            // ignore: prefer_const_constructors
            decoration: const InputDecoration(
                labelText: 'Nim', border: OutlineInputBorder()),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: controller.updateName,
            decoration: const InputDecoration(
                labelText: 'Name', border: OutlineInputBorder()),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: controller.updateEmail,
            decoration: const InputDecoration(
                labelText: 'Email', border: OutlineInputBorder()),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              //
            },
            child: Container(
              height: 50,
              color: Colors.black,
              alignment: Alignment.center,
              child: const Text(
                "Submit",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
