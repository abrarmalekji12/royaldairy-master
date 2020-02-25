import 'package:flutter/material.dart';

class PaymentDetailsScreen extends StatelessWidget {
  
  static const paymentDetialsRoute='/payment_details_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text('Payment')),
      body:Center(child: Text('payment'),),
    );
  }
}