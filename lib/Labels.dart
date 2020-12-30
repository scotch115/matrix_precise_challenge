import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(
        top: 75,
        left: 310,
        child: Container(
          child: Text("1", style: TextStyle(color: Colors.white, fontSize: 24)),
          color: Color.fromRGBO(42, 61, 81, 1),
        ),
      ),
      Positioned(
        top: 28,
        left: 260,
        child: Container(
          child: Text("2", style: TextStyle(color: Colors.white, fontSize: 24)),
          color: Color.fromRGBO(42, 61, 81, 1),
        ),
      ),
      Positioned(
        top: 5,
        left: 180,
        child: Container(
          child: Text("3", style: TextStyle(color: Colors.white, fontSize: 24)),
          color: Color.fromRGBO(42, 61, 81, 1),
        ),
      ),
      Positioned(
        top: 25,
        left: 100,
        child: Container(
          child: Text("4", style: TextStyle(color: Colors.white, fontSize: 24)),
          color: Color.fromRGBO(42, 61, 81, 1),
        ),
      ),
      Positioned(
        top: 90,
        left: 40,
        child: Container(
          child: Text("5", style: TextStyle(color: Colors.white, fontSize: 24)),
          color: Color.fromRGBO(42, 61, 81, 1),
        ),
      ),
      Positioned(
        top: 165,
        left: 25,
        child: Container(
          child: Text("6", style: TextStyle(color: Colors.white, fontSize: 24)),
          color: Color.fromRGBO(42, 61, 81, 1),
        ),
      ),
      Positioned(
        top: 245,
        left: 48,
        child: Container(
          child: Text("7", style: TextStyle(color: Colors.white, fontSize: 24)),
          color: Color.fromRGBO(42, 61, 81, 1),
        ),
      ),
      Positioned(
        top: 300,
        left: 110,
        child: Container(
          child: Text("8", style: TextStyle(color: Colors.white, fontSize: 24)),
          color: Color.fromRGBO(42, 61, 81, 1),
        ),
      ),
      Positioned(
        top: 315,
        left: 185,
        child: Container(
          child: Text("9", style: TextStyle(color: Colors.white, fontSize: 24)),
          color: Color.fromRGBO(42, 61, 81, 1),
        ),
      ),
      Positioned(
          top: 295,
          left: 260,
          child: Container(
            child:
                Text("0", style: TextStyle(color: Colors.white, fontSize: 24)),
            color: Color.fromRGBO(42, 61, 81, 1),
          )),
    ]);
  }
}
