import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Moduls/BotttomBar/bottomBar.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid ?
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyB-4OsTSAWMpkwe_w9Hn_l0w0OG7W2pZaA",
        appId: "1:824408597186:android:f5ec3aba2ef0eeeb7bd15b",
        messagingSenderId: "824408597186",
        projectId: "task-27315")
  ) :
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BottomBar(),
    );
  }
}
