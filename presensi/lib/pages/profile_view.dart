// ignore_for_file: must_be_immutable, unused_local_variable, sized_box_for_whitespace, unnecessary_string_interpolations

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presensi/controller/login_control.dart';
import 'package:presensi/controller/profile_control.dart';
import 'package:presensi/controller/update_profile_control.dart';

import '../routes/route.dart';

class UserProfile extends StatelessWidget {
  UserProfile({super.key});

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
            String profileImage =
                "https://ui-avatars.com/api/?name=${user['name']}";

            String gambar =
                "https://firebasestorage.googleapis.com/v0/b/presensi-26273.appspot.com/o/a.png?alt=media&token=18b00bef-065d-4003-ac11-948efa0346a4";
            print('aaaaa');
            print("${user['name']}");
            return ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipOval(
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  // "${user['aa']}",
                                  gambar,
                                ))),
                        // child: Image.network(
                        //   "${user['role']}",
                        //   // user["profile"],
                        //   // != ""
                        //   //     ? user['profile']
                        //   //     : profileImage,
                        //   // : profileImage,
                        //   fit: BoxFit.cover,
                        // ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 50, top: 10),
                      child: Column(
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
                Container(
                  // margin: const EdgeInsets.only(left: 0, right: 280),
                  child: OutlinedButton.icon(
                      style: const ButtonStyle(
                          padding: MaterialStatePropertyAll(EdgeInsets.all(1)),
                          fixedSize: MaterialStatePropertyAll(Size(15, 15))),
                      onPressed: () {
                        //
                        updatePict();
                      },
                      icon: const Icon(
                        Icons.add_a_photo_outlined,
                        size: 13,
                        color: Colors.black,
                      ),
                      label: const Text(
                        " Change",
                        style: TextStyle(color: Colors.black, fontSize: 13),
                      )),
                ),
                const Divider(
                  thickness: 0.5,
                ),
                const SizedBox(
                  height: 15,
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
