import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:presensi/controller/stream_user.dart';

import '../routes/route.dart';

class DetailAdmin extends StatelessWidget {
  DetailAdmin({super.key});
  var siswa = Get.arguments;

  @override
  Widget build(BuildContext context) {
    print("dibawah");
    print(siswa);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.amber,
            floating: true,
            pinned: true,
            snap: false,
            centerTitle: true,
            title: const Text('History'),
            // bottom: AppBar(
            //   backgroundColor: Colors.amber,
            //   automaticallyImplyLeading: false,
            //   // title: Container(
            //   //   width: double.infinity,
            //   //   height: 40,
            //   //   color: Colors.white,
            //   //   child: const Center(
            //   //     child: TextField(
            //   //       decoration: InputDecoration(
            //   //         hintText: 'Search for something',
            //   //         prefixIcon: Icon(Icons.search),
            //   //       ),
            //   //     ),
            //   //   ),
            //   // ),
            // ),
          ),
          // Other Sliver Widgets
          SliverList(
            delegate: SliverChildListDelegate([
              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: streamAdminDetail(siswa['uid']),
                  builder: (context, snapAll) {
                    if (snapAll.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapAll.data?.docs.length == 0 ||
                        snapAll.data == null) {
                      return const SizedBox(
                        height: 200,
                        child: Center(
                          child: Text("No Data"),
                        ),
                      );
                    }
                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.all(20),
                      shrinkWrap: true,
                      itemCount: snapAll.data!.docs.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> data =
                            snapAll.data!.docs[index].data();
                        return SingleChildScrollView(
                          child: InkWell(
                            onTap: () {
                              //aksi
                              Get.toNamed(RouteName.detailP, arguments: data);
                              print(index);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Container(
                                height: 130,
                                margin: const EdgeInsets.only(bottom: 10),
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey.shade300,
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
                          ),
                        );
                      },
                    );
                  }),
            ]),
          ),
        ],
      ),
    );
  }

  //   return Scaffold(
  //     backgroundColor: Colors.white,
  //     body: StreamBuilder(
  //         stream: streamAdminDetail(siswa['uid']),
  //         builder: (context, snapshot) {
  //           if (snapshot.connectionState == ConnectionState.waiting) {
  //             return const Center(
  //               child: CircularProgressIndicator(),
  //             );
  //           }
  //           if (snapshot.data?.docs.length == 0 || snapshot.data == null) {
  //             return const SizedBox(
  //               height: 200,
  //               child: Center(
  //                 child: Text("No Data"),
  //               ),
  //             );
  //           }
  //           return Column(
  //             children: [
  //               Container(
  //                 color: Colors.blue,
  //               ),
  //               ListView.builder(
  //                 physics: const BouncingScrollPhysics(),
  //                 padding: const EdgeInsets.all(20),
  //                 shrinkWrap: true,
  //                 itemCount: snapshot.data!.docs.length,
  //                 itemBuilder: (context, index) {
  //                   Map<String, dynamic> data =
  //                       snapshot.data!.docs[index].data();
  //                   return SingleChildScrollView(
  //                     child: InkWell(
  //                       onTap: () {
  //                         //aksi
  //                         Get.toNamed(RouteName.detailP, arguments: data);
  //                         print(index);
  //                       },
  //                       child: Padding(
  //                         padding: const EdgeInsets.all(20.0),
  //                         child: Container(
  //                           height: 130,
  //                           margin: const EdgeInsets.only(bottom: 10),
  //                           padding: const EdgeInsets.all(20),
  //                           decoration: BoxDecoration(
  //                             borderRadius: BorderRadius.circular(20),
  //                             color: Colors.grey.shade300,
  //                           ),
  //                           child: Column(
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               Row(
  //                                 mainAxisAlignment:
  //                                     MainAxisAlignment.spaceBetween,
  //                                 children: [
  //                                   const Text(
  //                                     "IN :",
  //                                     style: TextStyle(
  //                                         fontWeight: FontWeight.bold),
  //                                   ),
  //                                   Text(
  //                                       "${DateFormat.yMEd().format(DateTime.parse(data['date']))}"),
  //                                 ],
  //                               ),
  //                               const SizedBox(
  //                                 height: 5,
  //                               ),
  //                               Text(data['In']?['date'] == null
  //                                   ? "-.-"
  //                                   : "${DateFormat.Hms().format(DateTime.parse(data['In']!['date']))}"),
  //                               const SizedBox(
  //                                 height: 10,
  //                               ),
  //                               Row(
  //                                 mainAxisAlignment:
  //                                     MainAxisAlignment.spaceBetween,
  //                                 children: const [
  //                                   Text(
  //                                     "OUT :",
  //                                     style: TextStyle(
  //                                         fontWeight: FontWeight.bold),
  //                                   ),
  //                                   Text("Present")
  //                                 ],
  //                               ),
  //                               const SizedBox(
  //                                 height: 5,
  //                               ),
  //                               Text(data['Out']?['date'] == null
  //                                   ? "-.-"
  //                                   : "${DateFormat.Hms().format(DateTime.parse(data['Out']!['date']))}"),
  //                             ],
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   );
  //                 },
  //               ),
  //             ],
  //           );

  //           // return ListView.builder(
  //           //   itemCount: snapshot.data!.docs.length,
  //           //   itemBuilder: (context, index) {
  //           //     var data2 = snapshot.data!.docs[index].data();

  //           //     print("data2");
  //           //     print(data2);

  //           //     return Container(
  //           //       child: Text(
  //           //         "Address : ${data2['In']!['address']}",
  //           //       ),
  //           //     );
  //           //   },
  //           // );
  //         }),
  //   );
  // }
}
// ${user.email!}
