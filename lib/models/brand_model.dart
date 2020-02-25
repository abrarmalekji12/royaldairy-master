import '../models/amul_details.dart';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class BrandModal with ChangeNotifier {
  final String brandId;
  final String brandName;
  final String brandPhoto;
  final List<ProductModal> items;
  BrandModal({
    @required this.brandId, 
    @required this.brandName, 
    @required this.brandPhoto,
    @required this.items});
}
