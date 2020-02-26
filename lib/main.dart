import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/login.dart';
import 'package:flutter_app/register.dart';
import 'package:flutter_app/resetpass.dart';
import 'package:flutter_app/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'database/Model.dart';
import 'models/amul_details.dart';
import 'real_bottom_bar.dart';
import './screens/subscription_screen.dart';
import 'package:geolocator/geolocator.dart';
import './screens/drawer screen/edit_user_profile.dart';
import './screens/drawer screen/favorite_screen.dart';
import './providers/type_modal.dart';
import './real_bottom_bar.dart';
import './screens/drawer screen/history_screen.dart';
import './widgets/orders_screen.dart';
import './screens/drawer screen/profile_screen.dart';
import './screens/drawer screen/settings_screen.dart';
import './screens/drawer screen/wallet_screen.dart';
import './screens/drawer screen/payment_screen.dart';
import './screens/type_of_milk.dart';
import './screens/brands_screen.dart';
import './screens/cart_screen.dart';
import './providers/user.dart';
import './providers/cart_provider.dart';
import './screens/brnad screens/products_screen.dart';
import './providers/brand.dart';
import './providers/orders.dart';
import './providers/auth.dart';
import './database/Model.dart';
void main() => runApp(Dairy());
String google_api_ky="AIzaSyBH57M3ugU6cC7JaP2ClwreU8eNrgT-oDA";
class Dairy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: Model()
          ),
          ChangeNotifierProvider.value(
            value: UserData(),
          ),
          ChangeNotifierProvider.value(
            value: ProductModal(),
          ),
          ChangeNotifierProvider.value(
            value: Brands(),
          ),
          ChangeNotifierProvider.value(value: Cart()),
          ChangeNotifierProvider.value(value: ModalTypePro()),
          ChangeNotifierProvider.value(value: Orders()),
          //  ChangeNotifierProvider.value(value: Auth()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primaryColor: Colors.white,
              accentColor: Colors.transparent,
              pageTransitionsTheme: PageTransitionsTheme(builders: {
                TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
              })),

          routes: {
            '/': (ctx) => MyApp(), //MyApp()
            BottomBar.bottomBarRoute: (cl) => BottomBar(),
            Register.RegisterRoute: (ab) => Register(),
            ResetSet.resetRoute: (cl) => ResetSet(),
            HomeScreen.homeRoute: (ctx) => HomeScreen(),
            CartScreen.cartRoute: (ctx) => CartScreen(),
            Subscription.routeSub: (ctx) => Subscription(),
            FavoriteScreen.routeFav: (ctx) => FavoriteScreen(),
            HistoryScreen.historyScreenRoute: (ctx) => HistoryScreen(),
            OrderScreen.orderScreenRoute: (ctx) => OrderScreen(),
            PaymentDetailsScreen.paymentDetialsRoute: (ctx) =>
                PaymentDetailsScreen(),
            ProfileScreen.profileScreenRoute: (ctx) => ProfileScreen(),
            SettinsScreen.settingScreenRoute: (ctx) => SettinsScreen(),
            WalletScreen.walletScreenRoute: (ctx) => WalletScreen(),
            BrandScreen.bransScreen: (ctx) => BrandScreen(),
            TypeOfMilkScreen.milkTypeScreen: (ctx) => TypeOfMilkScreen(),
            UserEditProfile.editRoute: (ctx) => UserEditProfile(),
//        AmulProductScreen.amulProductRoute:(ctx)=>AmulProductScreen(),
          },

          // bottomNavigationBar:BottomBar(),
        ));
  }
}

class ForTest extends StatefulWidget {
  @override
  _ForTestState createState() => _ForTestState();
}

class _ForTestState extends State<ForTest> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Model md = new Model();
//    md.getTest().then((val){
//      print("actual data $val");
//    });
//    md.setTest({
//      "reviewIds": [0],
//      "scc": 1000000,
//      "isPacked": true,
//      "price": 55,
//      "shopIds": [1, 1],
//      "imageURL": "products/amul_taza.png",
//      "fat": 95,
//      "animal": "Cow",
//      "description": "Taaza and Fresh milk,Amul cool",
//      "productName": "Amul  Taza"
//    });
//    Geolocator geolocator=Geolocator();
//    geolocator.getCurrentPosition(locationPermissionLevel: GeolocationPermission.location,desiredAccuracy: LocationAccuracy.high).then((pos){
//      print("location ${pos.latitude}  ${pos.longitude} ${pos.toJson()}");
//    });
    //    print(" maths ${atan2(2, 10)}  ${2/(sqrt(4+100))}");
    //23.464067,73.288854
  }

  void printUser(User user) {
    print('loaded User ${user.favouriteProduct[0].productName}');
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

void setToastShort(String string) {
  MethodChannel("flutter://channel").invokeMethod("setToastShort", string);
}

void setToastLong(String string) {
  MethodChannel("flutter://channel").invokeMethod("setToastLong", string);
}