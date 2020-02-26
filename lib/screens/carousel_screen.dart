import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/database/Model.dart';
import 'package:flutter_app/login.dart';
import 'package:shimmer/shimmer.dart';
import './subscription_screen.dart';
import 'brnad screens/products_screen.dart';
import '../database/Model.dart';
import 'package:provider/provider.dart';
import '../widgets/badge.dart';

Future<List<Product>> future;

class CarouselScreen extends StatefulWidget {
  List<Product> productList = [];
  Map<int, String> imaged = {};

  CarouselScreen(Future<List<Product>> list) {
    productList = null;
    imaged = {};
    future = list;
  }

  CarouselScreen.direct(List<Product> temp) {
    future = new Future(() {
      return temp;
    });
  }

  @override
  _CarouselScreenState createState() =>
      _CarouselScreenState(this.productList, this.imaged);
}

class _CarouselScreenState extends State<CarouselScreen> {
  int _current = 0;
  List<Product> productList;
  Map<int, String> imaged = {};
  List<Container> mainList = [];

  _CarouselScreenState(this.productList, this.imaged);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("heeyy in init");
    productList = null;
    future.then((val) {
      productList = val;
      imaged = {};
      for (Product product in productList) {
        current.getDownloadUrl(product.imageURL).then((value) {
          imaged[product.productId] = value;
          if (mounted) setState(() {});
        });
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    mainList = [];
    if (productList != null)
      for (Product product in productList)
        for (int j in product.shopIds) {
          if (current.shopStore.containsKey(j))
            mainList.add(Container(
              width: MediaQuery.of(context).size.width / 1.3,
              height: 300,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey, blurRadius: 10, offset: Offset(8, 8))
                ],
                color: Colors.white,
                // color: Color.fromRGBO(210, 255, 220, 1),
//                color: Colors.greenAccent.withOpacity(0.1),
                // gradient: LinearGradient(
                //     begin: Alignment.bottomCenter,
                //     end: Alignment.topCenter,
                //     colors: [Colors.blue, Colors.white]),
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.all(Radius.circular(15)),
//                border: Border.fromBorderSide(BorderSide(
//                    color: Colors.black45, width: 1, style: BorderStyle.solid)),
              ),
              child: Stack(
                children: <Widget>[
                  Column(
                    //  alignment: Alignment.topCenter,
                    children: <Widget>[
                      imaged.containsKey(product.productId)
                          ? Padding(
                              padding:
                                  EdgeInsets.only(left: 35, right: 35, top: 13),
                              child: Image.network(
                                imaged[product.productId],
                                fit: BoxFit.fill,
                                width: 200,
                                height: 130,
                              ),
                            )
                          : Shimmer.fromColors(
                              child: new Image.asset("assets/images/logo.png",
                                  width: 270, height: 150),
                              baseColor: Colors.grey,
                              highlightColor: Colors.white),
//                  SizedBox(height: 5),
                      Container(
//                    padding: EdgeInsets.all(5),
                        child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    product.productName,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 23,
                                      fontFamily: "JosefinSans",
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10, top: 4),
                                  child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: Text(
                                        "₹${product.price}",
                                        style: TextStyle(
                                            fontFamily: 'JosefinSans',
                                            color: Colors.black,
                                            fontSize: 17),
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5, right: 4,top: 4),
                                  child: Text(
                                    "${product.description}.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: "OpenSans", fontSize: 15),
                                  ),
                                ),

                                Padding(
                                  padding: EdgeInsets.all(4),
                                ),
                                Container(
                                  padding: EdgeInsets.only(right: 4),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      'distance ${getDistanceFromLatLonInKm(current.shopStore[j].location, current.permUser.totalLocations[current.permUser.locationIndex])}',
                                      style: TextStyle(
                                        color: Color.fromRGBO(6, 58, 28, 0.9),
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Montserrat',
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  color: Colors.transparent,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    //  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Container(
                                        height: 30,
                                        margin: EdgeInsets.only(left: 10),
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.indigo),
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              width: 25,
                                              decoration: BoxDecoration(
                                                  color: Color.fromRGBO(
                                                      27, 113, 127, 1),
                                                  borderRadius: BorderRadius.only(
                                                      topLeft: Radius.circular(20),
                                                      bottomLeft:
                                                          Radius.circular(20))),
                                              child: Center(
                                                child: InkWell(
                                                    child: Center(
                                                      child: Text(
                                                        '-',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20,
                                                        ),
                                                      ),
                                                    ),
                                                    onTap: () {
                                                        if(decreament(product))
                                                        current.setMyCart();
                                                        setState(() {});
                                                    }),
                                              ),
                                            ),
                                            SizedBox(width: 5),
                                            Center(
                                              child: Text(
                                                '${isProductInCart(product)[0]}',
                                                overflow: TextOverflow.fade,
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontFamily: 'JosefinSans'),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Container(
                                              width: 25,
                                              decoration: BoxDecoration(
                                                  //color: Colors.indigo,
                                                  color: Color.fromRGBO(
                                                      27, 113, 127, 1),
                                                  borderRadius: BorderRadius.only(
                                                      topRight: Radius.circular(20),
                                                      bottomRight:
                                                          Radius.circular(20))),
                                              child: Center(
                                                child: InkWell(
                                                  child: Center(
                                                    child: Text('+',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20,
                                                        )),
                                                  ),
                                                  onTap: () {
                                                    increament(product,current.shopStore[j]);
                                                    current.setMyCart();
                                                    setState(() {});
                                                  },
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: IconButton(
                                          tooltip: 'add Favorite',
                                          icon: Icon(
                                            isFavourite(product.productId)
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            size: 30,
                                            color: Colors.red,
                                          ),
                                          onPressed: () {
                                            if (!isFavourite(product.productId))
                                              addToFavourite(product);
                                            else
                                              removeFromFavourite(product);
                                            setState(() {});
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )),
                      )
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.location_on,color:Colors.redAccent),
                        Text(
                          '${current.shopStore[j].name},${current.shopStore[j].location.address}',
                          style: TextStyle(
                            color: Colors.black,
                            backgroundColor: Colors.white,
                            fontSize: 16,
                            fontFamily: 'OpenSans',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ));
        }
    if (productList == null) print("carosel list null");
    return productList == null
        ? Stack(
            children: <Widget>[
              Container(
                color: Colors.grey,
                width: dw(80),
                height: 310,
              ),
              Shimmer.fromColors(
                child: Container(
                  color: Colors.grey,
                  width: dw(80),
                  height: 310,
                ),
                baseColor: Colors.transparent,
                highlightColor: Colors.white,
              )
            ],
          )
        : Container(
            child: productList.length == 0
                ? Column(
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
                  )
                : CarouselSlider(
                    height: 300.0,
                    initialPage: 0,
//                    enlargeCenterPage: true,
                    autoPlay: true,
                    //  reverse: true,
                    autoPlayInterval: Duration(seconds: 5),
                    autoPlayAnimationDuration: Duration(milliseconds: 4000),
                    pauseAutoPlayOnTouch: Duration(seconds: 6),
                    onPageChanged: (index) {
                      setState(() {
                        _current = index;
                      });
                    },
                    items: mainList,
                  ));
  }

  bool isFavourite(int id) {
    for (Product temp in current.permUser.favouriteProduct) {
      print("fav ${temp.productName}");
      if (temp.productId == id) return true;
    }
    return false;
  }
}
void increament(Product product,LocalShop shop){
  if(current.permUser.myCart.shop==null||shop.name!=current.permUser.myCart.shop.name) {
    current.permUser.myCart.products=[product];
    current.permUser.myCart.quantities=[1];
    current.permUser.myCart.shop=shop;
    return;
  }
    var temp = isProductInCart(product);
    if (temp[0] > 0)
      current.permUser.myCart.quantities[temp[1]]++;
    else {
      current.permUser.myCart.products.add(product);
      current.permUser.myCart.quantities.add(1);
    }
}
bool decreament(Product product){
  var temp=isProductInCart(product);
  if(temp[0]==0)
    return false;
  if(current.permUser.myCart.quantities[temp[1]]--==0) {
    current.permUser.myCart.products.removeAt(temp[1]);
    current.permUser.myCart.quantities.removeAt(temp[1]);
}
  return true;
}
List<int> isProductInCart(Product product){
  var ans=[0,-1];
for(int i=0;i<current.permUser.myCart.products.length;i++)
    if(current.permUser.myCart.products[i].productId==product.productId) {
      ans[0] = current.permUser.myCart.quantities[i];
      ans[1]=i;
    }
  return ans;  
}
