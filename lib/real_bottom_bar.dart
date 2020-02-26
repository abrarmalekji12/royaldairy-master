import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/src/scheduler/ticker.dart';
import 'package:flutter_app/login.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/models/chhose.dart';
import 'package:flutter_app/screens/brnad%20screens/products_screen.dart';
import 'package:flutter_app/screens/carousel_screen.dart';
import 'package:flutter_app/screens/drawer%20screen/edit_user_profile.dart';
import 'package:flutter_app/screens/home_screen.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import './widgets/orders_screen.dart';
import './screens/drawer screen/payment_screen.dart';
import './screens/drawer screen/profile_screen.dart';
import './screens/drawer screen/settings_screen.dart';
import './screens/drawer screen/wallet_screen.dart';
import './screens/drawer screen/history_screen.dart';

import './screens/drawer screen/favorite_screen.dart';
import './screens/subscription_screen.dart';
import 'package:flutter/material.dart';
import './screens/cart_screen.dart';
import './widgets/badge.dart';
import 'package:provider/provider.dart';
import './providers/cart_provider.dart';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'database/Model.dart';
Color unselected=Colors.grey,selected=Colors.indigoAccent;

var drawerSelected = -1;
BuildContext scaffcontext;

class BottomBar extends StatefulWidget {
  static String bottomBarRoute = "/bottomroute";
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> implements TickerProvider {
  Widget createItems(
      IconData icon, String title, String subtitle, Function click) {
    return Container(
      padding: EdgeInsets.all(5),
      child: ListTile(
        onTap: click,
        leading: Icon(
          icon,
          size: 26,
          color: Colors.black54,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'NotoSansKR',
            fontWeight: FontWeight.w700,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.w500,
          ),
        ),
        contentPadding: EdgeInsets.all(2),
      ),
    );
  }

  Container getItem(int i, Widget widget, IconData icon, String title,
      String subtitle, String route) {
    return Container(
      padding: EdgeInsets.only(left: 10),
      color: drawerSelected == i ? Colors.white : Colors.transparent,
      child: createItems(icon, title, subtitle, () {
        drawerSelected = i;
        Navigator.of(context).pushNamed(route);
        //pages[0]['page'] = widget;
        selectPage(0);
        setState(() {});
        //'orders' 'keep track of current orders'
        // Navigator.pop(context);
      }),
    );
  }

  List<Map<String, Object>> pages = [
    {
      'page': HomeScreen(),
      'title': 'Royal Dairy',
    },
    {
      'page': productScreen(ChooseData(
          animal: "",
          type: "fav",
          products: current.permUser.favouriteProduct)),
      'title': 'Favorite',
    },
    {
      'page': Subscription(),
      'title': 'Subscription',
    },
  ];

  int selectpageIndex = 0;

  void selectPage(int index) {
    setState(() {
      selectpageIndex = index;
    });
  }

  Widget selectScreen() {
    if (selectpageIndex == 1)
      return productScreen(ChooseData(
          animal: "",
          type: "fav",
          products: current.permUser.favouriteProduct));
    return pages[selectpageIndex]['page'];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
        child: Scaffold(
            drawer: Drawer(
                child: Container(
                    padding: EdgeInsets.only(top: 60, left: 0),
                    child: ListView(
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            if (!current.isLogged()) {
                              Navigator.pushNamed(context, "/");
                              return;
                            }
                            drawerSelected = 0;
                            Navigator.of(context)
                                .pushNamed(ProfileScreen.profileScreenRoute);
                            //pages[0]['page'] = new ProfileScreen();
                            selectPage(0);
                          },
                          child: new Container(
                            margin: EdgeInsets.only(top: 5, bottom: 10),
                            padding: EdgeInsets.all(10),
                            child: Center(
                              child: Row(
                                children: <Widget>[
                                  CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 25,
                                      child: new Icon(
                                        Icons.person,

                                        color: Color.fromRGBO(27, 113, 127, 1),
                                        size: 35,
                                      )),
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                  ),
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        width: dw(48),
                                        child: new Text(
                                          current.isLogged()
                                              ? "hey ${current.permUser.name}"
                                              : "hey user",
                                          softWrap: true,
                                          maxLines: 1,
                                          overflow: TextOverflow.fade,
                                          style: new TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontFamily: "georgia",
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.black,
                                    size: 30,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.grey,
                          thickness: 2,
                        ),
                        getItem(
                            1,
                            new HistoryScreen(),
                            Icons.history,
                            'history',
                            'previous orders and payments',
                            HistoryScreen.historyScreenRoute),
                        getItem(
                            2,
                            new OrderScreen(),
                            Icons.record_voice_over,
                            'orders',
                            'keep track of current orders',
                            OrderScreen.orderScreenRoute),
                        getItem(
                            3,
                            new PaymentDetailsScreen(),
                            Icons.payment,
                            'payment details',
                            'link your account for quick transaction',
                            PaymentDetailsScreen.paymentDetialsRoute),
                        getItem(
                          4,
                          new WalletScreen(),
                          Icons.account_balance_wallet,
                          'wallet',
                          'manage your personalized wallet',
                          WalletScreen.walletScreenRoute,
                        ),
                        new Divider(
                          color: Colors.grey,
                          thickness: 2.0,
                        ),
                        getItem(
                            5,
                            new SettinsScreen(),
                            Icons.settings,
                            'settings',
                            'change setting',
                            SettinsScreen.settingScreenRoute),
                        createItems(
                            Icons.input,
                            (current.isLogged()) ? "Log-out" : "Log in",
                            "use another account of yours", () {
                          if (current.isLogged()) {
                            current.logOut();
                            setState(() {});
                          } else {
                            Navigator.pushNamed(context, '/');
                          }
                        })
                      ],
                    ))),
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              backgroundColor: Color.fromRGBO(73,167,204,1),
              centerTitle: false,
              actions: <Widget>[
                   Badge(
                  child: IconButton(
                      tooltip: 'add to cart',
                      icon: Icon(
                        Icons.shopping_cart,
                        size: 30,
                        color: Colors.white,

                      ),
                      onPressed: () {
                        if(current.isLogged())
                        Navigator.of(context).pushNamed(CartScreen.cartRoute);
                        else
                          Navigator.of(context).pushNamed("/");
                      }), 
                  value: (current.isLogged())?current.permUser.myCart.products.length.toString():"!",
                ),
              ],
              title: new InkWell(
                onTap: () {
                  showModalBottomSheet(
                      context: scaffcontext,
                      builder: (co) {
                        return Container(
                          width: dw(100),
                          height: dh(50),
                          child: ListView(
                            children: <Widget>[
                              Container(
                                width: 200,
                                height: 70,
                                padding: EdgeInsets.all(10),
                                child: PlacesAutocompleteField(
                                  apiKey:
                                  google_api_ky,
                                  controller: editAdd,
                                  onChanged: (val) {
                                   Location.fromAddress(val);
                                   Navigator.pop(context);
                                  },
                                  mode: Mode.fullscreen,
                                  inputDecoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(5),
                                    enabled: addressField,
                                    helperText: errorAddress.isNotEmpty &&
                                        radioIndex == 0
                                        ? errorAddress
                                        : null,
                                    helperStyle: TextStyle(
                                        color: Colors.red, fontSize: 15),
                                  ),
                                ),
                              ),
                              new Padding(padding: EdgeInsets.all(5)),
                              Container(
                                width: dw(100),
                                height: dh(41),
                                child: ListView(
                                  children: current.permUser.totalLocations
                                      .map((value) {
                                    print("heyyyy ${value.locationId}");
                                    return InkWell(
                                      onTap: () {
                                          current.permUser.locationIndex=value.locationId-1;
                                          current.setUserLocationIndex(value.locationId-1);
                                          Navigator.pop(context);
                                          Navigator.pushReplacementNamed(context, BottomBar.bottomBarRoute);
                                          },
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        width: dw(70),
                                        child: new Text(
                                          value.address,
                                          style: new TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontFamily: "georgia"),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                      backgroundColor: Colors.white);
                },
                child: Row(
                  children: <Widget>[
                    Icon(

                      Icons.location_on,
                      color: Color.fromRGBO(27, 113, 127, 1),
                      size: 30,
                    ),
                    SizedBox(width:5),
                     Expanded(
                                            child: Text(
                            (current.isLogged())
                                ? "${current.permUser.totalLocations[current.permUser.locationIndex].address}"
                                : "location",
                            style: TextStyle(
                              fontFamily: 'JosefinSans',
                              fontSize: 21,
                            ),overflow: TextOverflow.fade,
                            ),
                     ),
                  ],
                ),
              ),
              //   backgroundColor: Colors.lightGreen
            ),
            body: Builder(builder: (con) {
              scaffcontext = con;
              return selectScreen();
            }),
            bottomNavigationBar: 
           BottomNavigationBar(
             backgroundColor: Color.fromRGBO(73,167,204,1),
                onTap: selectPage,
               currentIndex: selectpageIndex,
               unselectedFontSize: 10,
             selectedItemColor: Colors.black,
               unselectedItemColor: Colors.white,
               items: [
               BottomNavigationBarItem(
                   icon: Icon(Icons.home), title: Text('home')),
               BottomNavigationBarItem(
                   icon: Icon(Icons.favorite,), title: Text('favourite')),
               BottomNavigationBarItem(
                 icon: Icon(Icons.subscriptions,),
                 title: Text('subscription'),
               )]
            )));
  }

  @override
  Ticker createTicker(onTick) {
    // TODO: implement createTicker
    Ticker ticker = new Ticker((dura) {});
    return ticker;
  }
}