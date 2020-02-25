
import '../models/user_details.dart';
import 'package:flutter/material.dart';

class UserData with ChangeNotifier {
  List<UserDetails> _userData = [
    UserDetails(
        userId: 'nishant@12',
        userPic: 'http://tineye.com/images/widgets/mona.jpg',
        userEmail: 'nkpatel23122000@gmail.com',
        userLastName: 'Patel',
        userMiddleName: 'Nishant',
        userFirstName: 'Kamleshkumar',
        userAdd:'61,Gangasager Society,I.O.C Road Chandkheda' ,
        userPhoneNo: '7622976621'),
     UserDetails(
        userId: 'kamlesh@12',
        userPic: 'http://tineye.com/images/widgets/mona.jpg',
        userEmail: 'kkpatel2030@gmail.com ',
        userLastName: 'Patel',
        userMiddleName: 'Kamleshbhai',
        userFirstName: 'KanjiBhai',
        userAdd:'61,Gangasager Society,I.O.C Road Chandkheda' ,
        userPhoneNo: '9825568052'),
     UserDetails(
        userId: 'usha@12',
        userPic: 'http://tineye.com/images/widgets/mona.jpg',
        userEmail: 'ukp23@gmail.com',
        userLastName: 'Patel',
        userMiddleName: 'Ushaben',
        userFirstName: 'Kamleshkumar',
        userAdd:'61,Gangasager Society,I.O.C Road Chandkheda' ,
        userPhoneNo: '9825094639'),
    UserDetails(
        userId: 'riddhi@12',
        userPic: 'http://tineye.com/images/widgets/mona.jpg',
        userEmail: 'riddhi23@gmail.com',
        userLastName: 'Patel',
        userMiddleName: 'Riddhi',
        userFirstName: 'Kamleshkumar',
        userAdd:'61,Gangasager Society,I.O.C Road Chandkheda' ,
        userPhoneNo: '8128163924'),
  ];

  List<UserDetails> get userdata{
    return [..._userData];
  }
  void addData(UserDetails data){
    final newData=UserDetails(
        userId:data.userId,
       userPic:data.userPic,
       userEmail:data.userEmail,
       userLastName:data.userLastName,
       userMiddleName:data.userMiddleName,
       userFirstName:data.userFirstName,
       userAdd:data.userAdd,
       userPhoneNo:data.userPhoneNo,

    );
    _userData.add(newData);

    notifyListeners();
  }

  void updateData(String id,UserDetails newUserdata)
      {
          final userIndex=_userData.indexWhere((prod)=>prod.userId==id);
         
         if(userIndex>0)
         {
          _userData[userIndex]=newUserdata;
          notifyListeners();
         }
         else{
           print('...');
         }

      }
  UserDetails findById(String id)
    {
      return _userData.firstWhere((prod)=>prod.userId==id);
    }



}
