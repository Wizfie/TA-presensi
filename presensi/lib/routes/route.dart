// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:presensi/pages/add_siswa.dart';
import 'package:presensi/pages/form_profile.dart';
import 'package:presensi/pages/home_admin.dart';
import 'package:presensi/pages/login_page.dart';
import 'package:presensi/pages/profile_view.dart';
import 'package:presensi/pages/update_password.dart';
import 'package:presensi/pages/update_profile.dart';

class AppPage {
  static final pages = [
    GetPage(
      name: RouteName.login,
      page: () => const LoginPage(),
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: RouteName.admin,
      page: () => HomeAdmin(),
      middlewares: [MyMiddelware()],
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: RouteName.profile,
      page: () => UserProfile(),
      middlewares: [MyMiddelware()],
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: RouteName.addsiswa,
      page: () => const AddSiswa(),
      middlewares: [MyMiddelware()],
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: RouteName.form,
      page: () => const FormProfile(),
      middlewares: [MyMiddelware()],
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: RouteName.updatepassword,
      page: () => const UpdatePassword(),
      middlewares: [MyMiddelware()],
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: RouteName.updateprofile,
      page: () => UpdateProfile(),
      // binding: BindingsBuilder(() {
      //   Get.put(UpdateProfile());
      // }),
      middlewares: [MyMiddelware()],
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
  ];
}

class MyMiddelware extends GetMiddleware {
  @override
  GetPage? onPageCalled(GetPage? page) {
    print(page?.name);
    return super.onPageCalled(page);
  }
}

abstract class RouteName {
  static const login = "/";
  static const admin = "/admin";
  static const profile = "/profile";
  static const addsiswa = "/addSiswa";
  static const form = "/form";
  static const updatepassword = "/updatepassword";
  static const updateprofile = "/updateprofile";
}
