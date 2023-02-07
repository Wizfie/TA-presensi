import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

RxBool isloading = true.obs;

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;

Stream<DocumentSnapshot<Map<String, dynamic>>> streamCollect1() async* {
  String uid = auth.currentUser!.uid;

  yield* firestore.collection("siswa").doc(uid).snapshots();
}

Stream<QuerySnapshot<Map<String, dynamic>>> streamCollect2() async* {
  String uid = auth.currentUser!.uid;

  yield* firestore
      .collection("siswa")
      .doc(uid)
      .collection('presence')
      .orderBy('date')
      .limitToLast(3)
      .snapshots();
}
