import 'package:brainsys/homepage.dart';
import 'package:brainsys/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    scaffoldMessengerKey: messengerKey,
    debugShowCheckedModeBanner: false, home: HomePage()));
}
