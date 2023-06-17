import 'package:flutter/material.dart';
import 'package:sqflite_demo/consts/app_string_consts.dart';
import 'package:sqflite_demo/screens/product_list_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.productmanagement,
      home: ProductListScreen(),
    );
  }
}
