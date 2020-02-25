import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class ModalType {
  final String typeId;
  final String typeName;
  final String typeUrl;

  ModalType({
    @required this.typeId,
    @required this.typeName,
    @required this.typeUrl,
  });
}

class ModalTypePro with ChangeNotifier {
  List<ModalType> _types = [
    ModalType(
        typeId: 'cow1',
        typeName: 'Cow',
        typeUrl: 'assets/images/types/cow_milk.jpeg'),
    ModalType(
        typeId: 'camel1',
        typeName: 'Camel',
        typeUrl: 'assets/images/types/camel_milk.jpeg'),
    ModalType(
        typeId: 'buffelo1',
        typeName: 'Buffalo',
        typeUrl: 'assets/images/types/buffelo_milk.jfif'),
    ModalType(
        typeId: 'goat1',
        typeName: 'Goat',
        typeUrl: 'assets/images/types/goat_milk.jpg'),
  ];

  List<ModalType> get types {
    return [..._types];
  }
}
