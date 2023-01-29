import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presensi/controller/login_control.dart';

class MyButton extends StatelessWidget {
  final Function()? onPress;

  const MyButton({super.key, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: onPress,
        child: Container(
          padding: const EdgeInsets.all(25),
          margin: const EdgeInsets.symmetric(horizontal: 25),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              isLoading.isFalse ? "Sign In" : "Loading...",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
