
import 'package:flutter/material.dart';
import '../../models/amul_details.dart';
import '../../providers/cart_provider.dart';
import 'package:provider/provider.dart';

class Content extends StatelessWidget {
  final int index;
  final List<ProductModal> data;

  Content(this.index, this.data);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          //  width:300,
          height: 210,
          padding: EdgeInsets.all(30),
          decoration: BoxDecoration(
            // color: Colors.red,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50), topRight: Radius.circular(50)),
          ),

          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(data[index].photo))),
          ),
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                      topLeft: Radius.circular(70),
                      topRight: Radius.circular(70)),
                  border: Border.all(color: Colors.deepOrangeAccent, width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black45,
                      blurRadius: 70,
                    )
                  ],
                  color: Color.fromRGBO(240, 231, 198, 1),
                ),
                padding: EdgeInsets.all(20),
                height: MediaQuery.of(context).size.height / 2.2,
                child: SingleChildScrollView(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                          // width: MediaQuery.of(context).size.width / 1.7,
                          padding: EdgeInsets.only(top: 20),
                          child: Text(
                            data[index].name,
                            textAlign: TextAlign.center,
                            // textDirection: TextDirection.rtl,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 35,
                              fontFamily: 'JosefinSans',
                            ),
                          )),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 15, left: 10),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Description :',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ))),
                    SingleChildScrollView(
                        child: Padding(
                      padding: EdgeInsets.only(top: 10, left: 30, right: 30),
                      child: Text(
                        data[index].description,
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'OpenSans',
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    )),
                    Padding(
                        padding: EdgeInsets.only(top: 15, left: 10),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Composition :',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ))),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding:
                              EdgeInsets.only(top: 10, left: 30, right: 30),
                          child: Text(
                            data[index].composition,
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'OpenSans',
                            ),
                            // textAlign: TextAlign.justify,
                          ),
                        )),
                    Row(
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(top: 15, left: 10),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'price :',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ))),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding:
                                  EdgeInsets.only(top: 15, left: 20, right: 20),
                              child: Text(
                                '${data[index].price}\$ /1 ltr',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'OpenSans',
                                ),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 1, right: 1),
                              child: IconButton(
                                  tooltip: 'Add to cart',
                                  icon: Icon(
                                    Icons.shopping_cart,
                                    size: 40,
                                    color: Colors.deepOrange,
                                  ),
                                  onPressed: () {
                                    Provider.of<Cart>(context).addItmes(
                                        data[index].productId,
                                        data[index].price,
                                        data[index].name,
                                        data[index].photo.toString());
                                        Scaffold.of(context).hideCurrentSnackBar();
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      backgroundColor: Colors.black87,
                                      content: Text('item Added to cart'),
                                      duration: Duration(seconds: 2),
                                      action: SnackBarAction(label: 'UNDO', onPressed: (){
                                        Provider.of<Cart>(context).removeSingleItem(data[index].productId);
                                      },textColor: Colors.red,),

                                    ));
                                  }),
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ))))

        //     Padding(padding: ,child:Text('JosefinSans'))
      ],
    );
  }
}
