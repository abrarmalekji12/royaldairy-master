import 'package:flutter/material.dart';

class SettinsScreen extends StatelessWidget {

  static const settingScreenRoute='/setting_screen_route'; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text('setting')),
      body:Center(child: Text('setting'),),
    );
  }
}