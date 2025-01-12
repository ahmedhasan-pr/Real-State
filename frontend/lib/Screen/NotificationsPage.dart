import 'package:flutter/material.dart';
import 'package:intl/intl.dart';  // استيراد مكتبة intl لتنسيق التاريخ
import 'package:frontend/Api/api.dart'; // استيراد ملف API
import 'package:frontend/Model/model.dart';  // استيراد نموذج الإشعار

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          "الاشعارات",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      body: FutureBuilder<List<Notifications>>(
        future: getNotifications(),  // استدعاء دالة جلب الإشعارات من ملف api.dart
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('لا توجد إشعارات.'));
          } else {
            // عرض الإشعارات
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var notification = snapshot.data![index];
                  return NotificationCard(
                    message: notification.message,
                    date: notification.createdAt,
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final String message;
  final DateTime date;

  const NotificationCard({
    super.key,
    required this.message,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    // تنسيق التاريخ باستخدام intl
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    String formattedTime = DateFormat('hh:mm a').format(date);

    String displayDate;
    final currentDate = DateTime.now();

    if (date.year == currentDate.year &&
        date.month == currentDate.month &&
        date.day == currentDate.day) {
      displayDate = formattedTime;
    } else {
      displayDate = formattedDate;
    }

    return SizedBox(
      height: 150,
      width: double.infinity,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10),
        color: Colors.blueGrey[100],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 5.0,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // عرض التاريخ أو "اليوم"
                  Text(
                    displayDate,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  const Text(
                    "الرسالة",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Flexible(
                child: Text(
                  message,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                  overflow: TextOverflow.ellipsis, // لتجنب تجاوز النص
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
