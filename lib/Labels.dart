import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(
        top: 40,
        left: 270,
        child: Container(
          child: Text("1", style: TextStyle(color: Colors.white, fontSize: 24)),
          color: Color.fromRGBO(42, 61, 81, 1),
        ),
      ),
      Positioned(
        top: 15,
        left: 205,
        child: Container(
          child: Text("2", style: TextStyle(color: Colors.white, fontSize: 24)),
          color: Color.fromRGBO(42, 61, 81, 1),
        ),
      ),
      Positioned(
        top: 15,
        left: 140,
        child: Container(
          child: Text("3", style: TextStyle(color: Colors.white, fontSize: 24)),
          color: Color.fromRGBO(42, 61, 81, 1),
        ),
      ),
      Positioned(
        top: 55,
        left: 70,
        child: Container(
          child: Text("4", style: TextStyle(color: Colors.white, fontSize: 24)),
          color: Color.fromRGBO(42, 61, 81, 1),
        ),
      ),
      Positioned(
        top: 125,
        left: 30,
        child: Container(
          child: Text("5", style: TextStyle(color: Colors.white, fontSize: 24)),
          color: Color.fromRGBO(42, 61, 81, 1),
        ),
      ),
      Positioned(
        top: 205,
        left: 35,
        child: Container(
          child: Text("6", style: TextStyle(color: Colors.white, fontSize: 24)),
          color: Color.fromRGBO(42, 61, 81, 1),
        ),
      ),
      Positioned(
        top: 270,
        left: 75,
        child: Container(
          child: Text("7", style: TextStyle(color: Colors.white, fontSize: 24)),
          color: Color.fromRGBO(42, 61, 81, 1),
        ),
      ),
      Positioned(
        top: 305,
        left: 140,
        child: Container(
          child: Text("8", style: TextStyle(color: Colors.white, fontSize: 24)),
          color: Color.fromRGBO(42, 61, 81, 1),
        ),
      ),
      Positioned(
        top: 305,
        left: 220,
        child: Container(
          child: Text("9", style: TextStyle(color: Colors.white, fontSize: 24)),
          color: Color.fromRGBO(42, 61, 81, 1),
        ),
      ),
      Positioned(
          top: 270,
          left: 290,
          child: Container(
            child:
                Text("0", style: TextStyle(color: Colors.white, fontSize: 24)),
            color: Color.fromRGBO(42, 61, 81, 1),
          )),
    ]);
  }
}
