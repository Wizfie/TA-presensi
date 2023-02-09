// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:presensi/controller/addsiswa_control.dart';

class AddSiswa extends StatelessWidget {
  const AddSiswa({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        // leading: IconButton(
        //   onPressed: () {
        //     Get.back();
        //   },
        //   icon: Icon(Icons.arrow_back_ios_new),
        // ),
        // automaticallyImplyLeading: false,
        backgroundColor: Colors.grey[900],
        title: const Text('Tambah Siswa'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: nimC,
            // ignore: prefer_const_constructors
            decoration: const InputDecoration(
                labelText: 'Nim', border: OutlineInputBorder()),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: nameC,
            decoration: const InputDecoration(
                labelText: 'Name', border: OutlineInputBorder()),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: emailC,
            decoration: const InputDecoration(
                labelText: 'Email', border: OutlineInputBorder()),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              addSiswa();
              nameC.clear();
              nimC.clear();
              emailC.clear();
            },
            child: Container(
              height: 50,
              color: Colors.black,
              alignment: Alignment.center,
              child: const Text(
                "Submit",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
