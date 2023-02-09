import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
      .orderBy('date', descending: true)
      .limitToLast(3)
      .snapshots();
}

Stream<QuerySnapshot<Map<String, dynamic>>> streamAllDetail() async* {
  String uid = auth.currentUser!.uid;

  yield* firestore
      .collection("siswa")
      .doc(uid)
      .collection('presence')
      .orderBy('date', descending: true)
      .snapshots();
}

Stream<DocumentSnapshot<Map<String, dynamic>>> streamDoc() async* {
  String uid = auth.currentUser!.uid;

  String todayUid =
      DateFormat.yMd().format(DateTime.now()).replaceAll("/", "-");

  yield* firestore
      .collection("siswa")
      .doc(uid)
      .collection('presence')
      .doc(todayUid)
      .snapshots();
}
