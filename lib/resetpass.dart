
  import 'package:flutter/material.dart';
import 'login.dart';
import 'main.dart';
TextEditingController _user = new TextEditingController();
bool resetClick=false;
class ResetSet extends StatefulWidget {
  static String resetRoute="/reset";
  @override
  _ResetSetState createState() => _ResetSetState();
}

class _ResetSetState extends State<ResetSet> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Container(
            alignment: Alignment.center,
            width: dw(100),
            height: dh(100),
            child: new Center( child: new Stack(
              alignment: Alignment.center,
              children: <Widget>[
                new Container(
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.center,
                  child: new Column(
                    crossAxisAlignment:CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      (!resetClick)? new Container(
                          width: 350,
                          height: 70,
                          alignment: Alignment.center,
                          color: Colors.white,
                          child: new TextField(
                            controller: _user,
                            keyboardType: TextInputType.text,
                            autocorrect: false,
                            textAlign: TextAlign.start,
                            cursorRadius: Radius.circular(8),
                            showCursor: true,
                            textAlignVertical: TextAlignVertical.center,
                            autofocus: false,
                            style: new TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontFamily: "georgia"),
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(20),
                                border: new MyBorder(),
                                prefixIcon: Icon(
                                  Icons.person,
                                  size: 40,
                                  color: Colors.green.shade500,
                                ),
                                hintText: "enter gmail",
                                hintStyle: new TextStyle(
                                    color: Colors.grey,
                                    fontSize: 22,
                                    fontFamily: "georgia")),
                          )):new Container(),
                      new Padding(padding: EdgeInsets.all(15)),
                      new Column(
                        children:[new FlatButton(
                          onPressed: () {
                            if(!resetClick) {
                              resetClick = true;
                              setState(() {

                              });
                              current.resetPassword(_user.text);
                            }
                            else {
                              Navigator.pushReplacementNamed(context, '/');
                            resetClick=false;
                            }
                              },
                          child: new Text(
                            resetClick?"Log in":"Reset password",
                            style: new TextStyle(color: Colors.white, fontSize: 25),
                          ),
                          shape:RoundedRectangleBorder(
                              borderRadius:BorderRadius.all(Radius.circular(10)),
                              side:BorderSide(style:BorderStyle.solid,color:Colors.lightBlueAccent.shade400)
                          ),
                          color: Colors.lightBlueAccent.shade400,
                          padding:EdgeInsets.all(10),
                        ),
                        new Padding(padding: EdgeInsets.all(20)),
                        resetClick?new Text(
                          "check your Mail box on this email and reset password then login",style:new TextStyle(color:Colors.black,fontFamily: "georgia",fontSize: 20),textAlign: TextAlign.center,
                          ):new Container()
                        ]
                      ),
                      new Padding(padding: EdgeInsets.all(5)),
                    ],
                  ),
                )
              ],
            ),
            )));
  }
}