// import 'package:flutter/material.dart';
// import './screens/favorite_screen.dart';
// import './screens/subscription_screen.dart';
// import './screens/home_screen.dart';
// import 'package:provider/provider.dart';
// class BottomBar1 extends StatefulWidget {
//   @override
//   _BottomBarState createState() => _BottomBarState();
// }

// class _BottomBarState extends State<BottomBar> {
//     List <Map<String,Object>> pages=[
//       { 'page':HomeScreen(),'title':'Home'},
//       {'page':FavoriteScreen(),'title':'favorite'},
//       {'page':Subscription(),'title':'subscription'}
//     ];
//     var pageIndex=0;
//   int index = 0;
//   Color backgroundColor = Colors.white;
//   List<NavigationItem> items = [
//     NavigationItem(Icon(Icons.home), Text('Home'), Colors.deepOrangeAccent),
//     NavigationItem(
//         Icon(Icons.favorite), Text('Favorite'), Colors.deepPurpleAccent),
//     NavigationItem(
//         Icon(Icons.subscriptions), Text('Subscription'), Colors.lightBlueAccent),
//   ];
//   Widget buildItem(NavigationItem item, bool isSelected, Color color) {
//     return AnimatedContainer(
//       duration: Duration(milliseconds: 270),
//       width: isSelected ? 125 : 50,
//       height: double.maxFinite,
//       padding: isSelected ? EdgeInsets.only(left: 16, right: 16) : null,
//       decoration: isSelected
//           ? BoxDecoration(
//               color: item.color,
//               borderRadius: BorderRadius.all(Radius.circular(16)))
//           : null,
//       child: ListView(
//         scrollDirection: Axis.horizontal,
//         children: <Widget>[
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               IconTheme(
//                 data: IconThemeData(
//                   size: 24,
//                   color: isSelected ? backgroundColor : Colors.black,
//                 ),
//                 child: item.icon,
//               ),
//               Padding(
//                   padding: const EdgeInsets.only(left: 8),
//                   child: isSelected
//                       ? DefaultTextStyle.merge(
//                           style: TextStyle(
//                             color: backgroundColor,
//                           ),
//                           child: item.title,
//                         )
//                       : Container())
//             ],
//           )
//         ],
//       ),
//     );
//   }
//     Widget createBottomBar()
//       {
//         return Container(
//         //color: Colors.amber,
//         height: 56,
//         decoration: BoxDecoration(
//           color: backgroundColor,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black12,
//               blurRadius: 4,
//             ),
//           ],
//         ),
//         padding: EdgeInsets.only(left: 8, top: 4, bottom: 4, right: 8),
//         width: MediaQuery.of(context).size.width,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: items.map((item) {
//             var itemIndex = items.indexOf(item);
//             return GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     index = itemIndex;
//                     pageIndex=index;
//                   });
//                 },
//                 child: buildItem(item, index == itemIndex,Colors.red)
//                 );
//           }).toList(),
//         ));
//       }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(appBar:AppBar(title:Text("hello")),

//         body:HomeScreen(),
        
//     )
//     ;
//   }
// }

// class NavigationItem {
//   final Icon icon;
//   final Text title;
//   final Color color;
//   NavigationItem(this.icon, this.title, this.color);
// }
