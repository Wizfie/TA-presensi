import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:presensi/pages/login_page.dart';
import 'home_page.dart';

// void route() {
//   User? user = FirebaseAuth.instance.currentUser;
//   FirebaseFirestore.instance
//       .collection('users')
//       .doc(user!.uid)
//       .get()
//       .then((DocumentSnapshot documentSnapshot) {
//     if (documentSnapshot.exists) {
//       if (documentSnapshot.get('role') == "admin") {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) => HomeAdmin(),
//           ),
//         );
//       } else {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) => HomePage(),
//           ),
//         );
//       }
//     } else {
//       print('Document does not exist on the database');
//     }
//   });
// }

class AuthPage extends StatelessWidget {
  AuthPage({super.key});

  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // user is logged in
          if (snapshot.hasData) {
            return HomePage();
          }

          // user is NOT logged in
          else {
            return const LoginPage();
          }
        },
      ),
    );
  }
}
