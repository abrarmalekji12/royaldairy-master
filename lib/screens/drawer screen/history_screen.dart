import 'package:flutter/material.dart';


class HistoryScreen extends StatelessWidget {

static const historyScreenRoute='/history_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text('history')),
      body:Center(child: Text('history'),),
    );
  }
}