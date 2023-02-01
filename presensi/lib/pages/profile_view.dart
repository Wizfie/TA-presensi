// ignore_for_file: must_be_immutable, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presensi/controller/login_control.dart';
import 'package:presensi/controller/profile_control.dart';

import '../routes/route.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: streamUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            Map<String, dynamic> user = snapshot.data!.data()!;
            return ListView(
              padding: const EdgeInsets.all(20),
              children: [
                InkWell(
                  onTap: () {
                    //
                  },
                  child: const CircleAvatar(
                    radius: 50,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "${user['name']}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "${user['email']}",
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 30,
                ),
                ListTile(
                  onTap: () => Get.toNamed(RouteName.addsiswa),
                  leading: const Icon(Icons.person_add_alt_1),
                  title: const Text("Add Siswa"),
                ),
                ListTile(
                  onTap: () =>
                      Get.toNamed(RouteName.updateprofile, arguments: user),
                  leading: const Icon(Icons.person),
                  title: const Text("Update Profile"),
                ),
                ListTile(
                  onTap: () {
                    Get.toNamed(RouteName.updatepassword);
                  },
                  leading: const Icon(Icons.lock_reset_outlined),
                  title: const Text("Change Password"),
                ),
                ListTile(
                  onTap: () {
                    {
                      logOut();
                    }

                    ///
                  },
                  leading: const Icon(Icons.logout),
                  title: const Text("Logout"),
                )
              ],
            );
          } else {
            return Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("Loading...")
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
