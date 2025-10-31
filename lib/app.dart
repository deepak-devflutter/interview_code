
import 'package:flutter/material.dart';
import 'package:interview_code/presentation/view/product_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Products List', home: ProductsScreen());
  }
}