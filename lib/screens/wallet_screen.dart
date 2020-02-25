import 'package:flutter/material.dart';

class WalletScreen extends StatelessWidget {
  
  static const walletScreenRoute='wallet_Screen_Route';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text('wallet')),
      body:Center(child: Text('wallet'),),
    );
  }
}