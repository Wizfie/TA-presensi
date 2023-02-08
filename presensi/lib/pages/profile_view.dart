// ignore_for_file: must_be_immutable, unused_local_variable, sized_box_for_whitespace, unnecessary_string_interpolations, avoid_unnecessary_containers, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presensi/controller/bottom_control.dart';
import 'package:presensi/controller/login_control.dart';
import 'package:presensi/controller/stream_user.dart';

import '../routes/route.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: streamCollect1(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            Map<String, dynamic> user = snapshot.data!.data()!;
            String profileImage =
                "https://ui-avatars.com/api/?name=${user['name']}";

            // String gambar =
            //     "https://firebasestorage.googleapis.com/v0/b/presensiapp-6a5e8.appspot.com/o/Screenshot%202023-01-08%20174754.png?alt=media&token=e6661610-3612-441e-bc7f-e20c7c086787";
            return ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Row(
                  children: [
                    ClipOval(
                      child: Container(
                        width: 100,
                        height: 100,
                        // color: Colors.grey[400],
                        child: Image.network(
                          profileImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 50, top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${user['name']}",
                            style: const TextStyle(
                                fontSize: 20,
                                height: 2.5,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "${user['email']}",
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            "${user['role']}",
                            style: const TextStyle(
                              height: 3,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 7,
                ),
                const Divider(
                  thickness: 1,
                ),
                const SizedBox(
                  height: 45,
                ),
                if (user["role"] == "admin")
                  ListTile(
                    onTap: () => Get.toNamed(RouteName.addsiswa),
                    leading: const Icon(Icons.person_add_alt_1),
                    title: const Text("Add Siswa"),
                  ),
                // if (user['role'] != "admin")
                //   Container(
                //     height: 100,
                //     width: 100,
                //     color: Colors.red,
                //   ),
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
                    width: 10,
                  ),
                  const Text("Data Tidak Ada ...")
                ],
              ),
            );
          }
        },
      ),
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: Colors.black,
        top: -10,
        initialActiveIndex: index.value = 2,
        items: const [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.fingerprint_outlined, title: 'Attedance'),
          TabItem(icon: Icons.people, title: 'Profile'),
        ],
        onTap: (int i) => changeIndex(i),
      ),
    );
  }
}
