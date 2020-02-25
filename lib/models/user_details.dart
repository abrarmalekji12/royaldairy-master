import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';


class UserDetails  {
  final String userId;
  final String userPic;
  final String userEmail;
  final String userLastName;
  final String userMiddleName;
  final String userFirstName;
  final String userAdd;
  final String userPhoneNo;
  UserDetails({
    @required this.userId,
    @required this.userPic,
    @required this.userEmail,
    @required this.userLastName,
    @required this.userMiddleName,
    @required this.userFirstName,
    @required this.userAdd,
    @required this.userPhoneNo,
  });
}
