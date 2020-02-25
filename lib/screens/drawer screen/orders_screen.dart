import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  
  static const orderScreenRoute='/orders_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text('orders')),
      body:Center(child: Text('orders'),),
    );
  }
}