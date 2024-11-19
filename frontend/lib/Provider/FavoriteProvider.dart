import 'package:flutter/material.dart';
import 'package:frontend/Model/model.dart';
import 'package:provider/provider.dart';

class FavoriteProvider with ChangeNotifier {
  List<Details> _favorite = [];

  ///  الحصول على قائمة المفضلة
  List<Details> get favorite => _favorite;

  // أضف العنصر إلى المفضلة
  void toggleFavorite(Details details) {
    if (_favorite.contains(details)) {
      _favorite.remove(details);
    } else {
      _favorite.add(details);
    }
    notifyListeners();
  }

  bool isExist(Details details) {
    final isExit = _favorite.contains(details);
    return isExit;
  }

  static FavoriteProvider of(BuildContext context, {bool litsen = true}) {
    return Provider.of<FavoriteProvider>(context, listen: litsen);
  }
}
