// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:frontend/Accessories/TextFild.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmpasswordTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        resizeToAvoidBottomInset: false,
       
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30, top: 70),
              child: RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'بيت ',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // يمكنك تغيير اللون هنا
                      ),
                    ),
                    TextSpan(
                      text: 'الأحلام',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.yellow.shade900, // لون مختلف للنصف الثاني
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            const Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.only(right: 40),
                child: Text(
                  'إنشاء حساب',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // لون مختلف للنصف الثاني
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            TextFieldWidget(
              controller: emailTextController,
              hintText: 'البريد الاكتروني',
              obscureText: false,
            ),
            const SizedBox(
              height: 30,
            ),
            TextFieldWidget(
              controller: passwordTextController,
              hintText: 'كلمة المرور',
              obscureText: true,
            ),
            const SizedBox(
              height: 30,
            ),
            TextFieldWidget(
              controller: confirmpasswordTextController,
              hintText: 'تأكيد كلمة المرور',
              obscureText: true,
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 60,
              width: 340,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow.shade900,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    shadowColor: Colors.black,
                    elevation: 15),
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
            const Divider(
              height: 50,
              color: Colors.white,
            ),
            Text(
              '- أو قم بالتسجيل مع -',
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
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
                        // استخدام Center لمركز الصورة داخل الـ Card
                        child: Image.asset(
                          "assets/google.png",
                          fit: BoxFit.contain, // ملاءمة الصورة داخل المساحة
                          width: 100, // تحديد عرض الصورة
                          height: 30, // تحديد ارتفاع الصورة
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
                        // استخدام Center لمركز الصورة داخل الـ Card
                        child: Image.asset(
                          "assets/facebook.png",
                          fit: BoxFit.contain, // ملاءمة الصورة داخل المساحة
                          width: 100, // تحديد عرض الصورة
                          height: 30, // تحديد ارتفاع الصورة
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
                        // استخدام Center لمركز الصورة داخل الـ Card
                        child: Image.asset(
                          "assets/instagram.png",
                          fit: BoxFit.contain, // ملاءمة الصورة داخل المساحة
                          width: 100, // تحديد عرض الصورة
                          height: 30, // تحديد ارتفاع الصورة
                        ),
                      ),
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
