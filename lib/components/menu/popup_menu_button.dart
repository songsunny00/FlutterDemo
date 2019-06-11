import 'package:flutter/material.dart';
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
      itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
          PopupMenuItem<String>(
            value: "price", child:  Text('Sort by price')),
          PopupMenuItem<String>(
            value: "time", child:  Text('Sort by time')),
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
    })
  }


}