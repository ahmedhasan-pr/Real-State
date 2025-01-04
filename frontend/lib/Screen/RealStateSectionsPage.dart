// ignore_for_file: file_names

import 'dart:ui' as ui; // تعيين بادئة لمكتبة dart:ui

import 'package:flutter/material.dart';
import 'package:search_page/search_page.dart';
import 'package:skeletonizer/skeletonizer.dart';

class RealStateSectionsPage extends StatefulWidget {
  const RealStateSectionsPage({super.key, required String section});

  @override
  State<RealStateSectionsPage> createState() => _RealStateSectionsPageState();
}

class _RealStateSectionsPageState extends State<RealStateSectionsPage> {
  final List<String> sections = [
    'Residential',
    'Commercial',
    'Industrial',
    'Land',
    'Retail'
  ];
  bool isLoading = true;
  @override
  void initState() {
    super.initState();

    ///محاكاة تحميل البيانات لمدة 3 ثانية
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        isLoading = false;

        ///تغير الحالة الى تحميل المكتمل
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const ui.Size.fromHeight(70.0), // تعيين ارتفاع AppBar
        child: Directionality(
          textDirection: TextDirection.rtl, // تعيين اتجاه النص من اليمين لليسار
          child: AppBar(
            title: const Text('البحث'), // العنوان باللغة العربية
            actions: [
              IconButton(
                icon: const Icon(Icons.search), // أيقونة البحث
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: SearchPage<String>(
                      items: sections,
                      searchLabel: '...ابحث عن العقار', // النص بالعربية
                      suggestion: const Center(child: Text('تصفية العقار')),
                      failure:
                          const Center(child: Text('لم يتم العثور على العقار')),
                      filter: (section) => [section],
                      builder: (section) => ListTile(title: Text(section)),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: isLoading ? _buildSkeletonizer() : _buildContent(),
    );
  }

//// الهيكل العضمي للعناصر
  // ignore: unused_element
  Widget _buildSkeletonizer() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Skeletonizer(
        child: ListView.builder(
            itemCount: 4,
            itemBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: 200, // ارتفاع العنصر
                width: double.infinity, // عرض العنصر
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ), // المسافة الخارجية
                  child: Card(
                    clipBehavior: Clip.antiAlias,

                    color: Colors.grey.shade300, // لون المستطيل
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        /// مستطيل يمثل مكان الصورة
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              height: 180, // ارتفاع المستطيل
                              width: 150, // عرض المستطيل
                              color: Colors.grey.shade300,
                            ),
                          ),
                        ),

                        ///مسافة بين العناصر
                        /// مستطيلات تمثل النصوص الموقتة
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /// مستطيل يمثل النص الاول
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    width: 100, // العرض الكامل
                                    height: 20, // ارتفاع المستطيل
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),

                                /// مستطيل يمثل النص الثاني
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    width: 30, // العرض الكامل
                                    height: 20, // ارتفاع المستطيل
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),

                                /// مستطيل يمثل النص الثالث
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 20,
                                        color: Colors.grey.shade400,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 50,
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Container(
                                        width: 20, // العرض ايقونة
                                        height: 20, // ارتفاع ايقونة
                                        color: Colors.grey.shade400,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }

  /// محتويات العناصر
  Widget _buildContent() {
    return ListView.builder(
      itemCount:
          4, // عدد العناصر في القائمة (يمكنك تغييره حسب البيانات المتاحة)
      itemBuilder: (BuildContext context, int index) {
        return SizedBox(
          height: 200, // ارتفاع العنصر
          width: double.infinity, // العرض الكامل
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 10, vertical: 5), // الحواف الخارجية
            child: Card(
              elevation: 5,
              shadowColor: Colors.black,
              clipBehavior: Clip.antiAlias,
              color: Colors.grey.shade50, // لون خلفية البطاقة
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // النصوص
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              '1,200,000 IQD', // سعر العقار
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'للبيع', // حالة البيع أو الإيجار
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.location_on_sharp, color: Colors.red),
                              SizedBox(width: 5),
                              Expanded(
                                child: Text(
                                  'كركوك - حي الجامعة', // المنطقة
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black87,
                                  ),
                                  textAlign: TextAlign.right,
                                  overflow: TextOverflow
                                      .ellipsis, // لتجنب النص الزائد
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  // الصورة
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        'assets/house1.jpg', // الصورة
                        height: 180,
                        width: 150,
                        fit: BoxFit.cover, // تغطية الصورة
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
