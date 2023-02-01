import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presensi/controller/update_password.dart';

class UpdatePassword extends StatelessWidget {
  const UpdatePassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: const Text('Change password'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: currPass,
            decoration: const InputDecoration(
                labelText: 'Current Password', border: OutlineInputBorder()),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: newPass,
            decoration: const InputDecoration(
                labelText: 'New Password', border: OutlineInputBorder()),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: rePass,
            decoration: const InputDecoration(
                labelText: ' Re-Password', border: OutlineInputBorder()),
          ),
          const SizedBox(
            height: 10,
          ),
          Obx(
            () => GestureDetector(
              onTap: () {
                if (isLoading.isFalse) {
                  updatePassword();
                }
              },
              child: Container(
                height: 50,
                color: Colors.black,
                alignment: Alignment.center,
                child: Text(
                  isLoading.isFalse ? "Update" : "Updating...",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
