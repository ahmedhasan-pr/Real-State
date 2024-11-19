import 'package:flutter/material.dart';
import 'package:intl/intl.dart';  // استيراد مكتبة intl لتنسيق التاريخ

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "الاشعارات",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            NotificationCard(
              message: 'لقد تم تحديث التطبيق.',
              date: DateTime.now(),  // التاريخ الحالي
            ),
            
          ],
        ),
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

    String formatttedTime = DateFormat('hh:mm a').format(date);

    String displayDate;
    final currentDate = DateTime.now();

    if(date.year == currentDate.year &&
        date.month == currentDate.month && 
        date.day == currentDate.day ){
          displayDate = formatttedTime;
        } else{
          displayDate = formattedDate;
        }

    return SizedBox(
      height: 130,
      width: double.infinity,  // استخدام الحجم الكامل لعرض البطاقة
      child: Card(
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
                  // عرض الرسالة
                 
                ],
              ),
              const SizedBox(height: 20,),
               Flexible(
                    child: Text(
                      message,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                      overflow: TextOverflow.ellipsis,  // لتجنب تجاوز النص
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
