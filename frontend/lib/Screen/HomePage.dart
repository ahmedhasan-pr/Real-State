import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:frontend/Model/model.dart';
import 'package:frontend/Screen/DetailsPage.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:frontend/Api/api.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Future<List<Details>> futureDetails;

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    futureDetails = getAllDetails();

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
            onPressed: () {
              // ... إجراءات الإشعارات
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
              padding: EdgeInsets.only(left: 230, top: 20),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Text(
                  "اكتشف\n منزلك الجديد",
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
                        // محاكاة التحميل
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

 Widget _buildSkeletonizer() {
  return Skeletonizer(
    child: GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 1.2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemCount: 6, // عدد العناصر أثناء التحميل
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.grey.shade300,
          margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
          shadowColor: Colors.black,
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          child: Container(
            color: Colors.white,
            child: Stack(
              children: [
                // محاكاة الصورة
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade200,
                  ),
                  height: 200,
                ),
                Positioned(
                  top: 210,
                  right: 15,
                  child: Card(
                    shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(2)),
                    color: Colors.grey.shade200, // محاكاة السعر
                    child: Container(
                      width: 100,
                      height: 20,
                      color: Colors.grey.shade300, // محاكاة السعر
                    ),
                  ),
                ),
                Positioned(
                  top: 250,
                  right: 15,
                  child: Container(
                    width: 120,
                    height: 20,
                    color: Colors.grey.shade300, // محاكاة نوع السعر
                  ),
                ),
                Positioned(
                  top: 280,
                  right: 15,
                  child: Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.grey[400], size: 30),
                      const SizedBox(width: 10),
                      Container(
                        width: 120,
                        height: 20,
                        color: Colors.grey.shade300, // محاكاة الموقع
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

  Widget _buildContent(List<Details> data) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 1.2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 0,
      ),
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        final details = data[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailsPage(detail: details), // تمرير البيانات إلى صفحة التفاصيل
              ),
            );
          },
          child: Card(
            color: Colors.white,
            margin: const EdgeInsets.only(left: 30, right: 20, bottom: 10),
            shadowColor: Colors.black,
            elevation: 5,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(details.image.isNotEmpty
                          ? details.image[0]
                          : 'details.image'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  height: 200,
                ),
                Positioned(
                  top: 210,
                  right: 15,
                  child: Card(
                    shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(2)),
                    color: Colors.white,
                    child: Text(details.price, style: const TextStyle(fontSize: 20)),
                  ),
                ),
                Positioned(
                  top: 250,
                  right: 15,
                  child: Text(
                    details.typePrice,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black),
                  ),
                ),
                Positioned(
                  top: 280,
                  right: 15,
                  child: Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.grey[400], size: 30),
                      const SizedBox(width: 10),
                      Text(details.location,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
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
