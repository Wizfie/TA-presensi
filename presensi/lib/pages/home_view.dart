// ignore_for_file: must_be_immutable, avoid_print, sized_box_for_whitespace, unnecessary_string_interpolations, prefer_is_empty

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:presensi/controller/bottom_control.dart';
import 'package:presensi/controller/stream_user.dart';
import 'package:presensi/routes/route.dart';

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
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (user['role'] != "admin")
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: ListTile(
                                leading: const Icon(
                                  Icons.location_on,
                                  size: 40,
                                ),
                                title: const Text(
                                  "Location",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  user['address'] ?? "Location not avaliable",
                                  style: const TextStyle(fontSize: 15),
                                )),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(
                    height: 15,
                  ),
                  StreamBuilder(
                      stream: streamDoc(),
                      builder: (context, snapshot3) {
                        if (snapshot3.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        Map<String, dynamic>? todayAtt = snapshot3.data!.data();
                        return Row(
                          children: <Widget>[
                            Expanded(
                              child: LayoutBuilder(
                                builder: (context, constraints) {
                                  if (constraints.maxWidth > 600) {
                                    return Container(
                                      decoration: const BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 190, 190, 190),
                                          borderRadius:
                                              BorderRadiusDirectional.all(
                                            Radius.circular(20),
                                          )),
                                      height: 100,
                                      width: constraints.maxWidth / 2,
                                      child: Column(
                                        children: [
                                          const Center(
                                            child: Text(
                                              "IN",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Center(
                                            child: Text(todayAtt?['In'] == null
                                                ? "-,-"
                                                : "${DateFormat.jm().format(DateTime.parse(todayAtt!['In']['date']))}"),
                                          ),
                                        ],
                                      ),
                                    );
                                  } else {
                                    return Container(
                                      decoration: const BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 190, 190, 190),
                                          borderRadius:
                                              BorderRadiusDirectional.all(
                                            Radius.circular(20),
                                          )),
                                      height: 100,
                                      width: constraints.maxWidth,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Center(
                                            child: Text(
                                              "IN",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Center(
                                            child: Text(todayAtt?['In'] == null
                                                ? "-,-"
                                                : "${DateFormat.jm().format(DateTime.parse(todayAtt!['In']['date']))}"),
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
                                          color: Color.fromARGB(
                                              255, 190, 190, 190),
                                          borderRadius:
                                              BorderRadiusDirectional.all(
                                            Radius.circular(20),
                                          )),
                                      height: 100,
                                      width: constraints.maxWidth / 2,
                                      child: Column(
                                        children: [
                                          const Center(
                                            child: Text(
                                              "OUT",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Center(
                                            child: Text(todayAtt?['Out'] == null
                                                ? "-,-"
                                                : "${DateFormat.jm().format(DateTime.parse(todayAtt!['Out']['date']))}"),
                                          ),
                                        ],
                                      ),
                                    );
                                  } else {
                                    return Container(
                                      decoration: const BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 190, 190, 190),
                                          borderRadius:
                                              BorderRadiusDirectional.all(
                                            Radius.circular(20),
                                          )),
                                      height: 100,
                                      width: constraints.maxWidth,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Center(
                                            child: Text(
                                              "OUT",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Center(
                                            child: Text(todayAtt?['Out'] == null
                                                ? "-,-"
                                                : "${DateFormat.jm().format(DateTime.parse(todayAtt!['In']['date']))}"),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        );
                      }),
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
                          Get.toNamed(RouteName.allDetail);
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
                  StreamBuilder(
                    stream: streamCollect2(),
                    builder: (context, snapshot2) {
                      if (snapshot2.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot2.data?.docs.length == 0 ||
                          snapshot2.data == null) {
                        return const SizedBox(
                          height: 200,
                          child: Center(
                            child: Text("No Data"),
                          ),
                        );
                      }

                      return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot2.data!.docs.length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> data =
                              snapshot2.data!.docs[index].data();
                          return SingleChildScrollView(
                            child: InkWell(
                              onTap: () {
                                //aksi
                                Get.toNamed(RouteName.detailP, arguments: data);
                                print(index);
                              },
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
                                            "${DateFormat.yMEd().format(DateTime.parse(data['date']))}"),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(data['In']?['date'] == null
                                        ? "-.-"
                                        : "${DateFormat.Hms().format(DateTime.parse(data['In']!['date']))}"),
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
                                    Text(data['Out']?['date'] == null
                                        ? "-.-"
                                        : "${DateFormat.Hms().format(DateTime.parse(data['Out']!['date']))}"),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
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
          },
        ),
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
