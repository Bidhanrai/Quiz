import 'package:flutter/material.dart';
import 'package:quick_quiz/Constant/Constant.dart';
import 'package:quick_quiz/View/HomeView.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        //primarySwatch: Colors.blue,
        primaryColor: Constant.primaryColor,
      ),
      home: HomeView(),
    );
  }
}

