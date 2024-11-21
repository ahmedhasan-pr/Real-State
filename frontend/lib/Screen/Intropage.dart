import 'package:flutter/material.dart';
import 'package:frontend/Account/LoginPage.dart';
import 'package:frontend/Screen/NavBarPage.dart';

class Intropage extends StatefulWidget {
  const Intropage({super.key});

  @override
  State<Intropage> createState() => _IntropageState();
}

class _IntropageState extends State<Intropage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(seconds: 1), vsync: this)
          ..forward();

    
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(children: [
          Image.asset(
            "assets/intro.jpg",
            fit: BoxFit.cover,
            height: 900.9,
          ),
          Positioned(
            bottom: 130.0,
            right: 10.0,
            child: FadeTransition(
              opacity: _controller,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                color: Colors.black45,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "العثور على منزل أحلامك",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                    ),
                    SizedBox(height: 8),
                    Text(
                      "أفضل الخيارات المتاحة في السوق",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                    ),
                    SizedBox(height: 8.0), // مسافة إضافية بين النصوص
                    // الوصف
                    Text(
                      "استكشف مجموعة واسعة من الخيارات التي تناسب جميع الأذواق \n والميزانيات. فريقنا متواجد لمساعدتك في كل خطوة على الطريق.",
                      style: TextStyle(
                        color: Colors.white60, // لون وصف النص
                        fontSize: 15.0, // حجم الخط للوصف
                        fontWeight: FontWeight.w300, // سمك الخط للوصف
                      ),
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 40,
            right: 30,
            child: SizedBox(
              height: 70,
              width: 370,
              child: ElevatedButton(
                
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginPage()));
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        12), // No rounding for sharp corners
                  ),
                ),
                child: const Text(
                  ' ابدأ ',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
