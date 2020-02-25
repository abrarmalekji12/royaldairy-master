import 'package:flutter/foundation.dart';
import 'package:flutter_app/database/Model.dart';

class ChooseData{
   String animal;
  String type;
  List<Product> products;
      ChooseData({@required this.animal,@required this.type,@required  this.products});
}