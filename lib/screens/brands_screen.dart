import 'package:flutter/material.dart';
import 'package:flutter_app/database/Model.dart';
import 'package:flutter_app/login.dart';
import 'package:shimmer/shimmer.dart';
import '../screens/brnad screens/products_screen.dart';
import '../models/chhose.dart';

import 'package:provider/provider.dart';
import '../providers/brand.dart';
Map<Brand,List<Product>> filter=current.getFilterByBrandName();
 Map<int,String> img={};
class BrandScreen extends StatefulWidget {
  static const bransScreen = '/brand_Route';

  @override
  _BrandScreenState createState() => _BrandScreenState();
}

class _BrandScreenState extends State<BrandScreen> {
  List<Brand> brands;
  Color color1 = Colors.white;
  Color color2 = Colors.white;
  Color color3 = Colors.white;
  Widget createBrand(String title, String image,Brand brand) {
    return InkWell(
        onTap: () {
          MaterialPageRoute route=new MaterialPageRoute(builder: (con){
            return productScreen(new ChooseData(animal:title, type: "Brand",products: filter[brand]));
          });
          Navigator.push(context, route);
        },
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.5),
                    blurRadius: 5,
                  )
                ],
                // color:Colors.red,
                image: DecorationImage(
                    image:image==null? AssetImage(
                      "assets/images/logo.png",
                    ):NetworkImage(image),
                    fit: BoxFit.fill,
                    colorFilter: ColorFilter.mode(
                        Colors.white.withOpacity(0.2), BlendMode.darken)),
              ),
            ),
          ],
        ));
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    current.loadBrands().then(
        (data){
         filter= current.getFilterByBrandName();
         brands=filter.keys.toList();
         img={};
         for(Brand brand in brands )
         {
           current.getDownloadUrl(brand.imageURL).then(
                   (val){
                 print("hey brand ${brand.brandName} $val");
                 img[brand.brandId]=val;
                 if(mounted)
                   setState(() {

                   });
               }
           );
         }
         setState(() {

         });
        }
    );
    filter=null;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Brands')),
      body:brands==null?Shimmer.fromColors(child:new Container(
        width: dw(100),
        height: dh(100),
        color: Colors.grey,
      ), baseColor: Colors.grey, highlightColor:Colors.white): Container(
          margin: EdgeInsets.only(top: 40),
          child: brands.isEmpty? Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10),
              ),
              Image.asset(
                'assets/images/product_not_found.jpg',
                width: MediaQuery.of(context).size.width,
                height: 150,
              ),
              Padding(
                padding: EdgeInsets.all(10),
              ),
              Container(
                child: Text(
                  "no shops available near you",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
            ],
          ):GridView.builder(
              itemCount: brands.length,
              itemBuilder: (ctx, i) => createBrand(
                    brands[i].brandName,
                 img.containsKey(brands[i].brandId)? img[brands[i].brandId]:null,brands[i]
                  ),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 1.3,
                crossAxisSpacing: 20,
                mainAxisSpacing: 30,
              ))),
    );
  }
}
