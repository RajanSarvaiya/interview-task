import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class DataController extends GetxController{
  var activeIndex = 0;
  var maxIndex = 0;

  final auth = FirebaseAuth.instance;
  final fireStore =
  FirebaseFirestore.instance.collection('goaldata').snapshots();

  onPageChange(int index) {
    activeIndex = index;
    update();
  }
}