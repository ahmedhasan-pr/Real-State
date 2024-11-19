import 'package:flutter/material.dart';
import 'package:frontend/Accessories/Navbar.dart';
import 'package:frontend/Screen/Favoritespage.dart';
import 'package:frontend/Screen/HomePage.dart';
import 'package:frontend/Screen/Settingspage.dart';

class NavBarPage extends StatefulWidget {
  const NavBarPage({super.key});

  @override
  State<NavBarPage> createState() => _NavBarPageState();
}

class _NavBarPageState extends State<NavBarPage> {
  int _selectIndex = 2;

  void navigateBottomBar(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  // الصفحات
  final List<Widget> _pages = [
    const SettingsPage(),
    const Favoritespage(),
    
    
    const HomePage(),
    
    
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Navbar(onTap: navigateBottomBar), // تمرير الدالة بشكل صحيح
      body: _pages[_selectIndex], // تصحيح اسم المتغير إلى _pages
    );
  }
}
