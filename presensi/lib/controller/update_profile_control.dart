import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateProfileController extends GetxController {
  UpdateProfileController(Type string);
  final updateNim = TextEditingController();
  final updateName = TextEditingController();
  final updateEmail = TextEditingController();
}
