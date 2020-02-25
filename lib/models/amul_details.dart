import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class ProductModal with ChangeNotifier {
  final String productId;
  final String name;
  final String photo;
  final double price;
  final String typeId;
  final String description;
  final String composition;
   bool isFavorite;
  ProductModal({
    @required this.productId,
    @required this.name,
    @required this.photo,
    @required this.price,
    @required this.typeId,
    @required this.description,
    @required this.composition,
     this.isFavorite=true,
  });
   void toggleFavoriteProduct()
      {
            isFavorite=!isFavorite;
            notifyListeners();
      }
      void changeFavoriteStatus(String id)
        {
          isFavorite=!isFavorite;
          notifyListeners();
        }
}
