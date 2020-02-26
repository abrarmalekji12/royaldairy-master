import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/database/Model.dart';
import 'package:flutter_app/login.dart';
import 'package:flutter_app/screens/drawer%20screen/payment_screen.dart';
import 'package:shimmer/shimmer.dart';

import '../providers/cart_provider.dart' show Cart;

class CartScreen extends StatefulWidget {
  static const cartRoute = '/cart_Route';
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Map<int, String> images = {};
  List<Product> cart = current.permUser.myCart.products;
  double _totalMoney = -1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i = 0; i < cart.length; i++)
      current
          .getDownloadUrl(current.permUser.myCart.products[i].imageURL)
          .then((val) {
        images[cart[i].productId] = val;
        print("ok loaded");
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    calculteTotal();
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(title: Text('Cart')),
          body: Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                  Container(
          child: Stack(
                    children: <Widget>[
          Container(
            color: Colors.white,
            padding:
                EdgeInsets.symmetric(horizontal: 70, vertical: 100),
          ),
          Container(
              padding: EdgeInsets.only(top: 30, left: 10),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                    alignment: Alignment.topLeft,
                    icon: Icon(
                      Icons.add_shopping_cart,
                      size: 50,
                      color: Color.fromRGBO(73,167,204,1),
                    ),
                    onPressed: () {},
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 10),
                    child: Text((current.isLogged()&&current.permUser.myCart.shop!=null)?'${current.permUser.myCart.shop.name}':"Shopping Cart",
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        )),
                  )
                ],
              )),
          SizedBox(height: 12),
          Container(
              padding: EdgeInsets.only(top: 110, bottom: 4),
              decoration: BoxDecoration(
                  // border: Border.all(color: Colors.red),
                  ),
              height:dh(80),
              child: ListView.builder(
                  itemCount: cart.length,
                  itemBuilder: (ctx, id) {
                    final double price =
                        current.permUser.myCart.products[id].price;
                    final String title = current
                        .permUser.myCart.products[id].productName;
                    return Container(
                      padding: EdgeInsets.all(3),
                      child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Material(
                            borderRadius: BorderRadius.circular(10.0),
                            elevation: 15,
                            child: Dismissible(
                              key: ValueKey(id),
                              background: Container(
                                decoration: BoxDecoration(
                                  color: Colors.deepOrange,
                                  borderRadius:
                                      BorderRadius.circular(10),
                                ),
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                  size: 40,
                                ),
                                alignment: Alignment.centerRight,
                                padding: EdgeInsets.only(right: 20),
                                // margin: EdgeInsets.symmetric(horizontal: 15,vertical: 4),
                              ),
                              direction: DismissDirection.horizontal,
                              onDismissed: (direction) {
                                removeFromCart(id);
                                setState(() {

                                });
                              },
                              child: Container(
                                  padding: EdgeInsets.only(
                                      left: 15.0, right: 10.0),
                                  width: MediaQuery.of(context)
                                          .size
                                          .width -
                                      20.0,
                                  height: 150.0,
                                  decoration: BoxDecoration(
                                    color: Colors.white54,
                                    borderRadius:
                                        BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        height: 125.0,
                                        width: 100.0,
                                        child: images.containsKey(
                                                cart[id].productId)
                                            ? Image.network(images[
                                                cart[id].productId])
                                            : Shimmer.fromColors(
                                                child: Image.asset(
                                                    "assets/images/logo.png"),
                                                baseColor:
                                                    Colors.grey,
                                                highlightColor:
                                                    Colors.white),
                                      ),
                                      SizedBox(width: 10.0),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Container(
                                                width: 120,
                                                child: Text('$title',
                                                    overflow:
                                                        TextOverflow
                                                            .fade,
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'JosefinSans',
                                                      fontSize: 20,
                                                    )),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 5.0),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: <Widget>[
                                              Text(
                                                '\₹ $price',
                                                style: TextStyle(
                                                  fontSize: 15.0,
                                                  fontFamily:
                                                      'Montserrat',
                                                  color: Colors.black,
                                                ),
                                              ),
                                              SizedBox(width: 80),
                                              Container(
                                                height: 25,
                                                decoration:
                                                    BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors
                                                          .indigo),
                                                  borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                              20),
                                                ),
                                                child: Row(
                                                  children: <Widget>[
                                                    Container(
                                                      width: 25,
                                                      decoration: BoxDecoration(
                                                          color: Color.fromRGBO(27, 113, 127, 1),
                                                          borderRadius: BorderRadius.only(
                                                              topLeft:
                                                                  Radius.circular(
                                                                      20),
                                                              bottomLeft:
                                                                  Radius.circular(20))),
                                                      child: Center(
                                                        child: InkWell(
                                                            child: Center(
                                                              child:
                                                                  Text(
                                                                '-',
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight.bold,
                                                                  fontSize:
                                                                      20,
                                                                ),
                                                              ),
                                                            ),
                                                            onTap: () {
                                                              current
                                                                  .permUser
                                                                  .myCart
                                                                  .quantities[id]--;
                                                              if (current.permUser.myCart.quantities[id] ==
                                                                  0)
                                                                removeFromCart(
                                                                    id);
                                                              current
                                                                  .setMyCart();
                                                              setState(
                                                                  () {});
                                                            }),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      '${current.permUser.myCart.quantities[id]}',
                                                      overflow:
                                                          TextOverflow
                                                              .fade,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight
                                                                  .bold,
                                                          fontSize:
                                                              15,
                                                          fontFamily:
                                                              'JosefinSans'),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Container(
                                                      width: 25,
                                                      decoration: BoxDecoration(
                                                          color: Color.fromRGBO(27, 113, 127, 1),
                                                          borderRadius: BorderRadius.only(
                                                              topRight:
                                                                  Radius.circular(
                                                                      20),
                                                              bottomRight:
                                                                  Radius.circular(20))),
                                                      child: Center(
                                                        child:
                                                            InkWell(
                                                          child:
                                                              Center(
                                                            child:
                                                                Text(
                                                              '+',
                                                              style:
                                                                  TextStyle(
                                                                fontWeight:
                                                                    FontWeight.bold,
                                                                fontSize:
                                                                    20,
                                                              ),
                                                            ),
                                                          ),
                                                          onTap: () {
                                                            current
                                                                .permUser
                                                                .myCart
                                                                .quantities[id]++;
                                                            current
                                                                .setMyCart();
                                                            setState(
                                                                () {});
                                                          },
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          !current.isCartProductAvailable(
                                                  cart[id])
                                              ? Text(
                                                  "product is not available at this location")
                                              : Container()
                                        ],
                                      )
                                    ],
                                  )),
                            ),
                          )),
                    );
                  })),
                  SizedBox(height:60),
          Padding(
            padding: EdgeInsets.only(
              top: dh(74),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  height: 60.0,
                  width: double.infinity,
                  color: Colors.white,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 20, left: 10),
                        child: Text(
                          'Total: ₹ $_totalMoney',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: 'JosefinSans'),
                        ),
                      ),
                      SizedBox(width: 100.0),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color.fromRGBO(27, 113,127, 1),

                          ),
                          child: InkWell(
                            onTap: () {
                              current.permUser.myCart.products=[];
                              current.permUser.myCart.quantities=[];
                              cart=[];
                              current.setMyCart();
                              setState(() {

                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left:15,right:15,top:5,bottom:5),
                              child: Center(
                                child: Text(
                                  'Remove',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontFamily: 'OpenSans',
                                  ),
                                ),
                              ),
                            ),

                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          padding: EdgeInsets.all(3)
                          ,child: FlatButton(onPressed: () {
                          Navigator.pushNamed(context,PaymentDetailsScreen.paymentDetialsRoute);
                        },
                            color:Color.fromRGBO(27, 113, 127, 1),
                            child:Text(
                            'Order now',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'OpenSans',
                            ),
                          ), ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                            padding: EdgeInsets.all(3)
                          ,child: FlatButton(onPressed: () {
                          Navigator.pushNamed(context,PaymentDetailsScreen.paymentDetialsRoute);
                        },
                          color:Color.fromRGBO(27, 113, 127, 1),
                          child:Text(
                            'Take subscribtion',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'OpenSans',
                            ),
                          ), ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )

                    ],
                  )),
                ]))),
    );
  }

  void calculteTotal() {
    _totalMoney = 0;
    for (int i = 0; i < cart.length; i++)
      if (current.isCartProductAvailable(cart[i]))
        _totalMoney += (current.permUser.myCart.quantities[i] * cart[i].price);
  }
}

void removeFromCart(int id) {
  current.permUser.myCart.products.removeAt(id);
  current.permUser.myCart.quantities.removeAt(id);
  current.setMyCart();
}
