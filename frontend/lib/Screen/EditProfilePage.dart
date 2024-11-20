import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final ImagePicker _picker = ImagePicker();
  // إنشاء نسخة من ImagePicker لالتقاط الصور
  File? _image;
  // متغير لتخيزين الصور النختارة
  Future<void> _pickImageFromGallery(BuildContext context) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  // دالة لالتقاط صورة باستخدام الكاميرا
  Future<void> _takePhoto() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _image = File(image.path); // تحديث الصورة المختارة
      });
    }
  }

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
                  // عند الضغط على صورة الملف، عرض خيارات اختيار صورة
                  showModalBottomSheet(
                    context: context,
                    builder: (builder) => bottomsheet(context),
                  );
                },
                child: EditImage(context)),
            const SizedBox(height: 50),
            const EditTextField(
              label: 'الاسم',
              autofocus:
                  true, // سيحصل هذا الحقل على التركيز تلقائيًا عند فتح الصفحة
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

  // ignore: non_constant_identifier_names
  Widget EditImage(BuildContext context) {
    return CircleAvatar(
      radius: 50,
      backgroundColor: Colors.grey[200],
      child: InkWell(
        onTap: () {
          showModalBottomSheet(
            context: context,
            builder: ((builder) => bottomsheet(context)),
          );
        },
        child: _image == null
            ? Icon(
                Icons.camera_alt,
                size: 40,
                color: Colors.grey[800],
              )
            : ClipOval(
                child: Image.file(
                  _image!,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
      ),
    );
  }

  Widget bottomsheet(BuildContext context) {
    return Container(
      height: 80,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          Row(
            children: [
              // زر لالتقاط صورة باستخدام الكاميرا
              TextButton.icon(
                onPressed: () {
                  _takePhoto(); // تنفيذ دالة التقاط صورة
                },
                icon: const Icon(Icons.camera_alt, color: Colors.blue),
                label: const Text('التقاط صورة',
                    style: TextStyle(color: Colors.blue)),
              ),
              // زر لاختيار صورة من المعرض
              TextButton.icon(
                onPressed: () {
                  _pickImageFromGallery(
                      context); // تنفيذ دالة اختيار صورة من المعرض
                },
                icon: const Icon(Icons.image, color: Colors.blue),
                label: const Text('اختيار من المعرض',
                    style: TextStyle(color: Colors.blue)),
              ),
            ],
          ),
        ],
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
    this.autofocus = false, // إضافة خيار autofocus
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
          labelText: label, // نص التسمية
          labelStyle: const TextStyle(color: Colors.grey), // لون النص
          hintText: 'أدخل $label هنا', // نص تلميحي
          hintStyle: const TextStyle(color: Colors.grey), // لون النص التلميحي
          border: const OutlineInputBorder(
            // تحديد شكل الحافة
            borderRadius: BorderRadius.all(Radius.circular(10)), // تدوير الحواف
            borderSide: BorderSide(color: Colors.blue), // لون الحافة
          ),
          focusedBorder: const OutlineInputBorder(
            // تغيير شكل الحافة عند التركيز
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
                color: Colors.blueAccent, width: 2), // تغيير اللون عند التركيز
          ),
          enabledBorder: const OutlineInputBorder(
            // الحافة الافتراضية
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide:
                BorderSide(color: Colors.grey, width: 1), // الحافة العادية
          ),
          suffixIcon: icon != null
              ? Icon(icon, color: Colors.grey)
              : null, // إضافة أيقونة في نهاية الحقل (إن وجدت)
          contentPadding: const EdgeInsets.symmetric(
              horizontal: 20, vertical: 15), // Padding داخل الحقل
        ),
      ),
    );
  }
}
