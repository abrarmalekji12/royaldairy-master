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
List<Product> loadedproduct = null;
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
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: productId.type == "fav" || recommand
            ? null
            : AppBar(
                backgroundColor: Colors.indigoAccent,
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
                          color: Colors.white,
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
        body: loadedproduct == null
            ? Container(
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, crossAxisSpacing: 30),
                    itemCount: 8,
                    itemBuilder: (con, i) {
                      return Stack(
                        children: <Widget>[
                          Shimmer.fromColors(
                              child: Container(
                                width: dw(45),
                                color: Colors.grey,
                                height: dh(20),
                              ),
                              baseColor: Colors.transparent,
                              highlightColor: Colors.white),
                          Container(
                            width: dw(45),
                            color: Colors.grey,
                            height: dh(20),
                          ),
                        ],
                      );
                    }),
              )
            : Builder(builder: (con) {
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
                                  padding: EdgeInsets.only(top: 5),
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
                        : PageView.builder(
                            onPageChanged: (value) {
                              favourite =
                                  isFavourite(loadedproduct[value].productId);
                              print(productId.type);
                              setState(() {
                                currentPage = value;
                              });
                            },
                            itemCount: loadedproduct.length,
                            itemBuilder: (context, index) =>
                                DisplayItems(index),
                          ));
              }));
  }

  Widget DisplayItems(int index) {
    double blur = currentPage == index ? 10 : 0;
    double offset = currentPage == index ? 5 : 0;
    double top = currentPage == index ? 50 : 90;
    top -= (productId.type == "fav" ? 40 : 0);
    top -= (productId.type == "rec" ? 50 : 0);
//    Color color1 = Color.fromRGBO(119, 144, 255, 0.8);
    return AnimatedContainer(
        duration: Duration(milliseconds: 1000),
        curve: Curves.easeOutQuint,
        margin: EdgeInsets.only(top: top, bottom: 55, right: 20, left: 10),
        decoration: BoxDecoration(
            // border:Border.all(color: Colors.red,width:2),
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: Colors.purple),
            color: currentPage == index && index % 2 == 0
                ? Color.fromRGBO(119, 144, 255, 0.8)
                : Colors.deepOrangeAccent,
            boxShadow: [
              BoxShadow(
                  color: Colors.black87,
                  blurRadius: blur,
                  offset: Offset(offset, offset))
            ]),
        child: new Stack(
          children: <Widget>[
            Container(
              //  width:300,
              height: 200,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                // color: Colors.red,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50)),
              ),

              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: imageurls
                                .containsKey(loadedproduct[index].productId)
                            ? NetworkImage(
                                imageurls[loadedproduct[index].productId])
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
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50),
                          topLeft: Radius.circular(70),
                          topRight: Radius.circular(70)),
                      border:
                          Border.all(color: Colors.deepOrangeAccent, width: 1),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black45,
                          blurRadius: 70,
                        )
                      ],
                      color: Color.fromRGBO(240, 231, 198, 1),
                    ),
                    height: MediaQuery.of(context).size.height / 1.8,
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
                                loadedproduct[index].productName,
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
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ))),
                        SingleChildScrollView(
                            child: Padding(
                          padding:
                              EdgeInsets.only(top: 10, left: 30, right: 30),
                          child: Text(
                            loadedproduct[index].description,
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
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ))),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding:
                                  EdgeInsets.only(top: 10, left: 30, right: 30),
                              child: Text(
                                "Fat is ${loadedproduct[index].fat} and SCC is ${loadedproduct[index].scc}",
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
                            Padding(
                              padding:
                                  EdgeInsets.only(top: 15, left: 20, right: 30),
                              child: Text(
                                '${loadedproduct[index].price}\ ₹ /1 ltr',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'OpenSans',
                                ),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ],
                        ),
                        Container(
                            padding: EdgeInsets.only(top: 10),
                            child: Row(
                              //  mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Padding(
                                    padding: productId.type == "fav"
                                        ? EdgeInsets.only(left: dw(50), top: 10)
                                        : EdgeInsets.only(left: 20, top: 10),
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
                                                  .contains(
                                                      loadedproduct[index])) {
                                                if (current.permUser.myCart
                                                            .quantities[
                                                        current.permUser.myCart
                                                            .products
                                                            .indexOf(
                                                                loadedproduct[
                                                                    index])]-- ==
                                                    0) {
                                                  current.permUser.myCart
                                                      .quantities
                                                      .removeAt(current.permUser
                                                          .myCart.products
                                                          .indexOf(
                                                              loadedproduct[
                                                                  index]));
                                                  current
                                                      .permUser.myCart.products
                                                      .remove(
                                                          loadedproduct[index]);
                                                }
                                                current.setMyCart();
                                                setState(() {});
                                              }
                                            }),
                                        Text(
                                          '${current.permUser.myCart.products.contains(loadedproduct[index]) ? current.permUser.myCart.quantities[current.permUser.myCart.products.indexOf(loadedproduct[index])] : 0}',
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
                                            if (current.permUser.myCart.products
                                                .contains(loadedproduct[index]))
                                              current.permUser.myCart
                                                      .quantities[
                                                  current
                                                      .permUser.myCart.products
                                                      .indexOf(loadedproduct[
                                                          index])]++;
                                            else {
                                              current.permUser.myCart.products
                                                  .add(loadedproduct[index]);
                                              current.permUser.myCart.quantities
                                                  .add(1);
                                            }
                                            current.setMyCart();
                                            setState(() {});
                                          },
                                        )
                                      ],
                                    )),
                                productId.type == "fav"
                                    ? new Container()
                                    : Padding(
                                        padding:
                                            EdgeInsets.only(left: 180, top: 10),
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
                                                  loadedproduct[index]);
                                            else
                                              removeFromFavourite(
                                                  loadedproduct[index]);
                                            setState(() {});
                                          },
                                        )),
                              ],
                            )),
                        productId.type == "fav"
                            ? Container(
                                margin: EdgeInsets.only(top: 20),
                                child: FlatButton(
                                  child: new Text(
                                    'remove from favourites',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20),
                                  ),
                                  onPressed: () {
                                    imageurls
                                        .remove(loadedproduct[index].productId);
                                    removeFromFavourite(loadedproduct[index]);
                                    loadedproduct.remove(index);
                                    if (loadedproduct.length == 0) {
                                      productId.type = "rec";
                                      loadedproduct =
                                          current.productStore.values.toList();
                                      recommand = true;
                                    }
                                    setState(() {});
                                  },
                                ),
                              )
                            : Container()
                      ],
                    ))))

            //     Padding(padding: ,child:Text('JosefinSans'))
          ],
        ));
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
  current.permUser.favouriteProduct.remove(product);
  current.setFavouriteProducts();
}
