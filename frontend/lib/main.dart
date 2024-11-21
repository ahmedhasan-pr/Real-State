import 'package:flutter/material.dart';
import 'package:frontend/Provider/FavoriteProvider.dart';
import 'package:frontend/Screen/HomePage.dart';
import 'package:frontend/Screen/Intropage.dart';
import 'package:frontend/Screen/NavBarPage.dart';
import 'package:frontend/Screen/NotificationsPage.dart';
import 'package:provider/provider.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return ChangeNotifierProvider(
      create: (context)=>FavoriteProvider(),
      child: const MaterialApp(
       debugShowCheckedModeBanner: false,
       home: Intropage(),
      ),
    );
  }
}
