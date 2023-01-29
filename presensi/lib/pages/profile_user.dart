// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:presensi/controller/form_profile_control.dart';
import 'package:presensi/controller/role_control.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: streamUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            const Center(
              child: CircularProgressIndicator(),
            );
          }
          Map<String, dynamic> user = snapshot.data!.data()!;
          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Text("nama"),
              Text("nama"),
              Text("nama"),
              Text("nama"),
            ],
          );
        },
      ),
    );
  }
}
