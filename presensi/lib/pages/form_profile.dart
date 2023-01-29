// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:presensi/controller/form_profile_control.dart';

class FormProfile extends StatelessWidget {
  const FormProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        // leading: IconButton(
        //   onPressed: () {
        //     Get.back();
        //   },
        //   icon: Icon(Icons.arrow_back_ios_new),
        // ),
        // automaticallyImplyLeading: false,
        backgroundColor: Colors.grey[900],
        title: const Text('Profile'),

        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            "Complete your profile ",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const Divider(
            thickness: 0.3,
            color: Colors.grey,
          ),
          const SizedBox(
            height: 20,
          ),
          // TextField(
          //   controller: nimC,
          //   // ignore: prefer_const_constructors
          //   decoration: const InputDecoration(
          //       labelText: 'Nim', border: OutlineInputBorder()),
          // ),
          // const SizedBox(
          //   height: 20,
          // ),
          // TextField(
          //   controller: nameC,
          //   decoration: const InputDecoration(
          //       labelText: 'Name', border: OutlineInputBorder()),
          // ),
          // const SizedBox(
          //   height: 20,
          // ),
          // TextField(
          //   controller: emailC,
          //   decoration: const InputDecoration(
          //       labelText: 'Email', border: OutlineInputBorder()),
          // ),
          TextField(
            controller: newpasssC,
            decoration: const InputDecoration(
                labelText: 'New password', border: OutlineInputBorder()),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              CompleteProfile();
            },
            child: Container(
              height: 50,
              color: Colors.black,
              alignment: Alignment.center,
              child: const Text(
                "Save",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
