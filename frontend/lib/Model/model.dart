class House {
  final List<String> image;
  final String price;
  final String typePrice;
  final String location;
  final double square;
  final int bathroom;
  final int room;
  final bool garage;
  final String description;
  bool favorite; // إضافة حقل المفضلة

  House({
    required this.image,
    required this.price,
    required this.typePrice,
    required this.location,
    required this.square,
    required this.bathroom,
    required this.room,
    required this.garage,
    required this.description,
    required this.favorite, // إضافة هذا الحقل في الكونستركتور
  });

  factory House.fromJson(Map<String, dynamic> json) {
    return House(
      image: (json['image'] is List)
          ? List<String>.from(json['image'])
          : (json['image'] is String)
              ? [json['image']]
              : [],
      price: json['price'].toString(),
      typePrice: json['typePrice'] ?? '',
      location: json['location'] ?? '',
      square: (json['square'] is num)
          ? (json['square'] as num).toDouble()
          : double.tryParse(json['square'].toString()) ?? 0.0,
      bathroom: (json['bathroom'] is int)
          ? json['bathroom']
          : (json['bathroom'] as num).toInt(),
      room:
          (json['room'] is int) ? json['room'] : (json['room'] as num).toInt(),
      garage: json['garage'] ?? false,
      description: json['description'] ?? '',
      favorite: json['favorite'] ?? false, // إضافة حقل المفضلة هنا
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'price': price,
      'typePrice': typePrice,
      'location': location,
      'square': square,
      'bathroom': bathroom,
      'room': room,
      'garage': garage,
      'description': description,
      'favorite': favorite, // إضافة حقل المفضلة هنا
    };
  }
}

/// الاشعارات

class Notifications {
  final String message;
  final DateTime createdAt;

  Notifications({
    required this.message,
    required this.createdAt,
  });
  factory Notifications.fromJson(Map<String, dynamic> json) {
    return Notifications(
      message: json['message'],  // الرسالة 
       createdAt: DateTime.parse(json['created_at']),  // التاريخ
    );
  }
}
