// ignore_for_file: must_be_immutable, avoid_print, sized_box_for_whitespace, unnecessary_string_interpolations, prefer_is_empty

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:intl/intl.dart';
import 'package:presensi/controller/stream_user.dart';
import 'package:presensi/routes/route.dart';

import '../controller/bottom_nav_control.dart';
import '../controller/presence_control.dart';

class HomeAdmin extends StatelessWidget {
  HomeAdmin({super.key});
  var warna = [
    const Color.fromARGB(251, 2, 156, 184),
    const Color.fromARGB(255, 92, 92, 91),
    const Color.fromARGB(226, 44, 199, 186),
    const Color.fromARGB(226, 44, 199, 186),
  ];

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[800],
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: GNav(
              backgroundColor: Colors.black,
              selectedIndex: 0,
              color: Colors.white,
              activeColor: Colors.white,
              tabBackgroundColor: Colors.grey.shade800,
              padding: const EdgeInsets.all(20),
              gap: 10,
              onTabChange: (int i) => changeIndex(i),
              tabs: const [
                GButton(
                  margin: EdgeInsets.only(left: 60),
                  icon: Icons.home,
                  text: "Home",
                ),
                GButton(
                  margin: EdgeInsets.only(right: 60),
                  icon: Icons.people_alt,
                  text: "Profile",
                ),
              ]),
        ),
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

              return ListView(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Initicon(
                                text: "${user['name']}",
                                style: const TextStyle(color: Colors.white),
                                elevation: 4,
                                size: 80,
                                backgroundColor: Colors.blue.shade600,
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
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
                                        fontWeight: FontWeight.w300,
                                        color: Colors.white),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text("${user['name']}",
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      )),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Text("${user['role']}",
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white,
                                          )),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        width: 5,
                                        height: 2,
                                        color: Colors.white,
                                      ),
                                      Text("${user['nim']}",
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white,
                                          )),
                                    ],
                                  )
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
                  if (user['role'] == "siswa")
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
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
                                    color: Colors.red,
                                  ),
                                  title: const Text(
                                    "Location",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  subtitle: Text(
                                    user['address'] ?? "Location not avaliable",
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.white),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  const SizedBox(
                    height: 15,
                  ),
                  if (user['role'] == "siswa")
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: ElevatedButton(
                        onPressed: () {
                          // klik presence
                          presenceButton();
                        },
                        child: const Text("Presence"),
                      ),
                    ),
                  if (user['role'] == "siswa")
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
                        return Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
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
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Center(
                                              child: Text(
                                                todayAtt?['In'] == null
                                                    ? "-,-"
                                                    : "${DateFormat.jm().format(DateTime.parse(todayAtt!['In']['date']))}",
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    } else {
                                      return Container(
                                        decoration: const BoxDecoration(
                                            color: Colors.green,
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
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Center(
                                              child: Text(
                                                todayAtt?['In'] == null
                                                    ? "-,-"
                                                    : "${DateFormat.jm().format(DateTime.parse(todayAtt!['In']['date']))}",
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
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
                                            color: Colors.red,
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
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Center(
                                              child: Text(
                                                todayAtt?['Out'] == null
                                                    ? "-,-"
                                                    : "${DateFormat.jm().format(DateTime.parse(todayAtt!['Out']['date']))}",
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    } else {
                                      return Container(
                                        decoration: const BoxDecoration(
                                            color: Colors.red,
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
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Center(
                                              child: Text(
                                                todayAtt?['Out'] == null
                                                    ? "-,-"
                                                    : "${DateFormat.jm().format(DateTime.parse(todayAtt!['In']['date']))}",
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
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
                        );
                      },
                    ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (user['role'] == "siswa")
                    SingleChildScrollView(
                      child: Expanded(
                        child: Container(
                          height: 200,
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          color: Colors.white,
                          child: Column(
                            children: [
                              // ignore: prefer_const_constructors
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: const Text(
                                  "History",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const Divider(
                                thickness: 1,
                              ),

                              StreamBuilder(
                                  stream: streamCollect2(),
                                  builder: (context, snapshot2) {
                                    if (snapshot2.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    } else {}

                                    if (snapshot2.data?.docs.length == 0 ||
                                        snapshot2.data == null) {
                                      Expanded(
                                        child: Container(
                                          height: 1001,
                                          width: 1000,
                                          color: Colors.amber,
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

                                        return Column(
                                          children: [
                                            SingleChildScrollView(
                                              child: InkWell(
                                                onTap: () {
                                                  //aksi
                                                  Get.toNamed(RouteName.detailP,
                                                      arguments: data);
                                                  print(index);
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      20.0),
                                                  child: Container(
                                                    height: 130,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            bottom: 10),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            20),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      color:
                                                          Colors.grey.shade300,
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            const Text(
                                                              "IN :",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Text(
                                                                "${DateFormat.yMEd().format(DateTime.parse(data['date']))}"),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(data['In']
                                                                    ?['date'] ==
                                                                null
                                                            ? "-.-"
                                                            : "${DateFormat.Hms().format(DateTime.parse(data['In']!['date']))}"),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: const [
                                                            Text(
                                                              "OUT :",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Text("Present")
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(data['Out']
                                                                    ?['date'] ==
                                                                null
                                                            ? "-.-"
                                                            : "${DateFormat.Hms().format(DateTime.parse(data['Out']!['date']))}"),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              child: MaterialButton(
                                                color: Colors.white,
                                                onPressed: () {
                                                  //
                                                  Get.toNamed(
                                                      RouteName.allDetail);
                                                },
                                                child: const Text(
                                                  "See more...",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }),
                              // Container(
                              //   height: 300,
                              //   width: 300,
                              //   color: Colors.amber,
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  Container(
                    height: 100,
                    width: 100,
                    color: Colors.amber,
                  ),
                  if (user['role'] == "admin")
                    Expanded(
                      child: Container(
                        child: Column(
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        height: 700,
                        color: Colors.red,
                      ),
                    ),
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
    );
  }
}
