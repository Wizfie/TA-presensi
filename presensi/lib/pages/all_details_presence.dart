// ignore_for_file: must_be_immutable, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AllDetail extends StatelessWidget {
  AllDetail({super.key});

  var warna = [
    const Color.fromARGB(255, 190, 190, 190),
    const Color.fromARGB(255, 32, 167, 245)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.amber,
            floating: true,
            pinned: true,
            snap: false,
            centerTitle: false,
            title: const Text('History'),
            bottom: AppBar(
              backgroundColor: Colors.amber,
              automaticallyImplyLeading: false,
              title: Container(
                width: double.infinity,
                height: 40,
                color: Colors.white,
                child: const Center(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search for something',
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Other Sliver Widgets
          SliverList(
            delegate: SliverChildListDelegate([
              ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(20),
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return SingleChildScrollView(
                    child: Container(
                      height: 240,
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
                                "${DateFormat.yMMMMEEEEd().format(DateTime.now())}",
                              ),
                            ],
                          ),
                          const Divider(
                            thickness: 2,
                          ),
                          Column(
                            children: [
                              Column(
                                children: [
                                  ListTile(
                                    leading: const Icon(
                                      Icons.circle,
                                      color: Colors.green,
                                    ),
                                    title: const Padding(
                                      padding: EdgeInsets.only(bottom: 5),
                                      child: Text("IN :"),
                                    ),
                                    subtitle: Padding(
                                      padding: const EdgeInsets.only(bottom: 3),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: const [
                                          Padding(
                                            padding: EdgeInsets.only(bottom: 3),
                                            child: Text("Time"),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(bottom: 3),
                                            child: Text("Location"),
                                          ),
                                        ],
                                      ),
                                    ),
                                    trailing: const Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Text("Telat"),
                                    ),
                                  ),
                                  const Divider(
                                    thickness: 1,
                                  ),
                                  ListTile(
                                    leading: const Icon(
                                      Icons.circle,
                                      color: Colors.red,
                                    ),
                                    title: const Padding(
                                      padding: EdgeInsets.only(bottom: 5),
                                      child: Text("OUT :"),
                                    ),
                                    subtitle: Padding(
                                      padding: const EdgeInsets.only(bottom: 3),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: const [
                                          Padding(
                                            padding: EdgeInsets.only(bottom: 3),
                                            child: Text("Time"),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(bottom: 3),
                                            child: Text("Location"),
                                          ),
                                        ],
                                      ),
                                    ),
                                    trailing: const Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Text("Pulang"),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
