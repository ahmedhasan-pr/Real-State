import 'dart:convert';
import 'package:frontend/Model/model.dart';
import 'package:http/http.dart' as http;

Future<List<House>> getAllDetails() async {
  const String baseUrl = "http://10.0.2.2:8000/api/house/";
  try {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final utf8Response = utf8.decode(response.bodyBytes);
      List<dynamic> jsonResponse = jsonDecode(utf8Response);
      print("Full response: $jsonResponse"); // طباعة الاستجابة كاملة
      return jsonResponse.map((data) => House.fromJson(data)).toList();
    } else {
      throw Exception('Server Error : ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to load details: $e');
  }
}

/// api الخاص بالاشعارات 

Future<List<Notifications>> getNotifications() async {
  const String baseUrl = 'http://10.0.2.2:8000/api/notification/'; // تأكد من أن URL هو الصحيح
  try {
    // إرسال طلب GET إلى الـ API
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      // إذا كانت الاستجابة ناجحة، نقوم بتحويلها إلى كائنات Notification
      final utf8Response = utf8.decode(response.bodyBytes);
      List<dynamic> jsonResponse = jsonDecode(utf8Response);

      // تحويل البيانات المستلمة إلى قائمة من الإشعارات
      return jsonResponse.map((data) => Notifications.fromJson(data)).toList();
    } else {
      throw Exception('فشل في تحميل الإشعارات: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('حدث خطأ أثناء جلب الإشعارات: $e');
  }
}

Future<void> registerUser(String email, String password, String confirmPassword) async {
  final url = Uri.parse('http://10.0.2.2:8000/api/signup/'); // URL الخاص بـ API

  try {
    // إرسال بيانات التسجيل
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'password': password,
        'confirm_password': confirmPassword,
      }),
    );

    if (response.statusCode == 201) {
      // نجاح التسجيل
      print('User signup successfully');
    } else {
      // فشل التسجيل - عرض التفاصيل من الاستجابة
      print('Failed to signup user: ${response.body}');
    }
  } catch (e) {
    // التعامل مع الخطأ عند حدوث مشكلة في الاتصال
    print('Error occurred: $e');
  }
}

///تسجيل الدخول 


Future<void> loginUser(String email, String password) async {
  final url = Uri.parse('http://10.0.2.2:8000/api/login/');

  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      // إذا كانت الاستجابة ناجحة
      print('User logged in successfully');
      // يمكنك هنا تنفيذ أي إجراء بعد تسجيل الدخول بنجاح، مثل تخزين التوكن أو الانتقال لصفحة أخرى.
    } else {
      // فشل تسجيل الدخول
      final errorResponse = json.decode(response.body);
      String errorMessage = 'حدث خطأ في تسجيل الدخول';

      // تحقق من وجود خطأ في الاستجابة
      if (errorResponse.containsKey('non_field_errors')) {
        errorMessage = errorResponse['non_field_errors'][0]; // استرجاع الرسالة من الـ API
      }

      // طباعة الرسالة أو التعامل معها بطريقة مخصصة
      print('Failed to log in: $errorMessage');
    }
  } catch (e) {
    // التعامل مع الأخطاء في الشبكة أو الطلب
    print('Error occurred: $e');
  }
}
