import 'package:flutter/material.dart';
import 'package:frontend/Accessories/TextFild.dart'; // مكونات حقل الإدخال
import 'package:frontend/Api/api.dart'; // استيراد ملف الـ API

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // تعريف المتحكمات الخاصة بحقول الإدخال
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmpasswordTextController = TextEditingController();

  // حالة التحميل، تستخدم لتفعيل أو تعطيل مؤشر التحميل والزر
  bool isLoading = false;

  // وظيفة تسجيل المستخدم مع مؤشر التحميل
  Future<void> registerUserWithAnimation() async {
    setState(() {
      isLoading = true; // تفعيل حالة التحميل
    });

    try {
      // استدعاء الدالة المسؤولة عن التسجيل في الباك إند
      await registerUser(
        emailTextController.text,
        passwordTextController.text,
        confirmpasswordTextController.text,
      );
      // عرض رسالة نجاح عند اكتمال العملية
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم التسجيل بنجاح')),
      );
    } catch (e) {
      // عرض رسالة خطأ إذا فشلت العملية
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('فشل التسجيل')),
      );
    } finally {
      // إيقاف حالة التحميل بغض النظر عن نجاح أو فشل العملية
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // منع تحريك المحتوى عند ظهور لوحة المفاتيح
      backgroundColor: Colors.white, // خلفية الشاشة بيضاء
      body: Column(
        children: [
          // عنوان الصفحة
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 70),
            child: RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: 'بيت ', // الجزء الأول من النص
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: 'الأحلام', // الجزء الثاني من النص بلون مختلف
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
                'إنشاء حساب', // عنوان فرعي
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          // حقول الإدخال
          TextFieldWidget(
            controller: emailTextController,
            hintText: 'البريد الاكتروني',
            obscureText: false,
          ),
          const SizedBox(height: 30),
          TextFieldWidget(
            controller: passwordTextController,
            hintText: 'كلمة المرور',
            obscureText: true,
          ),
          const SizedBox(height: 30),
          TextFieldWidget(
            controller: confirmpasswordTextController,
            hintText: 'تأكيد كلمة المرور',
            obscureText: true,
          ),
          const SizedBox(height: 30),
          // زر التسجيل مع مؤشر التحميل
          SizedBox(
            height: 60,
            width: 340,
            child: ElevatedButton(
              onPressed: isLoading
                  ? null // تعطيل الزر أثناء التحميل
                  : () {
                      // التحقق من الحقول قبل التسجيل
                      if (emailTextController.text.isEmpty ||
                          passwordTextController.text.isEmpty ||
                          confirmpasswordTextController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('الرجاء ملء جميع الحقول')),
                        );
                        return;
                      }

                      if (passwordTextController.text !=
                          confirmpasswordTextController.text) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('كلمة المرور غير متطابقة')),
                        );
                        return;
                      }

                      // استدعاء وظيفة التسجيل
                      registerUserWithAnimation();
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow.shade900, // لون الزر
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                shadowColor: Colors.black,
                elevation: 15, // ارتفاع الظل
              ),
              child: isLoading
                  ? const CircularProgressIndicator(
                      color: Colors.white, // مؤشر التحميل
                    )
                  : const Text(
                      'تسجيل',
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
            '- أو قم بالتسجيل مع -', // نص الفاصل
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),
          // أزرار التسجيل عبر وسائل التواصل الاجتماعي
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              children: [
                // زر Google
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
                // زر Facebook
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
                // زر Instagram
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
        ],
      ),
    );
  }
}
