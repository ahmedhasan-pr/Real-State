import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:frontend/Screen/NotificationsPage.dart';
import 'package:frontend/Screen/EditProfilePage.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isDarkModeEnabled = false; // Default value

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Align(
            alignment: Alignment.topRight,
            child: Text(
              "اعدادات",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25, // Font size
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            const Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Text(
                  "الحساب",
                  style: TextStyle(fontSize: 35),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Card(
                  color: Colors.grey.shade500,
                  child: IconButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>  EditProfilePage(),
                      ),
                    ),
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      size: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
                const Column(
                  children: [
                    Text(
                      "احمد حسن",
                      style: TextStyle(fontSize: 25),
                    ),
                    Text(
                      " المعلومات الشخصية",
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      padding: const EdgeInsets.all(23),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade500,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Text(
                  "الاعدادات",
                  style: TextStyle(fontSize: 35),
                ),
              ),
            ),
            // Language settings row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Card(
                  color: Colors.grey.shade500,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      size: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 50),
                const Text(
                  "اللغة",
                  style: TextStyle(fontSize: 30),
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      padding: const EdgeInsets.all(23),
                      decoration: BoxDecoration(
                        color: Colors.red.shade200,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Icon(
                        Icons.language,
                        color: Colors.orange.shade100,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Notifications settings row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Card(
                  color: Colors.grey.shade500,
                  child: IconButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NotificationsPage(),
                      ),
                    ),
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      size: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  "الاشعارات",
                  style: TextStyle(fontSize: 25),
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      padding: const EdgeInsets.all(23),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Icon(
                        Icons.notifications,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Dark mode switcher row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: SizedBox(
                    height: 70,
                    child: DayNightSwitcherIcon(
                      isDarkModeEnabled: isDarkModeEnabled,
                      onStateChanged: (isDarkModeEnabled) {
                        setState(() {
                          this.isDarkModeEnabled = isDarkModeEnabled;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(),
                const Text(
                  "الوضع المظلم",
                  style: TextStyle(fontSize: 25),
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      padding: const EdgeInsets.all(23),
                      decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Icon(
                        Icons.dark_mode,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 15),
              child: ElevatedButton(
                onPressed: () {},
                 style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red, // لون الزر
                      minimumSize: const Size(double.infinity, 75), // زر بعرض كامل
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 5, // إضافة ظل خفيف للزر
                    ),
                child:  const Text(
                  'تسجيل الخروج',
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
