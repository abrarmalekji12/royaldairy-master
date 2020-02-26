import 'package:flutter/material.dart';
import 'package:flutter_app/database/Model.dart';
import 'package:flutter_app/login.dart';
import 'package:flutter_app/screens/carousel_screen.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../widgets/badge.dart';
import '../../providers/brand.dart';
import '../../models/brand_model.dart';
import '../../providers/cart_provider.dart';
import '../../screens/cart_screen.dart';
import '../../screens/brands_screen.dart';
import '../../models/chhose.dart';

int currentPage = 0;
List<Product> loadedproduct=null;
ChooseData productId;
Map<int, String> imageurls = {};
bool recommand = false;
BuildContext scaffContext;
bool favourite = false;

class productScreen extends StatefulWidget {
  static const amulProductRoute = '/amulProductScreen';

  productScreen(ChooseData data) {
    productId = data;
loadedproduct = data.products;
  }
  @override
  _productScreenState createState() => _productScreenState();
}

class _productScreenState extends State<productScreen>
    with SingleTickerProviderStateMixin {
  List<Widget> mainList=[];

  @override
    void initState() {
    // TODO: implement initState
    super.initState();
      loadedproduct = productId.products;
      imageurls = {};
      currentPage = 0;
      recommand = loadedproduct.isEmpty;
      if (recommand) {
        loadedproduct = current.productStore.values.toList();
        productId.type = "rec";
      }
      for (int i = 0; i < loadedproduct.length; i++)
        current.getDownloadUrl(loadedproduct[i].imageURL).then((val) {
          imageurls[loadedproduct[i].productId] = val;
          setState(() {});
        });
      if (productId.type!="fav"&&loadedproduct.length > 0)
        favourite = isFavourite(loadedproduct[0].productId);
      setState(() {});
    print("Favourite $favourite");
  }
  @override
  Widget build(BuildContext context) {
mainList=[];
for(Product product  in loadedproduct)
  for(int shopId in product.shopIds)
    if(current.shopStore.containsKey(shopId))
      mainList.add(DisplayItems(product,current.shopStore[shopId]));
    // int a = findLength();
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: productId.type == "fav" || recommand
            ? null
            : AppBar(
              title: Text(productId.animal),

          actions: <Widget>[
                  Consumer<Cart>(
                    builder: (_, cart, ch) =>
                        Badge(child: ch, value: cart.getItemCount.toString()),
                    child: IconButton(
                        tooltip: 'add to cart',
                        icon: Icon(
                          Icons.shopping_cart,
                          size: 30,
                          color: Color.fromRGBO(73,167,204,1),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed(CartScreen.cartRoute);
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'item Added to cart',
                                textAlign: TextAlign.center,
                              ),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }),
                  )
                ],
              ),
        body:loadedproduct==null?
        Container(
        child: GridView.builder(gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing: 30), itemCount:8,itemBuilder:(con,i){
          return Stack(
            children: <Widget>[
              Shimmer.fromColors(child: Container(
        width: dw(45),
        color: Colors.grey,
        height: dh(20),
        ), baseColor: Colors.transparent, highlightColor: Colors.white),
              Container(
              width: dw(45),
         color: Colors.grey,
         height: dh(20),
              ),
            ],
          );
        }),
          ):
        Builder(builder: (con) {
          scaffContext = con;
          return Container(
              color: Color.fromRGBO(191, 255, 254, 0.1),
              child: (recommand)
                  ? Container(
                      width: dw(100),
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(10),
                          ),
                          Image.asset(
                            'assets/images/product_not_found.jpg',
                            width: MediaQuery.of(context).size.width,
                            height: 150,
                          ),
                          SizedBox(
                            height: 45,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top:5),
                          ),
                          Text(
                            "Recommanded for you",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: "JosefinSans",
                                fontSize: 25),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                          ),
                          Container(
                              width: dw(100),
                              child: CarouselScreen.direct(
                                  current.productStore.values.toList()))
                        ],
                      ),
                    )
                  :ListView(
                children:mainList
              )
          );
        }));
  }

  Widget DisplayItems(Product product,LocalShop shop)
  {
    return Container(
      padding: EdgeInsets.all(10),
      child: Stack(
        children: <Widget>[
          Container(
            child: new Column(
              children: <Widget>[
                Container(
                  height: 120,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    // color: Colors.red,
                    border: Border.all(color:Colors.black),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25)),
                  ),

                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: imageurls
                                .containsKey(product.productId)
                                ? NetworkImage(
                                imageurls[product.productId])
                                : AssetImage(
                              "assets/images/loadingImage.png",
                            ))),
                  ),
                ),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25),
                          ),

                          border:
                          Border.all(color: Colors.black, width: 1),
                          color: Color.fromRGBO(203,236,244,1),
                        ),
//                      height: MediaQuery.of(context).size.height / height,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(5),
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.location_on,color:Colors.redAccent),
                                  Text(
                                    '${shop.name},${shop.location.address}',
                                    style: TextStyle(
                                      color: Colors.black,
                                      backgroundColor: Colors.white,
                                      fontSize: 20,
                                      fontFamily: 'OpenSans',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                // width: MediaQuery.of(context).size.width / 1.7,
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text(
                                    product.productName,
                                    textAlign: TextAlign.center,
                                    // textDirection: TextDirection.rtl,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 25,
                                      fontFamily: 'JosefinSans',
                                    ),
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right:10),
                              child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text('${product.price}\ ₹ /ltr',style: TextStyle(
                                    fontSize: 20,
                                  ),)),
                            ) ,
                            Padding(
                              padding:
                              EdgeInsets.only(top: 10, left: 30, right: 30),
                              child: Text(
                                product.description,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'OpenSans',
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                                padding: EdgeInsets.only(top: 10),
                                child: Row(
                                  children: <Widget>[
                                   productId.type == "fav"
                                        ? new Container()
                                        : Padding(
                                        padding:
                                        EdgeInsets.only(left: 150, top: 7,right:0),
                                        child: IconButton(
                                          tooltip: 'add Favorite',
                                          icon: Icon(
                                            favourite
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            size: 50,
                                            color: Colors.red,
                                          ),
                                          onPressed: () {
                                            favourite = !favourite;
                                            if (favourite)
                                              addToFavourite(
                                                  product);
                                            else
                                              removeFromFavourite(product);
                                            setState(() {});
                                          },
                                        )),
                                  ],
                                )),
                            productId.type == "fav"
                                ?Container()
                                : Container()
                          ],
                        )
                    ))

                //     Padding(padding: ,child:Text('JosefinSans'))
              ],
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              margin: EdgeInsets.only(top:40,left:25),
              height:30,
              decoration: BoxDecoration(
//                border: Border.all(color:Colors.indigo),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 25,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(27, 113, 127, 1),
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomLeft: Radius.circular(20))
                    ),
                    child: Center(
                      child: InkWell(
                        child: Text('-',style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),),
                        onTap:(){
                          if(decreament(product))
                            {
                              current.setMyCart();
                              setState(() {

                              });
                            }
                        },
                      ),
                    ),
                  ),
                  SizedBox(width:5,),
                  Center(
                    child: Text(
                      '${isProductInCart(product)[0]}',
                      overflow: TextOverflow.fade,
                      style: TextStyle(

                          fontSize: 17,
                          fontFamily: 'JosefinSans'
                      ),
                    ),
                  ),
                  SizedBox(width:5,),
                  Container(
                    width: 25,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(27, 113, 127, 1),
                        borderRadius: BorderRadius.only(topRight: Radius.circular(20),bottomRight: Radius.circular(20))
                    ),
                    child: Center(
                      child: InkWell(
                          child: Text('+',style:TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          )),
                          onTap: () {
                            increament(product,shop);
                            current.setMyCart();
                            setState(() {

                            });
                          }
                      ),
                    ),
                  )

                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: EdgeInsets.only(top:30,right: 30),
              child:IconButton(
                icon: Icon(Icons.delete,color:  Color.fromRGBO(27, 113, 127, 1),size: 35,),
                onPressed: () {
                  imageurls
                      .remove(product.productId);
                  loadedproduct.remove(product);
                  removeFromFavourite(product);
                  if (loadedproduct.length == 0) {
                    productId.type = "rec";
                    loadedproduct =
                        current.productStore.values.toList();
                    recommand = true;
                  }
                  setState(() {});
                },
              ),
            ),
          )
        ],
      ),
    );
    /*
    * ChangeNotifierProvider.value(
          value: loadedproduct[index],
          child:Content(index, loadedproduct[index])
    * */
  }

  bool isFavourite(int id) {
    for (Product temp in current.permUser.favouriteProduct) {
      print("fav ${temp.productName}");
      if (temp.productId == id) return true;
    }
    return false;
  }
}

void addToFavourite(Product product) {
  current.permUser.favouriteProduct.add(product);
  current.setFavouriteProducts();
}

void removeFromFavourite(Product product) {
  for(int i=0;i<current.permUser.favouriteProduct.length;i++)
    if(current.permUser.favouriteProduct[i].productId==product.productId)
      {
        current.permUser.favouriteProduct.removeAt(i);
        break;
      }
  current.setFavouriteProducts();
}
