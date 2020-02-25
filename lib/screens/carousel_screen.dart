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
              decoration: BoxDecoration(
                // color: Color.fromRGBO(210, 255, 220, 1),
                color: Colors.greenAccent.withOpacity(0.1),
                // gradient: LinearGradient(
                //     begin: Alignment.bottomCenter,
                //     end: Alignment.topCenter,
                //     colors: [Colors.blue, Colors.white]),
                borderRadius: BorderRadius.all(Radius.circular(25)),
                border: Border.fromBorderSide(BorderSide(
                    color: Colors.black45, width: 1, style: BorderStyle.solid)),
              ),
              child: ListView(
                //  alignment: Alignment.topCenter,
                children: <Widget>[
                  imaged.containsKey(product.productId)
                      ? Padding(
                          padding:
                              EdgeInsets.only(left: 30, right: 30, top: 10),
                          child: Image.network(
                            imaged[product.productId],
                            fit: BoxFit.fill,
                            width: 250,
                            height: 130,
                          ),
                        )
                      : Shimmer.fromColors(
                          child: new Image.asset("assets/images/logo.png",
                              width: 270, height: 150),
                          baseColor: Colors.grey,
                          highlightColor: Colors.white),
                  SizedBox(height: 5),
                  Container(
                    padding: EdgeInsets.all(5),
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Stack(
                                alignment: Alignment.center,
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      product.productName,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontFamily: "JosefinSans",
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      "₹${product.price}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 17),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(3),
                            ),
                            Text(
                              "${product.description}",
                              style: TextStyle(
                                  fontFamily: "georgia", fontSize: 15),
                            ),
                            Padding(
                              padding: EdgeInsets.all(3),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.location_on,color: Colors.red,size:20,),
                                  Padding(padding: EdgeInsets.all(2)),
                                  Text(
                                    '${current.shopStore[j].name},${current.shopStore[j].location.address}',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontFamily: 'arial',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(3),
                            ),
                            Container(
                              padding: EdgeInsets.only(right: 3),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  'distance ${getDistanceFromLatLonInKm(current.shopStore[j].location, current.permUser.totalLocations[current.permUser.locationIndex])}',
                                  style: TextStyle(
                                    color: Colors.redAccent,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'arial',
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              color: Colors.transparent,
                              child: Stack(
                                alignment: Alignment.center,
                                children: <Widget>[
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Row(
                                        children: <Widget>[
                                          IconButton(
                                              icon: Icon(
                                                Icons.remove,
                                                size: 25,
                                                color: Colors.black,
                                              ),
                                              onPressed: () {
                                                if (current
                                                    .permUser.myCart.products
                                                    .contains(product)) {
                                                  if (current.permUser.myCart
                                                              .quantities[
                                                          current.permUser
                                                              .myCart.products
                                                              .indexOf(
                                                                  product)]-- ==
                                                      0) {
                                                    current.permUser.myCart
                                                        .quantities
                                                        .removeAt(current
                                                            .permUser
                                                            .myCart
                                                            .products
                                                            .indexOf(product));
                                                    current.permUser.myCart
                                                        .products
                                                        .remove(product);
                                                  }
                                                  current.setMyCart();
                                                  setState(() {});
                                                }
                                              }),
                                          Text(
                                            '${current.permUser.myCart.products.contains(product) ? current.permUser.myCart.quantities[current.permUser.myCart.products.indexOf(product)] : 0}',
                                            overflow: TextOverflow.fade,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                          IconButton(
                                            icon: Icon(
                                              Icons.add,
                                              size: 25,
                                              color: Colors.black,
                                            ),
                                            onPressed: () {
                                              if (current
                                                  .permUser.myCart.products
                                                  .contains(product))
                                                current.permUser.myCart
                                                        .quantities[
                                                    current.permUser.myCart
                                                        .products
                                                        .indexOf(product)]++;
                                              else {
                                                current.permUser.myCart.products
                                                    .add(product);
                                                current
                                                    .permUser.myCart.quantities
                                                    .add(1);
                                              }
                                              current.setMyCart();
                                              setState(() {});
                                            },
                                          )
                                        ],
                                      )),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: IconButton(
                                      tooltip: 'add Favorite',
                                      icon: Icon(
                                        isFavourite(product.productId)
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        size: 28,
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
            ));
        }
    if (productList == null) print("carosel list null");
    return productList == null
        ? Stack(
            children: <Widget>[
              Container(
                color: Colors.grey,
                width: dw(100),
                height: 310,
              ),
              Shimmer.fromColors(
                child: Container(
                  color: Colors.grey,
                  width: dw(100),
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
                    height: 310.0,
                    initialPage: 0,
                    enlargeCenterPage: true,
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
