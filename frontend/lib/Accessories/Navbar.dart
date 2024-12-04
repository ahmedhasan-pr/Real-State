import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Navbar extends StatelessWidget {
  const Navbar({required this.onTap, super.key});
  final void Function(int) onTap; // تغيير إلى final و non-nullable

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      iconSize: 35,
      selectedFontSize: 19,
      selectedItemColor: Colors.yellow.shade900,
      unselectedItemColor: Colors.grey,
      currentIndex: 2,
      onTap: (value) => onTap(value),
      elevation: 0,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home_filled),
          label: "",
        ),
      ],
    );
  }
}
