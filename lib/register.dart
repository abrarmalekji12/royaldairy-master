import 'package:flutter/material.dart';
import 'package:flutter_app/real_bottom_bar.dart';
import 'login.dart';
import 'main.dart' as prefix0;
import 'main.dart';

double height, width;
bool eye = true;
TextEditingController _user = new TextEditingController(),
    _pass = new TextEditingController(),
    _confirm = new TextEditingController(),
    _mob = new TextEditingController(),
    _name = new TextEditingController();

class Register extends StatefulWidget {
  static String RegisterRoute = "/register";
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  static String registerRoute = "/registerRoute";
  final _form=GlobalKey<FormState>();
  signup(){
      _form.currentState.save();
        if(_form.currentState.validate())
          {
            if (_pass.text == _confirm.text )
                  current
                      .registerNewUser(
                          _user.text, _pass.text, _mob.text, _name.text)
                      .then((val) {
                    if (val) {
                      print('registered successfully');
                      Navigator.pushReplacementNamed(
                          context, BottomBar.bottomBarRoute);
                    } else
                      print("Error during registration");
                  });
          }
  }
  @override
  Widget build(BuildContext context) {
    if (width == null &&
        MediaQuery.of(context).orientation == Orientation.portrait) {
      width = MediaQuery.of(context).size.width;
      height = MediaQuery.of(context).size.height;
    }
    return new Scaffold(
      body: Form(
        key: _form,
              child: ListView(
          children: <Widget>[
            
            Padding(
                      padding: const EdgeInsets.only(top: 4.0, bottom: 10.0),
                      child: Image.asset(
                        'assets/images/logo.png',
                        height: 200,
                        width: 200,
                      )),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
              child: new TextFormField(
                controller: _user,
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                textAlign: TextAlign.start,
                validator: (val) {
                  if (!val.contains('@gmail.com')) {
                    return 'invalid email';
                  } else if (val.isEmpty) {
                    return 'email is require';
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
                   enabledBorder: UnderlineInputBorder(      
                      borderSide: BorderSide(color: Colors.indigoAccent),   
                      ),  
              focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.indigo),
                   ),  
                    labelText: 'Email',
                    labelStyle: TextStyle(
                      fontFamily: 'OpenSans',
                      color: Colors.indigoAccent
                    ),
                    prefixIcon: Icon(
                      Icons.email,
                      size: 30,
                      color: Colors.indigo,
                    )),
              ),
            ),
          
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
              child: new TextFormField(
                controller: _name,
                validator: (val) {
                  if (val.isEmpty) {
                    return 'name is require';
                  }
                },
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                ),
                keyboardType: TextInputType.phone,
                autocorrect: false,
                textAlign: TextAlign.start,
                showCursor: true,
                textAlignVertical: TextAlignVertical.center,
                autofocus: false,
                decoration: InputDecoration(
                   enabledBorder: UnderlineInputBorder(      
                      borderSide: BorderSide(color: Colors.indigoAccent),   
                      ),  
              focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.indigo),
                   ), 
                    labelText: 'Name',
                    labelStyle: TextStyle(
                      fontFamily: 'OpenSans',
                       color: Colors.indigoAccent
                    ),
                    prefixIcon: Icon(
                      Icons.person,
                      size: 30,
                      color: Colors.indigo,
                    )),
              ),
            ),
            
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
              child: new TextFormField(
                controller: _mob,
                validator: (val) {
                  if (val.isEmpty) {
                    return 'phone no is require';
                  } else if (val.length > 10 || val.length < 10)
                    return 'not valid phone no';
                },
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                ),
                keyboardType: TextInputType.phone,
                autocorrect: false,
                textAlign: TextAlign.start,
                showCursor: true,
                textAlignVertical: TextAlignVertical.center,
                autofocus: false,
                decoration: InputDecoration(
                   enabledBorder: UnderlineInputBorder(      
                      borderSide: BorderSide(color: Colors.indigoAccent),   
                      ),  
              focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.indigo),
                   ), 
                    labelText: 'Phone No',
                    labelStyle: TextStyle(
                      fontFamily: 'OpenSans',
                       color: Colors.indigoAccent
                       
                    ),
                    prefixIcon: Icon(
                      Icons.phone,
                      size: 30,
                      color: Colors.indigo,
                    )),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
              child: new TextFormField(
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
                   enabledBorder: UnderlineInputBorder(      
                      borderSide: BorderSide(color: Colors.indigoAccent),   
                      ),  
              focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.indigo),
                   ), 
                    labelText: 'Password',
                    labelStyle: TextStyle(
                      fontFamily: 'OpenSans',
                       color: Colors.indigoAccent
                    ),
                    prefixIcon: Icon(
                      Icons.security,
                      size: 30,
                      color: Colors.indigo,
                    )),
              ),
            ),
     
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical:2),
              child: new TextFormField(
                controller: _confirm,
                keyboardType: TextInputType.text,
                autocorrect: false,
                textAlign: TextAlign.start,
                showCursor: true,
                obscureText: eye,
                textAlignVertical: TextAlignVertical.center,
                autofocus: false,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                   enabledBorder: UnderlineInputBorder(      
                      borderSide: BorderSide(color: Colors.indigoAccent),   
                      ),  
              focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.indigo),
                   ), 
                    labelText: 'Conform Password',
                    labelStyle: TextStyle(
                      fontFamily: 'OpenSans',
                       color: Colors.indigoAccent
                    ),
                    prefixIcon: Icon(
                      Icons.security,
                      size: 30,
                      color: Colors.indigo,
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
                  activeColor: Colors.purple),
              Padding(
                    padding: EdgeInsets.only(right:15),
                                  child: new Text(
                  "show password",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.indigo,
                    ),
                ),
              )
            ]),
            new Container(
              padding: EdgeInsets.only(left:20,right:20,top:10),
              child: new FlatButton(
                onPressed: signup,
                child: new Text(
                  "Sign up",
                  style: new TextStyle(color: Colors.white, fontSize: 25),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    side: BorderSide(
                        style: BorderStyle.solid, color: Colors.indigo)),
                color: Colors.indigo,
                padding: EdgeInsets.all(10),
              ),
            ),
            new Padding(padding: EdgeInsets.all(10)),
            Center(
              child: new InkWell(
                child: new Text(
                  "already user, log-in",
                  style: new TextStyle(color: Colors.indigo, fontSize: 23),
                ),
                onTap: () {
                  Navigator.pushReplacementNamed(context, "/");
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
