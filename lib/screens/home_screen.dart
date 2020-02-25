import 'package:flutter/material.dart';
import 'package:flutter_app/login.dart';
import '../screens/carousel_screen.dart';
import '../widgets/search.dart';
import '../widgets/categoriey.dart';

class HomeScreen extends StatelessWidget {
  CarouselScreen screen;
  HomeScreen(){
    screen=CarouselScreen((current.isLogged())?current.getAllProduct():[]);
  }
static const homeRoute='/homeRoute';
@override
  Widget build(BuildContext context) {
    return   Container(
        height: 1000,
        child: Stack(children: <Widget>[
          // Container(
          //     decoration: new BoxDecoration(
          //         image: DecorationImage(
          //             image: new AssetImage('assets/images/back.jpeg'),
          //             fit: BoxFit.fill,
          //             colorFilter: ColorFilter.mode(Colors.black12,BlendMode.lighten),
          //             ),
          //             color:Color.fromRGBO(150, 150, 150, 0.8),
          //           // colorBlendMode: BlendMode.modulate,
          //             )),
           Column(
            children: <Widget>[
              SearchBox(),
               SizedBox(height:10,),
             screen,
              SizedBox(height:20,),
            Expanded(child:Categories()),
            ],
          )
        ]));
       
          
       
       
        
        
  }
}
