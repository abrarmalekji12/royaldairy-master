import 'package:flutter/material.dart';


class SearchBox extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
     // height:300,
        width: double.infinity,
      child: TextField(
              decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(      
                      borderSide: BorderSide(color: Color.fromRGBO(27, 113, 127, 1),width:1),
                      ),    
              focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black,width: 2),
                   ),  
                
                prefixIcon: Icon(Icons.search,color: Colors.black,),
                hintText: 'Search Here',
                hintStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'OpenSans'
                ),
              ),
              
              style: TextStyle(
                fontSize: 20,
              ),
            )
    );
  }
}