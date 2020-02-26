import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_sign_in/widgets.dart';
import 'package:flutter_app/real_bottom_bar.dart';
import 'package:flutter_app/register.dart';
import 'package:flutter_app/resetpass.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'database/Model.dart';

double height, width;
Model current = new Model();
bool pref = true;
String messge = "";
bool isWorking = false;
bool eye = true;
bool isLoading=false;
TextEditingController _user = new TextEditingController(),
    _pass = new TextEditingController();

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _form=GlobalKey<FormState>();

  login(){
    _form.currentState.save();
    if(_form.currentState.validate())
    {
      current.logIn(_user.text, _pass.text).then((i) {
        setState(() {
          isLoading=true;
        });
        print("hey $i");
        if (!i) {
          messge = "Invalid username or password";
          setState(() {});
          return;
        }
        SharedPreferences.getInstance().then((preff) {
          preff.setString("email", _user.text);
          preff.setString("password", _pass.text);
          print("success");
        });
        Navigator.pushReplacementNamed(
            context, BottomBar.bottomBarRoute);
      }).catchError((error) {
        messge = "problem occured with connection";
      });
    }
  }
  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    if (!current.isLogged() && pref) {
      SharedPreferences.getInstance().then((SharedPreferences pre) {
        if (pre.containsKey("email")) {
          current.logIn(pre.get("email"), pre.get("password")).then((log) {
            pref = false;
            if (log) {
//                current.loadUser();\
              Navigator.pushReplacementNamed(context, BottomBar.bottomBarRoute);
            }
          });
        } else {
          pref = false;
          setState(() {});
        }
      });
      isWorking = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (width == null &&
        MediaQuery.of(context).orientation == Orientation.portrait) {
      width = MediaQuery.of(context).size.width;
      height = MediaQuery.of(context).size.height;
    }
    //
    return !pref
        ? new Scaffold(
      body: Form(
        key: _form,
        child: ListView(
          children: <Widget>[
            SizedBox(height:45),
            Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 30.0),
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 200,
                  width: 200,
                )),
            new Container(
              width: 350,
              padding: EdgeInsets.only(left:20,right:20),
              alignment: Alignment.center,

              child: new TextFormField(
                controller: _user,
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                textAlign: TextAlign.start,
                validator: (val) {
                  if (val.isEmpty) {
                    return 'email is require';
                  }else  if (!val.contains('@gmail.com')) {
                    return 'invalid email';
                  }
                },

                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                ),

                showCursor: true,
                textAlignVertical: TextAlignVertical.center,
                autofocus: false,
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                      BorderSide(color: Color.fromRGBO(27, 113, 127,1)),
                    ),
                    labelText: 'Email',
                    labelStyle: TextStyle(
                      fontFamily: 'OpenSans',
                      color: Color.fromRGBO(27, 113, 127,1),
                    ),
                    prefixIcon: Icon(
                      Icons.email,
                      size: 30,
                      color: Color.fromRGBO(27, 113, 127,1),
                    )),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left:20,right:20),
              child: TextFormField(
                controller: _pass,
                validator: (val) {
                  if (val.isEmpty) {
                    return 'password require';
                  } else if (val.length > 10 || val.length < 4) {
                    return 'password contain atleast 10 charecter';
                  }
                },
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                ),
                keyboardType: TextInputType.visiblePassword,
                autocorrect: false,
                textAlign: TextAlign.start,
                showCursor: true,
                textAlignVertical: TextAlignVertical.center,
                autofocus: false,
                obscureText: eye,
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color.fromRGBO(27, 113, 127,1)),
                    ),
                    labelText: 'Password',
                    labelStyle: TextStyle(
                      fontFamily: 'OpenSans',
                      color: Color.fromRGBO(27, 113, 127,1),
                    ),
                    prefixIcon: Icon(
                      Icons.security,
                      size: 30,
                      color: Color.fromRGBO(27, 113, 127,1),
                    )),
              ),
            ),
            SizedBox(height:10),
            new Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              new Checkbox(
                value: !eye,
                onChanged: (res) {
                  eye = !eye;
                  setState(() {});
                },
                activeColor: Color.fromRGBO(27, 113, 127,1),),
              Padding(
                padding: const EdgeInsets.only(right:10),
                child: new Text(
                  "show password",
                  style: TextStyle(
                    fontSize: 15,
                    color: Color.fromRGBO(27, 113, 127,1),
                  ),
                ),
              )
            ]),
            SizedBox(height:10),
            new Container(
              padding: EdgeInsets.all(20),
              child: new FlatButton(
                onPressed:login,


                child: new Text(
                  "Log in",
                  style: new TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontFamily: 'OpenSans'),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    side: BorderSide(
                        style: BorderStyle.solid,
                        color: Color.fromRGBO(27, 113, 127,1))),
                color: Color.fromRGBO(27, 113, 127,1),
                padding: EdgeInsets.all(10),
              ),
            ),
            InkWell(
                onTap: current.signInWithGoogle,
                child: Image.asset(
                  "assets/images/google.png",
                  width: 120,
                  height: 60,
                )),
            SizedBox(height:10),
            new InkWell(
              child: new Text(
                "forgot password",
                style: new TextStyle(
                  color: Color.fromRGBO(27, 113, 127,1),
                  fontSize: 15,
                  fontFamily: 'OpenSans',
                ),
                textAlign: TextAlign.center,
              ),
              onTap: () {
                Navigator.pushNamed(context, ResetSet.resetRoute);
              },
            ),

            new InkWell(
              child: new Text(
                "new user? register",
                style: new TextStyle(
                  color: Color.fromRGBO(27, 113, 127,1),
                  fontSize: 17,
                  fontFamily: 'OpenSans',
                ),
                textAlign: TextAlign.center,
              ),
              onTap: () {
                Navigator.pushNamed(context, Register.RegisterRoute);
              },
            ),
            Padding(
              padding: EdgeInsets.all(10),
            ),

          ],
        ),
      ),
    )
        : new Material(
      color: Colors.lightBlue,
      child: new Container(
        alignment: Alignment.center,
        width: dw(100),
        height: dh(100),
        child: Stack(
            alignment: Alignment.center,
            children:[
              Image.asset("assets/images/logo.png",
                  width: dw(50), height: dh(50)),
              Shimmer.fromColors(baseColor: Colors.transparent, highlightColor:Colors.white,
                direction: ShimmerDirection.ltr,
                enabled: true,
                child: Image.asset("assets/images/logo.png",
                    width: dw(50), height: dh(50)),
              ),

            ]
        ),
      ),
    );
  }
}

class MyBorder extends InputBorder {
  @override
  InputBorder copyWith({BorderSide borderSide}) {
    // TODO: implement copyWith
    return null;
  }

  @override
  // TODO: implement dimensions
  EdgeInsetsGeometry get dimensions => null;

  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) {
    // TODO: implement getInnerPath
    return null;
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    // TODO: implement getOuterPath
    return null;
  }

  @override
  // TODO: implement isOutline
  bool get isOutline => false;

  @override
  void paint(Canvas canvas, Rect rect,
      {double gapStart,
        double gapExtent = 0.0,
        double gapPercentage = 0.0,
        TextDirection textDirection}) {
    // TODO: implement paint
    Paint paint = new Paint();
    paint.color = Colors.lightBlueAccent.shade400;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 3.0;
    canvas.drawRRect(
        RRect.fromRectAndCorners(rect,
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10)),
        paint);
  }

  @override
  ShapeBorder scale(double t) {
    return null;
  }
}

double dw(double pt) => pt * width / 100;

double dh(double pt) => pt * height / 100;
