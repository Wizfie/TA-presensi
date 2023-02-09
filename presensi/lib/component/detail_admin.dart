import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class DetailAdmin extends StatelessWidget {
  DetailAdmin({super.key});
  Map<String, dynamic> siswa = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Text(
          "${siswa['name']}",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
// ${user.email!}
