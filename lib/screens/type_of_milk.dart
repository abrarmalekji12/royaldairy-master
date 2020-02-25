import 'package:flutter/material.dart';
import 'package:flutter_app/login.dart';
import '../providers/type_modal.dart';
import 'package:provider/provider.dart';
import '../screens/brnad screens/products_screen.dart';
import '../models/chhose.dart';
class TypeOfMilkScreen extends StatefulWidget {
  static const milkTypeScreen = '/milkTypeRoute';

  @override
  _TypeOfMilkScreenState createState() => _TypeOfMilkScreenState();
}

class _TypeOfMilkScreenState extends State<TypeOfMilkScreen> {
  Widget createBrand(String id, String title, String image) {
    return InkWell(
        onTap: () {
          MaterialPageRoute router=new MaterialPageRoute(builder: (context){
            return productScreen(ChooseData(animal: title, type: 'Types',products: current.getFilterProductsByAnimal(title)));
          });
         Navigator.of(context)
               .push(router);
        },
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.5),
                    blurRadius: 5,
                  )
                ],
                // color:Colors.red,
                image: DecorationImage(
                    image: AssetImage(
                      image,
                    ),
                    fit: BoxFit.fill,
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.4), BlendMode.darken)),
              ),
            ),
            Center(
                child: Container(
              child: Text(
                title,
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'Montserrat',
                    color: Colors.white,
                    fontWeight: FontWeight.w700),
              ),
            ))
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    final types = Provider.of<ModalTypePro>(context).types;
    //'assets/images/types/cow_milk.jpeg',assets/images/types/camel_milk.jpeg, 'assets/images/types/buffelo_milk.jfif',  assets/images/types/goat_milk.jpg
    return Scaffold(
        appBar: AppBar(title: Text('Choose milk type')),
        body: Container(
          margin: EdgeInsets.only(top: 40, left: 10, right: 10),
          child: GridView.builder(
              itemCount: types.length,
              itemBuilder: (ctx, i) => createBrand(
                  types[i].typeId, types[i].typeName, types[i].typeUrl),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 1.3,
                crossAxisSpacing: 20,
                mainAxisSpacing: 30,
              )),
        ));
  }
}
