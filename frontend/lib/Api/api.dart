import 'dart:convert';
import 'package:frontend/Model/model.dart';
import 'package:http/http.dart' as http;

Future<List<Details>> getAllDetails() async {
  const String baseUrl = "http://10.0.2.2:8000/api/details/";
  try {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final utf8Response = utf8.decode(response.bodyBytes);
      List<dynamic> jsonResponse = jsonDecode(utf8Response);
      print("Full response: $jsonResponse"); // طباعة الاستجابة كاملة
      return jsonResponse.map((data) => Details.fromJson(data)).toList();
    } else {
      throw Exception('Server Error : ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to load details: $e');
  }
}
