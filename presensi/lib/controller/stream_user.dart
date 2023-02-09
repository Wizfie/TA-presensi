import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

RxBool isloading = true.obs;

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;

// Data Siswa
Stream<DocumentSnapshot<Map<String, dynamic>>> streamCollect1() async* {
  String uid = auth.currentUser!.uid;

  yield* firestore.collection("siswa").doc(uid).snapshots();
}

// Data siswa view admin
Stream<QuerySnapshot<Map<String, dynamic>>> streamAdmin() async* {
  // String uid = auth.currentUser!.uid;

  yield* firestore.collection("siswa").orderBy('role').snapshots();
}

// Data Absen Siswa
Stream<QuerySnapshot<Map<String, dynamic>>> streamCollect2() async* {
  String uid = auth.currentUser!.uid;

  yield* firestore
      .collection("siswa")
      .doc(uid)
      .collection('presence')
      .orderBy('date', descending: true)
      .snapshots();
}

// Data semua presensi siswa
Stream<QuerySnapshot<Map<String, dynamic>>> streamAllDetail() async* {
  String uid = auth.currentUser!.uid;

  yield* firestore
      .collection("siswa")
      .doc(uid)
      .collection('presence')
      .orderBy('date', descending: true)
      .snapshots();
}

// Data waktu presensi

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

Future<void> Delete(String uid) {
  return firestore.collection('siswa').doc(uid).delete();
}

// Data
Stream<QuerySnapshot<Map<String, dynamic>>> streamAdminDetail() async* {
  String uid = auth.currentUser!.uid;

  yield* firestore
      .collection("siswa")
      .doc(uid)
      .collection('presence')
      .orderBy('date', descending: true)
      .snapshots();
}
