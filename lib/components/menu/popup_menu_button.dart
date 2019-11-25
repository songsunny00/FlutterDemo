import 'package:flutter/material.dart';
import 'package:myapp/pages/home_page/home.dart';
import 'package:myapp/pages/home_page/third_page.dart';
class PopupMenuButtonComp extends StatefulWidget {
  @override
  PopupMenuButtonCompState createState() => new PopupMenuButtonCompState();
}

class PopupMenuButtonCompState extends State<PopupMenuButtonComp> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(
        Icons.add,
        color:Colors.black87
      ),
      offset: Offset(1.0,40.0),
      itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
          PopupMenuItem<String>(
            value: "price", child:  Text('Sort by price',style:TextStyle(color:Colors.white))),
          PopupMenuItem<String>(
            value: "time", 
            child:  ListTile(
              title: Text('time'),
              onTap: (){
                Navigator.push(context,new  MaterialPageRoute(
                  builder:(context) => HomePage())
                );
              },
            ),
          )
      ],
      onSelected: (String action) {
        switch (action) {
          case "price":
          // do nothing
            break;
          case "time":
          // do nothing
            break;
        }
    });
  }


}