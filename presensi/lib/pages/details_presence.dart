// ignore_for_file: must_be_immutable, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DetailPresence extends StatelessWidget {
  DetailPresence({super.key});

  var warna = [
    const Color.fromARGB(255, 190, 190, 190),
    const Color.fromARGB(255, 32, 167, 245)
  ];

  Map<String, dynamic> data = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Detail"),
        backgroundColor: Colors.grey[900],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(20),
                shrinkWrap: true,
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Container(
                    height: 400,
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
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${DateFormat.yMMMMEEEEd().format(DateTime.parse(data['date']))}",
                            ),
                          ],
                        ),
                        const Divider(
                          thickness: 2,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Column(
                          children: [
                            Column(
                              children: [
                                ListTile(
                                  leading: Container(
                                    height: 200,
                                    width: 15,
                                    color: Colors.green,
                                  ),
                                  title: const Padding(
                                    padding: EdgeInsets.only(bottom: 5),
                                    child: Text(
                                      "IN :",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(bottom: 3),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 3),
                                          child: Text(data['In']?["date"] ==
                                                  null
                                              ? "Time : -,-"
                                              : "Time : ${DateFormat.jms().format(DateTime.parse(data['In']["date"]))}"),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 3),
                                          child: Text(
                                            data['In']?['Lat'] == null &&
                                                    data['In']?['long'] == null
                                                ? "Location : -,-"
                                                : "Location : ${data['In']!['Lat']},${data['In']!['long']}",
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 3),
                                          child: Text(
                                            data['In']?['address'] == null
                                                ? "Address : -,-"
                                                : "Address : ${data['In']!['address']}",
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 3),
                                          child: Text(
                                            data['In']?['status'] == null
                                                ? "Status : -,-"
                                                : "Status : ${data['In']!['status']}",
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 3),
                                          child: Text(
                                            data['In']?['distance'] == null
                                                ? "Distance : -,-"
                                                : "Distance : ${data['In']!['distance'].toString().split(".").first} m",
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // ignore: prefer_const_constructors
                                  trailing: Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    // ignore: prefer_const_constructors
                                    child: Text(
                                      "Present",
                                      // ignore: prefer_const_constructors
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                const Divider(
                                  thickness: 1,
                                ),
                                ListTile(
                                  leading: Container(
                                    height: 200,
                                    width: 15,
                                    color: Colors.red,
                                  ),
                                  title: const Padding(
                                    padding: EdgeInsets.only(bottom: 5),
                                    child: Text(
                                      "OUT :",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(bottom: 3),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 3),
                                          child: Text(data['Out']?["date"] ==
                                                  null
                                              ? "Time : -,-"
                                              : "Time : ${DateFormat.jms().format(DateTime.parse(data['Out']["date"]))}"),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 3),
                                          child: Text(
                                            data['Out']?['Lat'] == null &&
                                                    data['Out']?['long'] == null
                                                ? "Location : -,-"
                                                : "Location : ${data['Out']!['Lat']},${data['Out']!['long']}",
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 3),
                                          child: Text(
                                            data['Out']?['address'] == null
                                                ? "Address : -,-"
                                                : "Address : ${data['Out']!['address']}",
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 3),
                                          child: Text(
                                            data['Out']?['status'] == null
                                                ? "Status : -,-"
                                                : "Status : ${data['Out']!['status']}",
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 3),
                                          child: Text(
                                            data['Out']?['distance'] == null
                                                ? "Distance : -,-"
                                                : "Distance : ${data['Out']!['distance'].toString().split(".").first} m",
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  trailing: const Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Text(
                                      "Go Home",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
