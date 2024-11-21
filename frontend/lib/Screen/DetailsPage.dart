import 'package:animated_read_more_text/animated_read_more_text.dart';
import 'package:flutter/material.dart';
import 'package:frontend/Api/api.dart';
import 'package:frontend/Provider/FavoriteProvider.dart';
import 'package:frontend/Model/model.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'dart:async';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key, });

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late Future<List<Details>> futureDetails;
  int _currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    futureDetails = getAllDetails();
  }

  void _startTimer(int length) {
    if (length > 0) {
      _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
        if (mounted) {
          setState(() {
            _currentIndex = (_currentIndex + 1) % length;
          });
        }
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _showImageViewer(List<String> images) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PhotoViewGallery(
          pageOptions: images.map((image) {
            return PhotoViewGalleryPageOptions(
              imageProvider: NetworkImage(image),
              minScale: PhotoViewComputedScale.contained,
              maxScale: PhotoViewComputedScale.covered * 2,
            );
          }).toList(),
          backgroundDecoration: const BoxDecoration(color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = FavoriteProvider.of(context);

    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        height: 85,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.call, size: 40, color: Colors.green),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.message, size: 40, color: Colors.blue),
              onPressed: () {},
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: FutureBuilder<List<Details>>(
        future: futureDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("حدث خطأ: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("لا توجد تفاصيل متاحة"));
          }

          final details = snapshot.data!;
          if (details.isNotEmpty) {
            _startTimer(details[0].image.length);
          }

          return ListView.builder(
            itemCount: details.length,
            itemBuilder: (context, index) {
              final detail = details[index];

              // تحديث حالة isFavorite بناءً على قائمة المفضلة
              bool isFavorite = provider.isExist(detail);

              return Column(
                children: [
                  Stack(
                    children: [
                      GestureDetector(
                        onTap: () => _showImageViewer(detail.image),
                        child: Container(
                          height: 350,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                            ),
                            image: DecorationImage(
                              image: detail.image.isNotEmpty
                                  ? NetworkImage(detail.image[_currentIndex])
                                  : const AssetImage('assets/blackimage.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 50,
                        right: 10,
                        left: 10,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 35),
                            ),
                            IconButton(
                              onPressed: () {
                                // Toggle the favorite status in the provider
                                provider.toggleFavorite(detail);

                                // Show the appropriate Snackbar message
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(isFavorite ? 'تمت إزالة من المفضلة' : 'أضيفت إلى المفضلة'),
                                  ),
                                );

                                // Update the state to reflect the change
                                setState(() {
                                  isFavorite = !isFavorite;
                                });
                              },
                              icon: Icon(
                                isFavorite ? Icons.favorite : Icons.favorite_border,
                                color: isFavorite ? Colors.red : Colors.grey,
                                size: 35,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 45),
                        child: Text(
                          detail.typePrice,
                          style: const TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        "\$${detail.price}",
                        style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 0, left: 215),
                    child: Row(
                      children: [
                        const Icon(Icons.location_on_outlined, size: 30),
                        Text(
                          detail.location,
                          style: TextStyle(fontSize: 20, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text("حمام", style: TextStyle(fontSize: 20, color: Colors.grey.shade800)),
                          Text("${detail.bathroom}", style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
                        ],
                      ),
                      Column(
                        children: [
                          Text("غرفة", style: TextStyle(fontSize: 20, color: Colors.grey.shade800)),
                          Text("${detail.room}", style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
                        ],
                      ),
                      Column(
                        children: [
                          Text("المساحة", style: TextStyle(fontSize: 20, color: Colors.grey.shade800)),
                          Text("${detail.square.toStringAsFixed(0)} m²", style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
                        ],
                      ),
                      Column(
                        children: [
                          Text("المرآب", style: TextStyle(fontSize: 20, color: Colors.grey.shade800)),
                          Text(detail.garage ? "متاح" : "غير متاح", style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
                        ],
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 240, top: 10),
                    child: Text("وصف المنزل", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: SizedBox(
                      height: 150,
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: SingleChildScrollView(
                          child: AnimatedReadMoreText(
                            detail.description,
                            maxLines: 5,
                            readMoreText: 'عرض المزيد',
                            readLessText: 'عرض أقل',
                            textStyle: const TextStyle(fontSize: 20, color: Colors.black),
                            buttonTextStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
