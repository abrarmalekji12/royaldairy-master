import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;
  final String imgUrl;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
    @required this.imgUrl,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get getItemCount {
    return _items == null ? 0 : _items.length;
  }

  void addItmes(
    String productId,
    double price,
    String title,
    String imageUrl,
  ) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (existItem) => CartItem(
              id: existItem.id,
              title: existItem.title,
              quantity: existItem.quantity + 1,
              price: existItem.price,
              imgUrl: existItem.imgUrl));
    } else {
      _items.putIfAbsent(
          productId,
          () => CartItem(
              id: DateTime.now().toString(),
              title: title,
              quantity: 1,
              price: price,
              imgUrl: imageUrl));
    }
    notifyListeners();
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId].quantity > 1) {
      _items.update(
          productId,
          (existData) => CartItem(
              id: existData.id,
              title: existData.title,
              quantity: existData.quantity - 1,
              price: existData.price,
              imgUrl: existData.imgUrl));
    }else{
      _items.remove(productId);

    }
    notifyListeners();
  }
  void clearCart()
  {
    _items={};
    notifyListeners();
  }
 
}
