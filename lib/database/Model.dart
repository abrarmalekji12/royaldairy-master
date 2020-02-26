
import 'dart:async';
import 'dart:core';
import 'dart:io';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_app/login.dart';
import 'package:flutter_app/screens/brnad%20screens/products_screen.dart';
import 'package:flutter_app/screens/cart_screen.dart';
import 'package:geocoder/services/base.dart';
import 'package:geocoder/services/distant_google.dart';
import 'package:geocoder/services/local.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Model extends ChangeNotifier{
  User permUser;
  Map<int,Product> productStore={};
  Map<int,LocalShop> shopStore={};
  Map<int,Order> orderStore={};
  Map<int,Subscription2> subStore={};
  Map<int,Review> reviewStore={};
  Map<int,Brand> brandStore={};
  FirebaseDatabase _database;
  FirebaseStorage _storage;
  FirebaseAuth _auth;
  FirebaseUser _user;
  Map<dynamic,dynamic> data;

  Model() {
    _database = FirebaseDatabase.instance;
    _storage = FirebaseStorage.instance;
    _auth = FirebaseAuth.instance;
  }
bool  isLogged(){
    return _user!=null;
}
  String getName() {
    if (_user != null) return _user.email;
    return "";
  }
  Future<Map<dynamic,dynamic>> getTest() async{
  return (await _database.reference().child("products").child("1").once()).value;
  }
  void setTest(Map<dynamic,dynamic> map1) async{
    int len=(await _database.reference().child("products").child("0").once()).value+1;
    await _database.reference().child("products").child("0").set(len);
    await _database.reference().child("products").child("$len").set(map1);
  }
   Future<Brand> getBrand(int i) async{
    if(brandStore.containsKey(i))
      return brandStore[i];
    var brandData=(await _database.reference().child("brands").child("$i").once()).value;
    Brand brand=Brand.fromJson(brandData, i);
    return brandStore[i]=brand;
  }
  Future<Order> getOrder(int i) async {
    if(orderStore.containsKey(i))
      return orderStore[i];
    var orderData=(await _database.reference().child("orders").child("$i").once()).value;
    orderData['orderId']=i;
    List<Product> prods=[];
    for(int j=1;j<=orderData['products'][0];j++)
      prods.add(await getProduct(orderData['products'][j]));
    Order order=Order.fromJson(orderData,orderData['shop']==-1?null:(await getShop(orderData['shop'])),prods);
    orderStore[i]=order;
    return order;
  }
  createCart() async{
    var val=await _database.reference().child("orders").child("0").once();
          permUser.myCart=Order(val.value+1);
    _database.reference().child("users").child("${permUser.id}").child("myCart").set(val.value+1);
          _database.reference().child("orders").child("0").set(val.value+1);
          _database.reference().child("orders").child("${val.value+1}").set(permUser.myCart.toJson());
  }
  void saveOrder(Order order){
    _database.reference().child("orders").child("${order.orderId}").set(order.toJson());
  }

  Future<Subscription2> getSubscription(int i) async{
    if(subStore.containsKey(i))
      return subStore[i];//subsciptions
    var subData=(await _database.reference().child("subsciptions").child("$i").once()).value;
    if(subData==null)
      print('hey null');
    subData['subId']=i;
    LocalShop myshop=await getShop(subData['shop']);
    List<Product> prods=[];
    for(int j=1;j<=subData['products'][0];j++)
      prods.add(await getProduct(subData['products'][j]));
    Subscription2 subscription2=Subscription2.fromJson(subData,myshop,prods);
    subStore[i]=subscription2;
  return subscription2;
  }
  Future<Review> getReview(int i) async {
    if(reviewStore.containsKey(i))
      return reviewStore[i];
    var reviewsData=(await _database.reference().child("reviews").child("$i").once()).value;
    reviewsData['reviewId']=i;
    Review review=Review.fromJson(reviewsData);
    reviewStore[i]=review;
    return review;
  }
  void setMyCart(){
    if(permUser.myCart!=null)
      saveOrder(permUser.myCart);
  }
  List<Product> getFilterProductsByAnimal(String animal){
   List<Product> filter=[];
    for(Product product in productStore.values)
      if(product.animal==animal)
        filter.add(product);
    return filter;
  }
  Future<String>  getDownloadUrl(String temp) async{
    return await _storage.ref().child(temp).getDownloadURL();
  }
  void setFavouriteProducts(){
    var fav=[permUser.favouriteProduct.length]+permUser.favouriteProduct.map((val)=>val.productId).toList();
    _database.reference().child("users").child("${permUser.id}").child("favouriteProduct").set(fav);
  }
   Future<LocalShop> getShop(int i) async{
     if(shopStore.containsKey(i))
       return shopStore[i];
    var ab=await _database.reference().child('shops').child('$i').once();
    var shopData=ab.value;
    if(shopData==null) {
      print('showdata null');
      return null;
    }
    print(shopData);
    shopData['shopId']=i;
    List<Product> products=[];
    for(int i=1;i<=shopData['products'][0];i++)
      {
        products.add(await getProduct(shopData['products'][i]));
      }
    return shopStore[i]=LocalShop.fromJson(shopData, products);
   }
   bool isCartProductAvailable(Product product){
    for(LocalShop shop in shopStore.values)
      for(Product temp in shop.products)
        if(temp.productId==product.productId)
        return true;
      return false;
   }
   Future<User> loadUser() async{
    print("Called load user\n");
    var did=await _database.reference().child('auth_user').child("${_user.uid}").once();
    var ab=(await _database.reference().child('users').child("${did.value}").once()).value;
    data=ab;
    permUser=User.fromJson(ab,did.value);
    await loadFavouriteProducts();
    await loadMyCart();
     print("loaded without error");
    return permUser;
   }
   Future<List<Product>> getAllProduct() async{
     permUser.favouriteStore=[];
     shopStore={};
     productStore={};
     if(permUser.locationIndex>=0)
       permUser.favouriteStore=await getFavourableShops(permUser.totalLocations[permUser.locationIndex]);
     return productStore.values.toList();
   }
   Future<void> loadFavouriteProducts() async{
    permUser.favouriteProduct=[];
     for(int i=1;i<=data['favouriteProduct'][0];i++)
       {
         var product = await getProduct(data['favouriteProduct'][i]);
         permUser.favouriteProduct.add(product);
       }
      }
   Future<void> loadMyCart() async {
     if(data['myCart']==-1)
       createCart();
     else
       current.permUser.myCart=await getOrder(data['myCart']);
   }
   Future<void> loadBrands() async {
     brandStore={};
     var  val=(await _database.reference().child("brands").child("0").once()).value;
     for(int i=1;i<=val;i++)
     brandStore[i]=await getBrand(i);
   }
   Future<void> loadOrders() async {
     permUser.totalOrders=[];
     for(int j=1;j<=data['totalOrders'][0];j++)
       permUser.totalOrders.add(await getOrder(data['totalOrders'][j]));
   }
  Future<void> loadSubs() async
  {
    permUser.mySubscriptions=[];
  for(int j=1;j<=data['mySubscriptions'][0];j++)
    permUser.mySubscriptions.add(await getSubscription(data['mySubscriptions'][j]));
  }
  Future<void> loadReviews() async
  {
  permUser.reviews=[];
  for(int j=1;j<=data['reviews'][0];j++)
    permUser.reviews.add(await getReview(data['reviews'][j]));
}

   Future<Product> getProduct(int i) async{
     if(productStore.containsKey(i))
       return productStore[i];
    var temp=(await _database.reference().child("products").child("$i").once()).value;
    temp['productId']=i;
    Product product=Product.fromJson(temp);
    productStore[i]=product;
    return product;
   }
   List<Brand> getAvailableBrands(){
    List<Brand> brands=[];
    for(Brand brand in brandStore.values.toList())
      {

      }
  }
   void resetPassword(String email){
    _auth.sendPasswordResetEmail(email: email).then((val){
      print("Mail sent successfully");
    });
   }
  Future<bool> registerNewUser(String email, String pass, String mob,String name) async {
    FirebaseUser result = await  _auth.createUserWithEmailAndPassword(
      email: email,
      password: pass,
    )
        .catchError((error) {
      print("Error register " + error.message);
      return null;
    });
    if (result == null) return false;
    _user = result;
    int len = (await  _database.reference().child("auth_user").child("len").once()).value;
      int i = -1;
      if (len != null) {
        _database.reference().child("auth_user").child(_user.uid).set(len);
        _database.reference().child("auth_user").child('len').set(len + 1);
        i = len;
      } else {
        _database.reference().child("auth_user").child(_user.uid).set(0);
        _database.reference().child("auth_user").child('len').set(1);
        i = 0;
      }
      permUser = User(name,mob,i);
    _database.reference().child("users").child("$i").set(permUser.toJson());
    List<LocalShop> favshops=[];
    var a=Geolocator();
    var loc=await a.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    Location location=Location(loc.latitude,loc.longitude);
    permUser.totalLocations.add(location);
    permUser.locationIndex=0;
    setUserLocationIndex(0);
    saveUserLocation(location);
    createCart();
      favshops=await getFavourableShops(location);
      permUser.favouriteStore=favshops.toList();
    return true;
  }
  String getImage()=>_user.photoUrl;
   Future<List<LocalShop>>  getFavourableShops(Location location) async {
     print("Called getFavourable...");
  Query query1=  _database.reference().child("shops").orderByChild("location/longitude").startAt(location.longitude-0.1).endAt(location.longitude+0.1);
        var long=(await query1.once()).value;
          List<LocalShop> filter=[];
          int i=0;
          if(long!=null)
          for(var check in long)
            {
              if(check!=null){
                if(check['location']['latitude']>location.latitude-0.1&&check['location']['latitude']<location.latitude+0.1) {
                  List<Product> prods=[];
                  for(int j=1;j<=check['products'][0];j++) {
                    print("getting product is ${check['products'][j]} in favourable ");
                    prods.add(await getProduct(check['products'][j]));
                  }
                  var shop=LocalShop.fromJson(check,prods);
                  filter.add(shop);
                  shopStore[i]=shop;
                }
              }
              i++;
            }
          print("final ${filter}");
          return filter;
    //TODO 23.464067,73.288854
     //   print("hey ${val.value}");
  }
  Map<Brand,List<Product>> getFilterByBrandName(){
    Map<Brand,List<Product>> map1={};
    for(Brand brand in brandStore.values)
      {
        List<Product> pros=[];
           print("working ${brand.brandName}");
          for(int id in brand.productIds)
            if(productStore.containsKey(id))
            pros.add(productStore[id]);
            if(pros.length!=0)
                map1[brand]=pros;
      }
    return map1;
  }
  void saveUserLocationWithIndex(Location location,int index){
     var a=_database.reference().child("users").child("${permUser.id}");
     a.child("totalLocations").child("${permUser.totalLocations.length}").set(location.toJson());
     a.child("totalLocations").child("0").set(permUser.totalLocations.length);
      a.child("locationIndex").set(index);
  }
  void saveUserLocation(Location location)
  {
    var a=_database.reference().child("users").child("${permUser.id}");
    a.child("totalLocations").child("${permUser.totalLocations.length}").set(location.toJson());
    a.child("totalLocations").child("0").set(permUser.totalLocations.length);
  }
  void setUserLocationIndex(int index){
    _database.reference().child("users").child("${permUser.id}").child("locationIndex").set(index);
  }
  void saveUserProfileDetails({String name,String mob}){
    current.permUser.name = name;
    current.permUser.mob = mob;
     print("userr ${permUser.id}");
    _database.reference().child("users").child("${permUser.id}").update({"name":name,"mob":mob}).then((val){
      print("name saved");
    }).catchError((err){
      print("error saving name");
    });
//     _database.reference().child("users").child("${permUser.id}").child("mob").set(mob);
  }
  Future<bool>  signInWithGoogle() async{
     GoogleSignIn sign=GoogleSignIn();
     var account=await sign.signIn();
   var authdata=await account.authentication;
   _user=await _auth.signInWithGoogle(idToken: authdata.idToken, accessToken: authdata.accessToken);
   if(_user!=null)
     return true;
   return false;
//     if(account==null)
//       return false;
////     print("google hey ${account.displayName}");
//     return true;
  }
  Future<bool> logIn(String email, String pass) async {
     print("login called");
    var re = await _auth
        .signInWithEmailAndPassword(email: email, password: pass)
        .catchError((error) {
      return null;
    });
    if (re == null) {
      return false;}
    _user = re;
    if (_user != null) 
    {
     await loadUser();
     return true;
    }
    return false;
  }

  logOut() {
    _auth.signOut();
    _user=null;
    permUser=null;
    SharedPreferences.getInstance().then((preff){
      preff.remove("email");
      preff.remove("password");
    });
    print("sign out");
  }
}

class User extends ChangeNotifier{
  int id;
  String mob;
  String name;
  int locationIndex;
  List<Location> totalLocations;
  List<Product> favouriteProduct;
  List<Transaction> transactions;
  List<LocalShop> favouriteStore;
  Order myCart;
  List<Order> totalOrders;
  List<Subscription2> mySubscriptions;
  List<Review> reviews;
  int currentSubscription;

  User(this.name,this.mob, this.id) {
    totalLocations = [];
    favouriteProduct = [];
    favouriteStore = [];
    totalOrders = [];
    myCart=null;
    mySubscriptions = [];
    locationIndex = -1;
    currentSubscription = -1;
    reviews=[];
  }
  void addFav(Product product){
    favouriteProduct.add(product);
    loadedproduct.add(product);
      current.getDownloadUrl(product.imageURL).then((val) {
        imageurls[product.productId] = val;
      });
    notifyListeners();
  }
  User.fromJson(json,int i){
    id=i;
    mob=json['mob'];
    name=json['name'];
    locationIndex=json['locationIndex'];
    currentSubscription=json['currentSubscription'];
    totalLocations=[];
    if(locationIndex!=-1){
      for(int i=1;i<=json['totalLocations'][0];i++)
        totalLocations.add(Location.fromJson(json['totalLocations'][i], i));
    }
  }
void addDetails(List<Product> favProducts,List<LocalShop> favShops,Order ordr,List<Order> orders, List<Subscription2> subs,List<Review> revie){
  favouriteProduct=favProducts;
  favouriteStore=favShops;
  if(ordr!=null)
  myCart=ordr;
  totalOrders=orders;
  mySubscriptions=subs;
  reviews=revie;

  }
  toJson() {
    var tl=[];
    tl.add(totalLocations.length);
    tl.addAll(totalLocations.map((val)=>val.toJson()).toList());
    return {
      'mob': mob,
      'name':name,
      'locationIndex': locationIndex,
      'totalLocations': tl,
      'favouriteProduct': [favouriteProduct.length]+favouriteProduct.map((val) => val.productId).toList(),
//      'favouriteStore': [favouriteStore.length]+favouriteStore.map((val) => val.shopId).toList(),
      'myCart':myCart==null?-1:myCart.orderId,
      'totalOrders': [totalOrders.length]+totalOrders.map((val) => val.orderId).toList(),
      'mySubscriptions': [mySubscriptions.length]+mySubscriptions.map((val) => val.subId).toList(),
      'currentSubscription': currentSubscription,
      'reviews':[reviews.length]+reviews.map((val)=>val.reviewId).toList()
    };
  }
}

class Location {
  int locationId;
  double latitude, longitude;
  String address;
  Location.fromJson(data,int id){
    locationId=id;
    latitude=data['latitude'];
    longitude=data['longitude'];
    address=data['address'];
  }
  Location(this.latitude, this.longitude) {
    var a=GoogleGeocoding(google_api_ky);
    a.findAddressesFromCoordinates(Coordinates(latitude, longitude)).then((ads){
      print("MAP ${ads[0].toMap()}");
      this.address="${ads[0].subLocality},${ads[0]},${ads[0].subLocality},${ads[0].locality}";
    });
  }

   Location.fromAddress(String add)  {
    this.address=add;
  }
  Future<void> setAll() async{
    locationId=current.permUser.totalLocations.length+1;
    var value=await GoogleGeocoding(google_api_ky).findAddressesFromQuery(address);
    this.latitude=value[0].coordinates.latitude;
    this.longitude=value[0].coordinates.longitude;
    current.permUser.totalLocations.add(this);
    current.permUser.locationIndex=current.permUser.totalLocations.length-1;
    current.setUserLocationIndex(current.permUser.totalLocations.length-1);
    current.saveUserLocation(this);
  }
  toJson() {
    return {'latitude': latitude, 'longitude': longitude,'address':address};
  }
}

class Order {
  int orderId;
  LocalShop shop;
  List<Product> products;
  List<int> quantities; // in litres
  String orderedTime; //TODO time like 02:30AM|02/3/2020 "02/03/2020|11:30"
  int status; // if   status 1 then order is now done but it is not places| if 2 then delivered| if 3 then it is canceled
  String deliveredTime; //TODO delivered time
  Order(this.orderId){
    this.orderedTime="";
    this.quantities=[];
    this.deliveredTime="";
    this.status=0;
    this.products=[];
    this.shop=null;
  }
  Order.fromJson(json,LocalShop temp,List<Product> prods){
    orderId=json['orderId'];
    shop=temp;
    products=prods;
    quantities=[];
    for(int i=1;i<=json['quantities'][0];i++)
      quantities.add(json['quantities'][i]);
    orderedTime=json['orderedTime'];
    status=json['status'];
    deliveredTime=json['deliveredTime'];
  }
  toJson() {
    return {
      'shop': shop==null?-1:shop.shopId,
      'products': [products.length]+products.map((val)=>val.productId).toList(),
      'quantities': [quantities.length]+quantities.toList(),
      'orderedTime': orderedTime,
      'status': status,
      'deliveredTime': deliveredTime
    };
  }
}

class Subscription2 {
  int subId;
  LocalShop shop;
  List<Product> products;
  List<int> quantities;
  String startingDate, endingDate; //02/02/2020 to 10/02/2020
  String dailyTime;
  bool isContinue;
  //daily 07:30AM
  //for discount I may add few attributes

  Subscription2.fromJson(json,LocalShop shop2,List<Product> prods){
    subId=json['subId'];
    shop=shop2;
    products=prods;
    quantities=[];
    for(int i=1;i<=json['quantities'][0];i++)
      quantities.add(json['quantities'][i]);
    startingDate=json['startingDate'];
    endingDate=json['endingDate'];
    dailyTime=json['dailyTime'];
    isContinue=json['isContinue'];
  }
  toJson() {
    return {
      'shop': shop.shopId,
      'products': [products.length]+products.map((val)=>val.productId),
      'quantities': quantities,
      'startingDate': startingDate,
      'endingDate': endingDate,
      'dailyTime': dailyTime,
      'isContinue': isContinue
    };
  }
}

class Product extends ChangeNotifier{
  int productId;
  String productName;
  String imageURL;
  String animal;
  String description;
  double price;
  List<int> shopIds;
  int scc;
  double fat;
  bool isPacked;
  List<int> reviewIds;
  Product.fromJson(Map<dynamic,dynamic> data){
    productId=data['productId'];
    productName=data['productName'];
    animal=data['animal'];
    imageURL=data["imageURL"];
    description=data['description'];
    price=double.parse(data['price'].toString());
   shopIds=[];
    for(int i=1;i<=data['shopIds'][0];i++)
    shopIds.add(data['shopIds'][i]);
    scc=data['scc'];
    fat=double.parse(data['fat'].toString());
    isPacked=data['isPacked'];
    reviewIds=[];
    for(int i=1;i<=data['reviewIds'][0];i++)
      reviewIds.add(data['reviewIds'][i]);
  }
  toJson() => {
        'productName': productName,
        'animal':animal,
      'imageURL':imageURL,
      'description':description,
    'price':price,
    'shopIds':[shopIds.length]+shopIds,
    'scc':scc,
    'fat':fat,
    'isPacked':isPacked,
    'reviewIds':[reviewIds.length]+reviewIds
      };
}

class Review {
  int reviewId;
  int userId;
  int productId;
  int shopId;
  int rating;
  String review;
  Review.fromJson(json){
    reviewId=json['reviewId'];
     userId=json['userId'];
     productId=json['productId'];
     shopId=json['shopId'];
     rating=json['rating'];
     review=json['review'];
  }
  toJson()=>{
    'userId':userId,
    'productId':productId,
    'rating':rating,
    'shopId':shopId,
    'review':review
  };
}

class LocalShop {
  String name;
  List<Product> products;
  List<int> stockOfProducts;
  String mobileNumber;
  int shopId;
  Location location;
  int totalOrders,totalSubscriptions;
  LocalShop.fromJson(data,List<Product> productList){
    name=data['name'];
    products=productList;
    mobileNumber=data['mobileNumber'];
    shopId=data['shopId'];
    location=Location.fromJson(data['location'], 0);
    totalOrders=data['orders'][0];
    totalSubscriptions=data['subscriptions'][0];
  }
  //List<Order> orders;
  //List<Subscription> subscriptions;
}
class Employee{
  int empId;
  String name;
  String mob;
  String email;
  Location current;
}

class Brand {
  int brandId;
  String brandName;
  List<int> shopIds;
  List<int> productIds;
  String description;
  String imageURL;
  Brand.fromJson(json,brandid){
    this.brandId=brandid;
    shopIds=[];
    for(int i=1;i<=json['shopIds'][0];i++)
        shopIds.add(json['shopIds'][i]);
    productIds=[];
    for(int i=1;i<=json['productIds'][0];i++)
      productIds.add(json['productIds'][i]);
      description=json['description'];
   imageURL=json['imageURL'];
   brandName=json['brandName'];
  }
}

String getDistanceFromLatLonInKm(Location f,Location s) {
  var R = 6371; // Radius of the earth in km
  var dLat = deg2rad(s.latitude-f.latitude);  // deg2rad below
  var dLon = deg2rad(s.longitude-f.longitude);
  var a = sin(dLat/2) * sin(dLat/2) + cos(deg2rad(f.latitude)) * cos(deg2rad(s.latitude)) * sin(dLon/2) * sin(dLon/2);
//  var c = 2 *  atan2(sqrt(a), sqrt(1-a));// Distance in km
  double distance=(R * 2*sqrt(a));
  return distance<1?"${(distance*1000).round()} m":"${distance.round()} km";
}

deg2rad(deg) {
  return deg * (pi/180);
}
class Transaction{
  int transactionId;
  int connectId;//TODO orderid // subscriptionId
  bool isOrder;
  double money;
  String time;//TODO 2:45AM|4/5/2020
  int status;//0 , 1 ,2
}