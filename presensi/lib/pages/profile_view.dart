// ignore_for_file: must_be_immutable, unused_local_variable, sized_box_for_whitespace, unnecessary_string_interpolations, avoid_unnecessary_containers, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:presensi/controller/login_control.dart';
import 'package:presensi/controller/stream_user.dart';

import '../controller/bottom_nav_control.dart';
import '../routes/route.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        color: Colors.black,
        child: GNav(
          backgroundColor: Colors.black,
          selectedIndex: 1,
          color: Colors.white,
          activeColor: Colors.white,
          tabBackgroundColor: Colors.grey.shade800,
          padding: const EdgeInsets.all(20),
          gap: 10,
          onTabChange: (int i) => changeIndex(i),
          tabs: const [
            GButton(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(left: 60, top: 10),
              icon: Icons.home,
              text: "Home",
            ),
            GButton(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(right: 60, top: 10),
              icon: Icons.people_alt,
              text: "Profile",
            ),
          ],
        ),
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
            return ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Initicon(
                        text: "${user['name']}",
                        elevation: 4,
                        size: 80,
                        backgroundColor: Colors.brown,
                        border: Border.all(
                          color: Colors.black,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 50, top: 50),
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
                  Card(
                    child: ListTile(
                      onTap: () => Get.toNamed(RouteName.addsiswa),
                      leading: const Icon(Icons.person_add_alt_1),
                      title: const Text("Add Siswa"),
                    ),
                  ),
                // if (user['role'] != "admin")
                //   Container(
                //     height: 100,
                //     width: 100,
                //     color: Colors.red,
                //   ),
                Card(
                  child: ListTile(
                    onTap: () =>
                        Get.toNamed(RouteName.updateprofile, arguments: user),
                    leading: const Icon(Icons.person),
                    title: const Text("Update Profile"),
                  ),
                ),
                Card(
                  child: ListTile(
                    onTap: () {
                      Get.toNamed(RouteName.updatepassword);
                    },
                    leading: const Icon(Icons.lock_reset_outlined),
                    title: const Text("Change Password"),
                  ),
                ),
                Card(
                  child: ListTile(
                    onTap: () {
                      {
                        logOut();
                      }

                      ///
                    },
                    leading: const Icon(Icons.logout),
                    title: const Text("Logout"),
                  ),
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
    );
  }
}
