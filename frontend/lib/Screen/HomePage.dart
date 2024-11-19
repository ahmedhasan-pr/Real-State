import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:frontend/Screen/DetailsPage.dart';
import 'package:frontend/Screen/NotificationsPage.dart';

// تعريف صفحة HomePage
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

// الحالة الخاصة بـ HomePage
class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController; // متحكم التبويب

  @override
  void initState() {
    super.initState();
    // تهيئة متحكم التبويب بعدد 3 تبويبات
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose(); // تحرير موارد المتحكم
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          // زر فتح الدرج الجانبي
          IconButton(
            onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NotificationsPage(),
                      ),
                    ),
            icon: Icon(
              Icons.notifications,
              size: 45,
              color: Colors.grey.shade400,
            ),
          ),
        ],
      ),
      // الدرج الجانبي

      body: Column(
        children: [
          // عنوان الصفحة
          const Padding(
            padding: EdgeInsets.only(left: 230, top: 20),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Text(" اكتشف\n منزلك الجديد",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(height: 20),
          // صف يحتوي على زر وحقل بحث
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  // زر فرز
                  SizedBox(
                    height: 55,
                    width: 70,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade500,
                        shadowColor: Colors.black,
                        elevation: 9,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                      child:
                          Image.asset("assets/sort.png", width: 24, height: 24),
                    ),
                  ),
                  const SizedBox(width: 10),
                  // حقل البحث
                  Expanded(
                    child: TextField(
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(color: Colors.black, width: 3),
                        ),
                        hintText: 'أماكن البحث',
                        suffixIcon: const Icon(Icons.search, size: 35),
                        filled: true,
                        fillColor: Colors.white,
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                        ),
                        enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 1)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          // أزرار التبويب
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 0),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: ButtonsTabBar(
                  splashColor: Colors.black,
                  elevation: 2,
                  contentCenter: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  buttonMargin: const EdgeInsets.symmetric(horizontal: 30),
                  controller: _tabController,
                  backgroundColor: Colors.black,
                  unselectedBackgroundColor: Colors.white,
                  labelStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                  unselectedLabelStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                  tabs: const [
                    Tab(text: 'منزل'),
                    Tab(text: 'قطع اراضي'),
                    Tab(text: 'شقق'),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          // عرض محتوى التبويبات
          Expanded(
            flex: 8,
            child: TabBarView(
              controller: _tabController,
              children: [
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DetailsPage()),
                  ),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: GridView.builder(
                      scrollDirection: Axis.vertical,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // عدد الأعمدة
                        childAspectRatio: 0.9, // نسبة العرض إلى الارتفاع
                        mainAxisSpacing: 10, // المسافة العمودية بين العناصر
                        crossAxisSpacing: 0, // المسافة الأفقية بين العناصر
                      ),
                      itemCount: 4,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          color: Colors.white,
                          margin: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 4),
                          shadowColor: Colors.black,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          child: Stack(children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: const DecorationImage(
                                  image: AssetImage(
                                    "assets/house1.jpg",
                                  ),
                                  fit: BoxFit.cover, // تغطية الصورة
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Card(
                                shape: BeveledRectangleBorder(
                                    borderRadius: BorderRadius.circular(2)),
                                color: Colors.white,
                                child: const Text("\$120,000"),
                              ),
                            ),
                            const Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 65),
                                  child: Text(
                                    "للبيع",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(right: 10, bottom: 15),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        color: Colors.white60,
                                      ),
                                      Text(
                                        " حي الواسطي",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20,
                                          color: Colors.white60,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ]),
                        );
                      },
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DetailsPage()),
                  ),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: GridView.builder(
                      scrollDirection: Axis.vertical,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // عدد الأعمدة
                        childAspectRatio: 0.9, // نسبة العرض إلى الارتفاع
                        mainAxisSpacing: 10, // المسافة العمودية بين العناصر
                        crossAxisSpacing: 0, // المسافة الأفقية بين العناصر
                      ),
                      itemCount: 4,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          color: Colors.white,
                          margin: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 4),
                          shadowColor: Colors.black,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          child: Stack(children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: const DecorationImage(
                                  image: AssetImage(
                                    "assets/house1.jpg",
                                  ),
                                  fit: BoxFit.cover, // تغطية الصورة
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Card(
                                shape: BeveledRectangleBorder(
                                    borderRadius: BorderRadius.circular(2)),
                                color: Colors.white,
                                child: const Text("\$120,000"),
                              ),
                            ),
                            const Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 65),
                                  child: Text(
                                    "للبيع",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(right: 10, bottom: 15),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        color: Colors.white60,
                                      ),
                                      Text(
                                        " حي الواسطي",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20,
                                          color: Colors.white60,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ]),
                        );
                      },
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DetailsPage()),
                  ),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: GridView.builder(
                      scrollDirection: Axis.vertical,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // عدد الأعمدة
                        childAspectRatio: 0.9, // نسبة العرض إلى الارتفاع
                        mainAxisSpacing: 10, // المسافة العمودية بين العناصر
                        crossAxisSpacing: 0, // المسافة الأفقية بين العناصر
                      ),
                      itemCount: 4,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          color: Colors.white,
                          margin: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 4),
                          shadowColor: Colors.black,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          child: Stack(children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: const DecorationImage(
                                  image: AssetImage(
                                    "assets/house1.jpg",
                                  ),
                                  fit: BoxFit.cover, // تغطية الصورة
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Card(
                                shape: BeveledRectangleBorder(
                                    borderRadius: BorderRadius.circular(2)),
                                color: Colors.white,
                                child: const Text("\$120,000"),
                              ),
                            ),
                            const Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 65),
                                  child: Text(
                                    "للبيع",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(right: 10, bottom: 15),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        color: Colors.white60,
                                      ),
                                      Text(
                                        " حي الواسطي",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ]),
                        );
                      },
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
