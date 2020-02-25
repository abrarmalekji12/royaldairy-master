import 'package:flutter/material.dart';
import 'package:flutter_app/models/brand_model.dart';
import 'package:provider/provider.dart';
import '../../models/amul_details.dart';
import '../../providers/brand.dart';
import './fav_data.dart';
class FavoriteScreen extends StatefulWidget {
static const routeFav='/favorite';

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}
  
class _FavoriteScreenState extends State<FavoriteScreen> {
int currentPage = 0;
 
    List<BrandModal> favItems;
  @override
  Widget build(BuildContext context) {
      
    
        
          
   
    return Scaffold(
      body:Container(
          color: Color.fromRGBO(191, 255, 254, 0.1),
          child: PageView.builder(
          onPageChanged: (value) {
            setState(() {
              currentPage = value;
            });
          },
          itemCount:Provider.of<Brands>(context).ShowFavScreen.length,
          itemBuilder: (context, index) => DisplayItems(index),
        )));
  }

  Widget DisplayItems(int index) {
    double blur = currentPage == index ? 10 : 0;
    double offset = currentPage == index ? 5 : 0;
    double top = currentPage == index ? 50 : 90;
    Color color1=Color.fromRGBO(119, 144, 255, 0.8);
  final List<ProductModal> p1= Provider.of<Brands>(context).ShowFavScreen;
    return AnimatedContainer(
          
        duration: Duration(milliseconds: 1000),
        curve: Curves.easeOutQuint,
        margin: EdgeInsets.only(top: top, bottom: 55, right: 20, left: 10),
        decoration: BoxDecoration(
          
          // border:Border.all(color: Colors.red,width:2),
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: Colors.purple),
          color:currentPage == index && index%2==0
              ? Colors.indigoAccent
              : Colors.orange,
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(0, 114, 219, 1),
                blurRadius: blur,
                offset: Offset(offset, offset))
          ]
        ),
        child: Content(index,p1),
        
        );
  }
}


