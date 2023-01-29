// ignore_for_file: must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presensi/routes/route.dart';

class HomeAdmin extends StatelessWidget {
  HomeAdmin({super.key});

  FirebaseAuth auth = FirebaseAuth.instance;
  // final user = FirebaseAuth.instance.currentUser!;

  // sign user out method
  // void signUserOut() {
  //   FirebaseAuth.instance.signOut();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Admin"),
        centerTitle: true,
        backgroundColor: Colors.grey[900],
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(RouteName.profile),
            icon: const Icon(Icons.person),
          )
        ],
      ),
      body: SafeArea(
        child: Center(
            child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                "LOGGED IN AS: ADMIN",
                // ${user.email!}
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black),
                ),
                onPressed: () async {
                  await auth.signOut();
                  Get.offAllNamed(RouteName.login);
                },
                child: const Text('Logout'),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
