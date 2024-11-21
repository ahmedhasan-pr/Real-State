// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:frontend/Accessories/TextFild.dart';
import 'package:frontend/Account/RegisterPage.dart';
import 'package:frontend/Screen/NavBarPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  void _login() async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/login/'),  // الرابط المحدد
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': emailTextController.text,  // استخدم emailTextController
        'password': passwordTextController.text,
      }),
    );

    if (response.statusCode == 200) {
      // تسجيل الدخول ناجح
      final message = jsonDecode(response.body)['message'];
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
      // يمكنك هنا الانتقال إلى الصفحة الرئيسية أو أي صفحة أخرى
    } else {
      // فشل تسجيل الدخول
      final errorMessage = jsonDecode(response.body)['error'] ?? 'فشل في تسجيل الدخول';
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMessage)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30, top: 100),
              child: RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'بيت ',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: 'الأحلام',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.yellow.shade900,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 50),
            const Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.only(right: 40),
                child: Text(
                  'تسجيل الدخول إلى حسابك',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            TextFieldWidget(
              controller: emailTextController,
              hintText: 'البريد الاكتروني',
              obscureText: false,
            ),
            const SizedBox(height: 30),
            Expanded(
              flex: 0,
              child: TextFieldWidget(
                controller: passwordTextController,
                hintText: 'كلمة المرور',
                obscureText: true,
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              height: 60,
              width: 340,
              child: ElevatedButton(
                onPressed: (){Navigator.of(context).push(MaterialPageRoute(builder: (context)=>NavBarPage()));},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow.shade900,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  shadowColor: Colors.black,
                  elevation: 15,
                ),
                child: const Text(
                  'تسجيل الدخول',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const Divider(height: 70, color: Colors.white),
            Text(
              '- أو قم بتسجيل الدخول باستخدام -',
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                children: [
                  SizedBox(
                    height: 80,
                    width: 120,
                    child: Card(
                      color: Colors.white,
                      shadowColor: Colors.black,
                      elevation: 5,
                      child: Center(
                        child: Image.asset(
                          "assets/google.png",
                          fit: BoxFit.contain,
                          width: 100,
                          height: 30,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 80,
                    width: 120,
                    child: Card(
                      color: Colors.white,
                      shadowColor: Colors.black,
                      elevation: 5,
                      child: Center(
                        child: Image.asset(
                          "assets/facebook.png",
                          fit: BoxFit.contain,
                          width: 100,
                          height: 30,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 80,
                    width: 120,
                    child: Card(
                      color: Colors.white,
                      shadowColor: Colors.black,
                      elevation: 5,
                      child: Center(
                        child: Image.asset(
                          "assets/instagram.png",
                          fit: BoxFit.contain,
                          width: 100,
                          height: 30,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 60),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 115),
              child: Row(
                children: [
                  TextButton(
                    style: ButtonStyle(
                      textStyle: WidgetStateProperty.all<TextStyle>(
                        const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));
                      print("زر الاشتراك تم الضغط عليه");
                    },
                    child: const Text('اشتراك'),
                  ),
                  Text(
                    'ليس لديك حساب',
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
