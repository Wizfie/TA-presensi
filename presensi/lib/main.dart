// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:presensi/pages/login_page.dart';
import 'package:presensi/routes/route.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MaterialApp(
              home: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(
                    color: Colors.cyan,
                  ),
                ),
              ),
            );
          }
          print(snapshot.data);
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Presensi App',
            home:  const LoginPage(),
            initialRoute:
                snapshot.data != null ? RouteName.admin : RouteName.login,
            getPages: AppPage.pages,
          );
        }),
  );
}
