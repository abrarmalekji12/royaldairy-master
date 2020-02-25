import 'package:flutter/material.dart';
import '../providers/orders.dart';
import 'package:provider/provider.dart';
class OrderScreen extends StatelessWidget {
  
  static const orderScreenRoute='/orders_screen';

  @override
  Widget build(BuildContext context) {
    
      final orderData=Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(title:Text('orders')),
      body:ListView(children: <Widget>[
             ListTile(
            leading: Icon(Icons.subscriptions),
            title:Text('title'),
            subtitle: Text('Subtitle'),
          ),
          ListTile(
            title: Text('ITEMS'),
            subtitle: Text('SubItesm'),

          ),
          ListTile(
            title: Text('ORDER ON'),
            subtitle: Text('SubItesm'),
            
          ),
          ListTile(
            title: Text('Total Amount'),
            subtitle: Text('34'),
            
          )
      ],)
    );
  }
}