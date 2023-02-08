// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:presensi/pages/add_siswa.dart';
import 'package:presensi/pages/all_details_presence.dart';
import 'package:presensi/pages/form_profile.dart';
import 'package:presensi/pages/home_view.dart';
import 'package:presensi/pages/login_page.dart';
import 'package:presensi/pages/profile_view.dart';
import 'package:presensi/pages/update_password.dart';
import 'package:presensi/pages/update_profile.dart';

import '../pages/details_presence.dart';

class AppPage {
  static final pages = [
    GetPage(
      name: RouteName.login,
      page: () => const LoginPage(),
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: RouteName.homeView,
      page: () => HomeAdmin(),
      middlewares: [MyMiddelware()],
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: RouteName.profile,
      page: () => const UserProfile(),
      transition: Transition.fadeIn,
      middlewares: [MyMiddelware()],
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: RouteName.addsiswa,
      page: () => const AddSiswa(),
      middlewares: [MyMiddelware()],
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: RouteName.form,
      page: () => const FormProfile(),
      middlewares: [MyMiddelware()],
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: RouteName.updatepassword,
      page: () => const UpdatePassword(),
      middlewares: [MyMiddelware()],
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: RouteName.updateprofile,
      page: () => UpdateProfile(),
      middlewares: [MyMiddelware()],
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: RouteName.detailP,
      page: () => DetailPresence(),
      middlewares: [MyMiddelware()],
      transition: Transition.zoom,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: RouteName.allDetail,
      page: () => AllDetail(),
      middlewares: [MyMiddelware()],
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 400),
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
  static const homeView = "/homeView";
  static const profile = "/profile";
  static const addsiswa = "/addSiswa";
  static const form = "/form";
  static const updatepassword = "/updatepassword";
  static const updateprofile = "/updateprofile";
  static const detailP = "/detail";
  static const allDetail = "/allDetail";
}
