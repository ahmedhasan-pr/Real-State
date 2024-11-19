import 'package:flutter/material.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'الملف الشخصي',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            GestureDetector(
              onTap: () {
                // Implement image picker functionality here
              },
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey[200],
                child: Icon(
                  Icons.camera_alt,
                  size: 40,
                  color: Colors.grey[800],
                ),
              ),
            ),
            const SizedBox(height: 50),
            const EditTextField(
              label: 'الاسم',
              autofocus: true, // سيحصل هذا الحقل على التركيز تلقائيًا عند فتح الصفحة
              obscureText: true,
              icon: Icons.person,
            ),
            const SizedBox(height: 20),
            const EditTextField(
              label: 'البريد الاكتروني',
              obscureText: true,
              icon: Icons.email,
            ),
            const SizedBox(height: 20),
            const EditTextField(
              label: 'رقم الهاتف',
              
              obscureText: true,
              icon: Icons.phone,
            ),
            const SizedBox(height: 20),
            const EditTextField(
              label: 'الرمز السري',
              obscureText: true,
              icon: Icons.lock,
            ),
            const SizedBox(height: 20),
            const EditTextField(
              label: 'تأكيد الرمز السري',
              obscureText: true,
              icon: Icons.lock_outline,
            ),
            const SizedBox(height: 30),

            // Save Button
            ElevatedButton(
              onPressed: () {
                // Implement save functionality here
                print("Profile information saved!");
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                backgroundColor: Colors.blue,
                textStyle: const TextStyle(fontSize: 16), // Button color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'حفظ التغييرات',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class EditTextField extends StatelessWidget {
  final String label;
  final TextInputType inputType;
  final bool obscureText;
  final IconData? icon;
  final TextEditingController? controller;
  final bool autofocus;

  const EditTextField({
    super.key,
    required this.label,
    this.inputType = TextInputType.text,
    this.obscureText = false,
    this.icon,
    this.controller,
    this.autofocus = false,  // إضافة خيار autofocus
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl, // لتحديد الكتابة من اليمين لليسار
      child: TextField(
        autofocus: autofocus,
        controller: controller,
        keyboardType: inputType,
        obscureText: obscureText,
        textAlign: TextAlign.right, // محاذاة النص على اليمين
        decoration: InputDecoration(
          labelText: label,  // نص التسمية
          labelStyle: const TextStyle(color: Colors.grey),  // لون النص
          hintText: 'أدخل $label هنا',  // نص تلميحي
          hintStyle: const TextStyle(color: Colors.grey),  // لون النص التلميحي
          border: const OutlineInputBorder(  // تحديد شكل الحافة
            borderRadius: BorderRadius.all(Radius.circular(10)),  // تدوير الحواف
            borderSide: BorderSide(color: Colors.blue),  // لون الحافة
          ),
          focusedBorder: const OutlineInputBorder(  // تغيير شكل الحافة عند التركيز
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Colors.blueAccent, width: 2),  // تغيير اللون عند التركيز
          ),
          enabledBorder: const OutlineInputBorder(  // الحافة الافتراضية
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Colors.grey, width: 1),  // الحافة العادية
          ),
          suffixIcon: icon != null ? Icon(icon, color: Colors.grey) : null,  // إضافة أيقونة في نهاية الحقل (إن وجدت)
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),  // Padding داخل الحقل
        ),
      ),
    );
  }
}

