import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

RxBool isloading = true.obs;

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;

Stream<DocumentSnapshot<Map<String, dynamic>>> streamUser() async* {
  String uid = await auth.currentUser!.uid;

  yield* firestore.collection("siswa").doc(uid).snapshots();
}
