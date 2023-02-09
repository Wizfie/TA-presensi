// ignore_for_file: must_be_immutable, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/update_profile_control.dart';

class UpdateProfile extends StatelessWidget {
  // final UpdateProfile = Get.find<UpdateProfile>();
  UpdateProfile({super.key});

  Map<String, dynamic> user = Get.arguments;

  @override
  Widget build(BuildContext context) {
    // print(user);
    updateNim.text = user['nim'];
    updateName.text = user['name'];
    updateEmail.text = user['email'];

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
            readOnly: true,
            controller: updateNim,
            // ignore: prefer_const_constructors
            decoration: const InputDecoration(
                labelText: 'Nim', border: OutlineInputBorder()),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: updateName,
            decoration: const InputDecoration(
                labelText: 'Name', border: OutlineInputBorder()),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            readOnly: true,
            controller: updateEmail,
            decoration: const InputDecoration(
                labelText: 'Email', border: OutlineInputBorder()),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              updateProfile(user['uid']);
              print("Clik");
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
