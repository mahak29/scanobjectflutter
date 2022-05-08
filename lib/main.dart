import 'package:brainsys/homepage.dart';
import 'package:brainsys/scanpage.dart';
import 'package:brainsys/signup.dart';
import 'package:brainsys/welcome.dart';
import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:async';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
   final  camera = await availableCameras();
  final cam = camera.first;

  runApp(MaterialApp(
      scaffoldMessengerKey: messengerKey,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/' : (context) => HomePage(),
        '/second':(context) => DisplayImage(imagePath: '',),
        '/third':(context) => ScanPage(cameras: cam) 
      },
      ));
}
