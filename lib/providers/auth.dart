// import 'package:flutter/widgets.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// import 'package:provider/provider.dart';
// class Auth with ChangeNotifier{
//       String _token;
//       DateTime _expiryDate;
//       String _userId;

//           Future<void>  signup(String phoneNo,String password,String email,String name)async {
//               const url='https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyAVUbHPw8zy-XeoUR_HjzPoUGtnAiwzhRU';
//            final response=await http.post(url,body:json.encode({
//               'email':email,
//               'password':password,
//               'phoneNo':phoneNo,
//               'name':name,
//               'returnSecureToken':true,

//             }));
//             print(json.decode(response.body));

//             }
//      Future<void> login(String phoneNo,String password)async{
//                   const url='https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyAVUbHPw8zy-XeoUR_HjzPoUGtnAiwzhRU';
//            final response=await http.post(url,body:json.encode({
             
//               'password':password,
//               'phoneNo':phoneNo,
              
//               'returnSecureToken':true,

//             }));
//             print(json.decode(response.body));

//               }
// }