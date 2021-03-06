import 'package:flutter/material.dart';
import '../screens/brands_screen.dart';
import '../screens/type_of_milk.dart';
class Categories extends StatelessWidget {
//  Widget createCat(String image, String title,double bottom,double left,Function click) {
//    return Expanded(
//        child: InkWell(
//            onTap:click,
//            child: Container(
//                child: Column(children: <Widget>[
//      Stack(children: <Widget>[
//        Container(
//          decoration: BoxDecoration(
//            image: DecorationImage(
//              image: AssetImage(image),
//              fit: BoxFit.fill,
//              colorFilter: ColorFilter.mode(Colors.black45.withOpacity(0.5), BlendMode.darken)
//            ),
//            boxShadow: [
//              BoxShadow(
//                color: Colors.black,
//                blurRadius: 5.0,
//                offset: Offset(4, 4)
//              )
//            ],
//            borderRadius: BorderRadius.circular(10),
//          ),
//          // child:Container(child: ClipRRect(
//          //     borderRadius: BorderRadius.circular(20),
//          //     child: Image(
//          //       image: AssetImage(image),
//          //       fit: BoxFit.fill,
//
//          //     ))),
//          height: 150,
//
//          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
//        ),
//        Positioned(
//            bottom: bottom,
//            left: left,
//            child: Container(
//                width: 220,
//                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 50),
//                child: Text(
//                  title,
//                  style: TextStyle(
//                    fontFamily: 'OpenSans',
//                    fontSize: 26,
//                    color: Colors.white,
//                  ),
//                  softWrap: true,
//                  overflow: TextOverflow.fade,
//                ))),
//      ])
//    ]))));
//  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: <Widget>[

       InkWell(
         onTap:()=>Navigator.of(context).pushNamed(BrandScreen.bransScreen) ,
         child: Container(
             height:100,
             width:MediaQuery.of(context).size.width,

                  child: Padding(
                    padding: const EdgeInsets.only(left:30,right:30),
                    child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 10,
                              offset: Offset(2,2)
                            ),

                          ],
                          border: Border.all(color:Colors.black),
                          borderRadius: BorderRadius.circular(15)
                        ),

                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset('assets/images/brand.png',fit: BoxFit.cover,))),
                  ),
         ),
       ),
   SizedBox(height:20),
   InkWell(
     onTap:()=> Navigator.of(context).pushNamed(TypeOfMilkScreen.milkTypeScreen),
     child: Container(

             height:100,
             width:MediaQuery.of(context).size.width,

                  child: Padding(
                    padding: const EdgeInsets.only(left:30,right:30),
                    child: Container(
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 10,
                                  offset: Offset(2,2)
                              ),

                            ],
                            border: Border.all(color:Colors.black),
                            borderRadius: BorderRadius.circular(20)
                        ),

                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset('assets/images/types.png',fit: BoxFit.fill,))),
                  ),
         ),
   ),
////        Container(
//            height:200,
//            width:100,
//            child:Image.asset('assets/images/brand.png')),
//        Image.asset('assets/images/brand.png'),
       // createCat('assets/images/brand.jpg', 'Brands',70,10,(){
           // Navigator.of(context).pushNamed(BrandScreen.bransScreen);
        //}),
        //createCat('assets/images/typeof.png', 'types of milk',60,3,(){
         // Navigator.of(context).pushNamed(TypeOfMilkScreen.milkTypeScreen);
        //}),

      ],
    ));
  }
}
