import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:frontend/Model/model.dart';
import 'package:frontend/Screen/DetailsPage.dart';
import 'package:frontend/Screen/NotificationsPage.dart';
import 'package:search_page/search_page.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:frontend/Api/api.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late Future<List<Details>> futureDetails;
  final List<String> sections = [
    'Residential',
    'Commercial',
    'Industrial',
    'Land',
    'Retail'
  ];

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    futureDetails = getAllDetails();

    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              // إجراءات الإشعارات
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationsPage(),
                ),
              );
            },
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
              padding: EdgeInsets.only(right: 20, top: 20),
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
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, // لون الخلفية
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // انحناء الحواف
                    side: BorderSide(
                        color: Colors.grey.shade200, width: 3), // لون الحدود
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                ),
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: SearchPage<String>(
                      items: sections, // قائمة العناصر للبحث
                      searchLabel:
                          '...ابحث عن العقار', // النص العربي داخل شريط البحث
                      suggestion: const Center(
                          child: Text('تصفية العقار')), // اقتراح أولي
                      failure: const Center(
                          child: Text('لم يتم العثور على العقار')), // فشل البحث
                      filter: (section) => [section], // منطق التصفية
                      builder: (section) =>
                          ListTile(title: Text(section)), // بناء النتائج
                    ),
                  );
                },
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'أماكن البحث',
                        style: TextStyle(
                          color: Colors.black, // لون النص
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(Icons.search,
                          color: Colors.yellow.shade900,
                          size: 35), // أيقونة البحث
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MaterialButton(
                      onPressed: () {},
                      color: Colors.yellow.shade900,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: const Text(
                        "منزل",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {},
                      color: Colors.yellow.shade900,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: const Text(
                        "شقق",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {},
                      color: Colors.yellow.shade900,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: const Text(
                        "قطع اراضي",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "عقار مميز",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.yellow.shade900,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12), // شكل الزر
                        ),
                      ),
                      child: const Text(
                        "اظهار الكل ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
          SliverFillRemaining(
            hasScrollBody: false,
            child: SizedBox(
              height: 10, // تحديد الحجم الثابت
              child: _isLoading ? _buildSkeletonizer() : _buildTabContent(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent() {
    return FutureBuilder<List<Details>>(
      future: futureDetails,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildSkeletonizer(); // أثناء التحميل
        } else if (snapshot.hasError) {
          return const Center(child: Text('حدث خطأ في تحميل البيانات'));
        } else if (snapshot.hasData) {
          return _buildContent(snapshot.data!); // عرض المحتوى بعد التحميل
        } else {
          return const Center(child: Text('لا توجد بيانات'));
        }
      },
    );
  }

  // الهيكل العضمي للعناصر
  Widget _buildSkeletonizer() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Skeletonizer(
        child: ListView.builder(
          scrollDirection: Axis.horizontal, // الاتجاه الأفقي
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 6, // عدد العناصر أثناء التحميل
          itemBuilder: (BuildContext context, int index) {
            return Card(
              clipBehavior: Clip.hardEdge, // الحفاظ على الحدود
              color: Colors.grey.shade400,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shadowColor: Colors.black,
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Stack(
                children: [
                  // محاكاة الصورة
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade200,
                      ),
                      height: 180, // نفس ارتفاع الصورة الحقيقية
                      width: 350, // نفس عرض الصورة الحقيقية
                    ),
                  ),
                  // محاكاة السعر
                  Positioned(
                    top: 210,
                    right: 15,
                    child: Container(
                      width: 120,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  // محاكاة نوع السعر
                  Positioned(
                    top: 250,
                    right: 15,
                    child: Container(
                      width: 50,
                      height: 20,
                      color: Colors.grey.shade300,
                    ),
                  ),
                  // محاكاة الموقع
                  Positioned(
                    top: 280,
                    right: 15,
                    child: Row(
                      children: [
                        Container(
                          width: 90,
                          height: 20,
                          color: Colors.grey.shade300,
                        ),
                        const SizedBox(width: 10),
                        Icon(Icons.location_on,
                            color: Colors.grey.shade400, size: 30),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // عرض العناصر
  Widget _buildContent(List<Details> data) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ListView.builder(
        shrinkWrap: true, // تقليص الحجم بناءً على المحتوى
        scrollDirection: Axis.horizontal, // تمرير أفقي
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          final details = data[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsPage(
                    detail: details,
                  ),
                ),
              );
            },
            child: Card(
              clipBehavior: Clip.hardEdge, // الحفاظ على الحدود
              color: Colors.white,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shadowColor: Colors.black,
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Stack(
                children: [
                  // الصورة
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(
                            details.image.isNotEmpty ? details.image[0] : '',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      height: 180, // تحديد ارتفاع الصورة
                      width: 350, // عرض العنصر
                    ),
                  ),
                  Positioned(
                    top: 190,
                    right: 15,
                    child: Card(
                      shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(2)),
                      color: Colors.white,
                      child: Text(details.price,
                          style: const TextStyle(fontSize: 20)),
                    ),
                  ),
                  Positioned(
                    top: 235,
                    right: 15,
                    child: Text(
                      details.typePrice,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 23,
                          color: Colors.yellow.shade900),
                    ),
                  ),
                  Positioned(
                    top: 265,
                    right: 15,
                    child: Row(
                      children: [
                        Text(details.location,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20)),
                        const SizedBox(width: 10),
                        Icon(Icons.location_on,
                            color: Colors.red[400], size: 30),
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
}
