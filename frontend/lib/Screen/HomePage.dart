import 'package:flutter/material.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:frontend/Model/model.dart';
import 'package:frontend/Screen/DetailsPage.dart';
import 'package:frontend/Screen/NotificationsPage.dart';
import 'package:skeletonizer/skeletonizer.dart'; // استيراد Skeletonizer
import 'package:frontend/Api/api.dart'; // تأكد من إضافة استيراد الـ API أو الدالة التي تجلب البيانات.

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Future<List<Details>> futureDetails;

  bool _isLoading = true; // المتغير الذي يعكس حالة التحميل

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    // جلب البيانات بعد التحميل
    futureDetails = getAllDetails();  // تأكد من استخدام دالة getAllDetails لجلب البيانات

    // محاكاة التحميل
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NotificationsPage(),
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
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(left: 230, top: 20),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Text(
                  " اكتشف\n منزلك الجديد",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  SizedBox(
                    height: 55,
                    width: 70,
                    child: ElevatedButton(
                      onPressed: () {
                        // محاكاة التحميل عند الضغط على الزر
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow.shade900,
                        shadowColor: Colors.black,
                        elevation: 9,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      child: Image.asset("assets/sort.png",
                          color: Colors.white, width: 24, height: 24),
                    ),
                  ),
                  const SizedBox(width: 10),
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
                        suffixIcon: Icon(Icons.search,
                            color: Colors.yellow.shade900, size: 35),
                        filled: true,
                        fillColor: Colors.white,
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 1),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: ButtonsTabBar(
                  splashColor: Colors.grey,
                  elevation: 2,
                  contentCenter: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  buttonMargin: const EdgeInsets.symmetric(horizontal: 30),
                  controller: _tabController,
                  backgroundColor: Colors.yellow.shade900,
                  unselectedBackgroundColor: Colors.white,
                  labelStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  unselectedLabelStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  tabs: const [
                    Tab(text: 'منزل'),
                    Tab(text: 'قطع اراضي'),
                    Tab(text: 'شقق'),
                  ],
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
          SliverFillRemaining(
            child: TabBarView(
              controller: _tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildTabContent(),
                _buildTabContent(),
                _buildTabContent(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // دالة عرض الـ Skeletonizer أثناء التحميل
  Widget _buildTabContent() {
    return FutureBuilder<List<Details>>(
      future: futureDetails,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildSkeletonizer(); // عرض الـ Skeletonizer إذا كانت البيانات في حالة تحميل
        } else if (snapshot.hasError) {
          return const Center(child: Text('حدث خطأ في تحميل البيانات'));
        } else if (snapshot.hasData) {
          return _buildContent(snapshot.data!); // عرض المحتوى الثابت بعد اكتمال التحميل
        } else {
          return const Center(child: Text('لا توجد بيانات'));
        }
        
      },
    );
  }

  // دالة عرض الـ Skeletonizer أثناء التحميل
  Widget _buildSkeletonizer() {
    return Skeletonizer(
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 1.2, // نفس النسبة التي تستخدمها في المحتوى
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemCount: 2, // عدد العناصر المعروضة أثناء التحميل
        itemBuilder: (BuildContext context, int index) {
          return Card(
            color: Colors.grey.shade300,
            margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
            shadowColor: Colors.black,
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            child: Container(
              color: Colors.white,
              child: Stack(
                children: [
                  // محاكاة الصورة باستخدام لون رمادي (نفس الحجم)
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade200, // محاكاة الصورة بلون رمادي
                    ),
                    height: 200, // تحديد ارتفاع مشابه للصورة الفعلية
                  ),
                  // محاكاة السعر
                  Positioned(
                    top: 210, // تغيير الموقع ليكون بعد الصورة
                    right: 15,
                    child: Container(
                      width: 100,
                      height: 20,
                      color: Colors.grey.shade400, // لون محاكاة السعر
                    ),
                  ),
                  // محاكاة حالة البيع
                  Positioned(
                    top: 250,
                    right: 15,
                    child: Container(
                      width: 60,
                      height: 15,
                      color: Colors.grey.shade400, // لون محاكاة حالة البيع
                    ),
                  ),
                  // محاكاة المنطقة
                  Positioned(
                    top: 280,
                    right: 15,
                    child: Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.grey.shade600),
                        const SizedBox(
                          width: 210,
                        ),
                        Container(
                          width: 80,
                          height: 15,
                          color: Colors.grey.shade400, // محاكاة المنطقة
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // عرض المحتوى الثابت بعد اكتمال التحميل
  Widget _buildContent(List<Details> data) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1, // إبقاء عمود واحد
        childAspectRatio: 1.2, // الحفاظ على نفس النسبة
        mainAxisSpacing: 10, // زيادة المسافة بين الكارد والكارد
        crossAxisSpacing: 0, // زيادة المسافة بين الأعمدة
      ),
      itemCount: data.length, // عدد العناصر المعروضة
      itemBuilder: (BuildContext context, int index) {
        final details = data[index]; // استخدام البيانات الفعلية
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DetailsPage(), // الانتقال إلى صفحة التفاصيل
              ),
            );
          },
          child: Card(
            color: Colors.white,
            margin: const EdgeInsets.only(
                left: 30, right: 20, bottom: 10), // زيادة المسافة أسفل الكارد
            shadowColor: Colors.black,
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Stack(
              children: [
                // صورة العنصر الفعلي
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(details.image.isNotEmpty?details.image[0]:'details.image'), // تأكد من استخدام الرابط الفعلي
                      fit: BoxFit.cover,
                    ),
                  ),
                  height: 200, // تحديد ارتفاع الكارد إلى 200
                ),
                // سعر العنصر
                Positioned(
                  top: 210, // تغيير الموقع ليكون بعد الصورة
                  right: 15,
                  child: Card(
                    shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(2)),
                    color: Colors.white,
                    child: Text(details.price, style: const TextStyle(fontSize: 20)),
                  ),
                ),
                // حالة البيع
                Positioned(
                  top: 250, // تعديل الموقع ليكون بعد السعر
                  right: 15,
                  child: Text(
                    details.typePrice, // عرض حالة البيع
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black),
                  ),
                ),
                // المنطقة
                Positioned(
                  top: 280, // تعديل الموقع ليكون بعد حالة البيع
                  right: 15,
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.grey[400],
                        size: 30,
                      ),
                      const SizedBox(
                        width: 210,
                      ),
                      Text(
                        details.location, // عرض المنطقة
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
