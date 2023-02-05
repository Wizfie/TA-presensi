// ignore_for_file: must_be_immutable, avoid_print, sized_box_for_whitespace, unnecessary_string_interpolations

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:presensi/controller/bottom_control.dart';
import 'package:presensi/controller/stream_user.dart';

class HomeAdmin extends StatelessWidget {
  HomeAdmin({super.key});
  var warna = [
    const Color.fromARGB(255, 190, 190, 190),
    const Color.fromARGB(255, 32, 167, 245)
  ];

  FirebaseAuth auth = FirebaseAuth.instance;

  // String profileImage = "https://ui-avatars.com/api/?name=${user['name']}";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Home"),
        centerTitle: true,
        backgroundColor: Colors.grey[900],
      ),
      body: SafeArea(
        child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
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

                return ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: warna[0],
                              borderRadius: const BorderRadiusDirectional.all(
                                  Radius.circular(20))),
                          // width: 460,
                          height: 180,
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            children: [
                              ClipOval(
                                child: Container(
                                  width: 70,
                                  height: 70,
                                  // color: Colors.grey[400],
                                  child: Image.network(
                                    profileImage,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              Container(
                                height: 70,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                    const Text(
                                      "Welcome ,",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text("${user['name']}",
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600)),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text("${user['nim']}",
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400)),
                                    // const SizedBox(
                                    //   height: 5,
                                    // ),
                                    // Text("${user['role']}",
                                    //     style: const TextStyle(
                                    //         fontSize: 12,
                                    //         fontWeight: FontWeight.w400))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              if (constraints.maxWidth > 600) {
                                return Container(
                                  decoration: const BoxDecoration(
                                      color: Color.fromARGB(255, 190, 190, 190),
                                      borderRadius: BorderRadiusDirectional.all(
                                        Radius.circular(20),
                                      )),
                                  height: 100,
                                  width: constraints.maxWidth / 2,
                                  child: Column(
                                    children: const [
                                      Center(
                                        child: Text(
                                          "IN",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Center(
                                        child: Text("Container 1"),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                return Container(
                                  decoration: const BoxDecoration(
                                      color: Color.fromARGB(255, 190, 190, 190),
                                      borderRadius: BorderRadiusDirectional.all(
                                        Radius.circular(20),
                                      )),
                                  height: 100,
                                  width: constraints.maxWidth,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: const [
                                      Center(
                                        child: Text(
                                          "IN",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Center(
                                        child: Text("Container 1"),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              if (constraints.maxWidth > 600) {
                                return Container(
                                  decoration: const BoxDecoration(
                                      color: Color.fromARGB(255, 190, 190, 190),
                                      borderRadius: BorderRadiusDirectional.all(
                                        Radius.circular(20),
                                      )),
                                  height: 100,
                                  width: constraints.maxWidth / 2,
                                  child: Column(
                                    children: const [
                                      Center(
                                        child: Text(
                                          "IN",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Center(
                                        child: Text("Container 1"),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                return Container(
                                  decoration: const BoxDecoration(
                                      color: Color.fromARGB(255, 190, 190, 190),
                                      borderRadius: BorderRadiusDirectional.all(
                                        Radius.circular(20),
                                      )),
                                  height: 100,
                                  width: constraints.maxWidth,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: const [
                                      Center(
                                        child: Text(
                                          "OUT",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Center(
                                        child: Text("Container 1"),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      thickness: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Last 5 days",
                          style: TextStyle(fontSize: 15),
                        ),
                        TextButton(
                          onPressed: () {
                            //
                          },
                          child: const Text(
                            "See more...",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      thickness: 2,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return SingleChildScrollView(
                          child: Container(
                            height: 130,
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: warna[0],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "IN :",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                        "${DateFormat.yMEd().format(DateTime.now())}"),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                    "${DateFormat.Hms().format(DateTime.now())}"),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text(
                                      "OUT :",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text("Present")
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                    "${DateFormat.Hms().format(DateTime.now())}"),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  ],
                );
              } else {
                return const Center(
                  child: Text(
                    "404",
                    style: TextStyle(
                      fontSize: 50,
                    ),
                  ),
                );
              }
            }),
      ),
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: Colors.black,
        top: -10,
        initialActiveIndex: index.value = 0,
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
