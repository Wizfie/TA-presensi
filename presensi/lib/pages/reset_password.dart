import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presensi/controller/forgot_password_control.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

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
        title: const Text('Reset password'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: emailReset,
            // ignore: prefer_const_constructors
            decoration: const InputDecoration(
                labelText: 'Email', border: OutlineInputBorder()),
          ),
          const SizedBox(
            height: 20,
          ),
          Obx(
            () => GestureDetector(
              onTap: () {
                if (isLoading.isFalse) {
                  resetPassword();
                }
              },
              child: Container(
                height: 50,
                color: Colors.black,
                alignment: Alignment.center,
                child: Text(
                  isLoading.isFalse ? "Send Email Reset" : "Loading...",
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
