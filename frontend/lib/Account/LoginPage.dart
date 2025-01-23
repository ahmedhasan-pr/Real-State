// lib/pages/login_page.dart

import 'package:flutter/material.dart';
import 'package:frontend/Accessories/TextFild.dart'; // افترض وجود هذا المكون في مشروعك
import 'package:frontend/Account/RegisterPage.dart';
import 'package:frontend/Api/api.dart';
import 'package:frontend/Screen/NavBarPage.dart'; // الصفحة التي تذهب إليها بعد نجاح تسجيل الدخول

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  bool isLoading = false;

  // دالة تسجيل الدخول
  Future<void> _login() async {
    if (emailTextController.text.isEmpty || passwordTextController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى إدخال البريد الإلكتروني وكلمة المرور')),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    // استخدام خدمة التسجيل
    await loginUser(
      emailTextController.text,
      passwordTextController.text,
    );

    setState(() {
      isLoading = false;
    });

    // هنا يمكن إضافة المزيد من المنطق إذا كنت تحتاج للانتقال أو إظهار رسائل أخرى
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const NavBarPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          // حقل البريد الإلكتروني
          TextFieldWidget(
            controller: emailTextController,
            hintText: 'البريد الإلكتروني',
            obscureText: false,
          ),
          const SizedBox(height: 30),
          // حقل كلمة المرور
          TextFieldWidget(
            controller: passwordTextController,
            hintText: 'كلمة المرور',
            obscureText: true,
          ),
          const SizedBox(height: 30),
          // زر تسجيل الدخول
          SizedBox(
            height: 60,
            width: 340,
            child: ElevatedButton(
              onPressed: isLoading ? null : _login,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow.shade900,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                shadowColor: Colors.black,
                elevation: 15,
              ),
              child: isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text(
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
          // أزرار تسجيل الدخول عبر وسائل التواصل الاجتماعي
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
                    textStyle: MaterialStateProperty.all<TextStyle>(
                      const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                  onPressed: () {
                    // الانتقال إلى صفحة التسجيل
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const RegisterPage()),
                    );
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
    );
  }
}
