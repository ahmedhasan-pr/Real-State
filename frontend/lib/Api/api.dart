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
