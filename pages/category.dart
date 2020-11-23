import 'package:flutter/material.dart';

class Category extends StatefulWidget{


  @override
  _Category createState() {
    return _Category();
  }
}
class _Category extends State<Category>{
  @override
  Widget build(BuildContext context) {
    return Text(
      "category",
      style: TextStyle(
        fontSize: 40,
        color: Colors.blueGrey,
        backgroundColor: Colors.cyanAccent
      ),
    );
  }
}
