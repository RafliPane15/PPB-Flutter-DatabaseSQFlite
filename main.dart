import 'package:flutter/material.dart';
import 'package:flutterappexample/pages/cartpage.dart';
import 'package:flutterappexample/pages/homepage.dart';
import 'package:flutterappexample/pages/shoppage.dart';
import 'package:flutterappexample/themes/color.dart';
import 'package:flutterappexample/models/shop.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Shop(),
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      theme: theme,
      routes: {
        '/homepage': (context) => const HomePage(),
        '/shoppage': (context) => const Shoppage(),
        '/cartpage': (context) => const CartPage(),
      },
    );
  }
}
