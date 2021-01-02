// Written by Jordan Gamache © December, 2020
import 'dart:math';
import 'package:flutter/material.dart';
import 'Labels.dart';
import 'StopPosition.dart';
import 'history.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Container(
          // Set background image
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/background.png"),
                  fit: BoxFit.cover)),
          child: Rotary()),
    );
  }
}

class Rotary extends StatefulWidget {
  Rotary({Key key}) : super(key: key);

  @override
  _RotaryState createState() => _RotaryState();
}

class _RotaryState extends State<Rotary> {
  final databaseReference = Firestore.instance;

  // Initialize empty string variables
  String _selection = "",
      display = "",
      results = "",
      incorrect = "",
      _operator = "",
      _history = "";
  int counter = 0; // Counter to determine if number of results have changed
  double radius = 130;
  double _movement = 0;
  double _rotationAngle = 0.2;
  List<Widget> result = [];
  List<Widget> _incorrect = [];

  double radians(double angle) {
    return angle * pi / 180;
  }

  // --------------------------- Class Methods --------------------------- //

  // Computational algorithm -- check each digit in selection and test for all potential expressions to equal target (24)
  void check(
      double sum, double previous, String digits, double target, String expr) {
    counter = incorrect.length; // Set counter to current length of results
    // stop if EOL
    if (digits.length == 0) {
      // If the current number being tested (sum) + the last number equals the target number, add the expression to results
      if (sum + previous == target) {
        // print("$expr = $target");
        // remove repetitive recursive checks from computed results
        if (!expr.contains("24")) {
          // Only save one version (duplicates due to associative property sometimes occur)
          if (!results.contains("$expr = $target \n")) {
            var test = "$expr = $target \n";
            if (test.length >
                20) // Filter any expressions that only use 3 of the given 4 digits
            {
              results += "$expr = $target \n";
            }
          }
        }
      } else {
        incorrect += "$expr\n";
        // print(incorrect);
      }
    } else {
      // Recursively traverse the selection of 4 digits and check using all operators if the available digits can equal 24
      for (int i = 1; i <= digits.length; i++) {
        double current = double.parse(digits.substring(0, i));
        String remaining = digits.substring(i);
        check(sum + previous, current, remaining, target,
            expr + " + " + current.toString());
        check(sum, previous * current, remaining, target,
            expr + " * " + current.toString());
        check(sum, previous / current, remaining, target,
            expr + " / " + current.toString());
        check(sum + previous, -current, remaining, target,
            expr + " - " + current.toString());
      }
    }
  }

  _checkList(String selection, double target) {
    print("Current selection: $selection \n");
    // Pass selection to local variable and call setState to reload Scaffold
    setState(() {
      _selection = selection;
    });
    // Only run algorithm if the user has selected 4 digits
    if (selection.length == 4) {
      for (int i = 1; i < 4; i++) {
        selection.runes.forEach((int rune) {
          var pos = new String.fromCharCode(rune);
          print("Current position is: $pos");
          print("${selection.substring(i)}");
          /* Split string into individual characters to stop algorithm from running 
           * combination of numbers (i.e. the string '123' should be separated into '1', '2', and '3' so that it doesn't run '1', '12', and '123')
           */
          check(0.0, double.parse(pos), selection.substring(0, i), target, pos);
        });
      }
      _displaySelection();

      // After algorithm has been processed, clear the storage variable and reload scaffold
      setState(() {
        _selection = "";
      });
    } else {
      return;
    }
  }

  // ignore: missing_return
  void _displaySelection() {
    String selection = _selection;

    if (results.isNotEmpty) {
      display = "";
      /* In theory, the following code would be used to return the UI-specific results (red if wrong and colorful if correct) */
      for (int i = 0; i < results.length; i++) {
        if (results[i] != " " && results.length > 20) {
          var str = results[i].split('.');
          str[0].runes.forEach((element) {
            if (String.fromCharCode(element) != "0") {
              if (String.fromCharCode(element) == "*" ||
                  String.fromCharCode(element) == "/" ||
                  String.fromCharCode(element) == "+" ||
                  String.fromCharCode(element) == "-") {
                _operator += new String.fromCharCode(element);
              } else {
                display += new String.fromCharCode(element);
              }
            }
          });
        }
      }
      if (display[3] != '=') {
        // Reduce garbage data accidentally generated by the check() algorithm
        result.add(Row(children: [
          Container(
              width: 50,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.black54,
                        blurRadius: 15.0,
                        offset: Offset(0.0, 0.75))
                  ],
                  shape: BoxShape.circle,
                  color: Color.fromRGBO(125, 202, 160, 1)),
              child: Text(
                (display != null) ? display[0] : "null",
                style: TextStyle(color: Colors.white, fontSize: 32),
              )),
          Text(
            _operator[0],
            style: TextStyle(color: Colors.white, fontSize: 32),
          ),
          Container(
              width: 50,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.black54,
                        blurRadius: 15.0,
                        offset: Offset(0.0, 0.75))
                  ],
                  shape: BoxShape.circle,
                  color: Color.fromRGBO(125, 202, 160, 1)),
              child: Text(
                display[1],
                style: TextStyle(color: Colors.white, fontSize: 32),
              )),
          Text(
            _operator[1],
            style: TextStyle(color: Colors.white, fontSize: 32),
          ),
          Container(
              width: 50,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.black54,
                        blurRadius: 15.0,
                        offset: Offset(0.0, 0.75))
                  ],
                  shape: BoxShape.circle,
                  color: Color.fromRGBO(96, 136, 175, 1)),
              child: Text(display[2],
                  style: TextStyle(color: Colors.white, fontSize: 32))),
          Text(
            _operator[2],
            style: TextStyle(color: Colors.white, fontSize: 32),
          ),
          Container(
              width: 50,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.black54,
                        blurRadius: 15.0,
                        offset: Offset(0.0, 0.75))
                  ],
                  shape: BoxShape.circle,
                  color: Color.fromRGBO(96, 136, 175, 1)),
              child: Text(display[3],
                  style: TextStyle(color: Colors.white, fontSize: 32))),
          Text(
            "=",
            style: TextStyle(color: Colors.white, fontSize: 32),
          ),
          Container(
              width: 50,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.black54,
                        blurRadius: 15.0,
                        offset: Offset(0.0, 0.75))
                  ],
                  shape: BoxShape.circle,
                  color: Color.fromRGBO(96, 136, 175, 1)),
              child: Text("24",
                  style: TextStyle(color: Colors.white, fontSize: 32)))
        ]));
        databaseReference.collection('rotarySelection').document().setData({
          'expression':
              '${display[0]} ${_operator[0]} ${display[1]} ${_operator[1]} ${display[2]} ${_operator[2]} ${display[3]} = 24'
        });
      }
    } else if (_incorrect.isNotEmpty) {
      _incorrect.add(Row(children: [
        Container(
            width: 50,
            height: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.black54,
                  blurRadius: 15.0,
                  offset: Offset(0.0, 0.75))
            ], shape: BoxShape.circle, color: Colors.red),
            child: Text(
              selection[0],
              style: TextStyle(color: Colors.white, fontSize: 32),
            )),
        Container(
            width: 50,
            height: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.black54,
                  blurRadius: 15.0,
                  offset: Offset(0.0, 0.75))
            ], shape: BoxShape.circle, color: Colors.red),
            child: Text(
              selection[1],
              style: TextStyle(color: Colors.white, fontSize: 32),
            )),
        Container(
            width: 50,
            height: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.black54,
                  blurRadius: 15.0,
                  offset: Offset(0.0, 0.75))
            ], shape: BoxShape.circle, color: Colors.red),
            child: Text(selection[2],
                style: TextStyle(color: Colors.white, fontSize: 32))),
        Container(
            width: 50,
            height: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.black54,
                  blurRadius: 15.0,
                  offset: Offset(0.0, 0.75))
            ], shape: BoxShape.circle, color: Colors.red),
            child: Text(selection[3],
                style: TextStyle(color: Colors.white, fontSize: 32))),
      ]));
      print("_incorrect called at ${DateTime.now().toIso8601String()}");
      // _history += _incorrect;
      databaseReference.collection('rotarySelection').document().setData({
        'expression':
            '${selection[0]} ${selection[1]} ${selection[2]} ${selection[3]}'
      });
    }
  }

  void _panHandler(DragUpdateDetails d) {
    /// Pan location on the wheel
    bool onTop = d.localPosition.dy <= radius;
    bool onLeftSide = d.localPosition.dx <= radius;
    bool onRightSide = !onLeftSide;
    bool onBottom = !onTop;

    /// Pan movements
    bool panUp = d.delta.dy <= 0.0;
    bool panLeft = d.delta.dx <= 0.0;
    bool panRight = !panLeft;
    bool panDown = !panUp;

    /// Absoulte change on axis
    double yChange = d.delta.dy.abs();
    double xChange = d.delta.dx.abs();

    /// Directional change on wheel
    double verticalRotation = (onRightSide && panDown) || (onLeftSide && panUp)
        ? yChange
        : yChange * -1;

    double horizontalRotation =
        (onTop && panRight) || (onBottom && panLeft) ? xChange : xChange * -1;

    // Total computed change
    double rotationalChange = verticalRotation + horizontalRotation;

    setState(() {
      display = "";
      _movement += rotationalChange;
      _rotationAngle = (radians(_movement) * 0.48);
    });
  }

  void _panEnd(DragEndDetails d) {
    _selection += _movementdx();
    setState(() {
      _movement = 0;
      _rotationAngle = 0.2;
    });
    _checkList(_selection, 24);
  }

  String _movementdx() {
    if (_movement < 150 && _movement > 20) {
      return "1";
    } else if (_movement >= 150 && _movement < 220) {
      return "2";
    } else if (_movement >= 220 && _movement < 260) {
      return "3";
    } else if (_movement >= 260 && _movement < 300) {
      return "4";
    } else if (_movement >= 300 && _movement < 410) {
      return "5";
    } else if (_movement >= 410 && _movement < 460) {
      return "6";
    } else if (_movement >= 460 && _movement < 500) {
      return "7";
    } else if (_movement >= 500 && _movement < 600) {
      return "8";
    } else if (_movement >= 600 && _movement < 700) {
      return "9";
    } else if (_movement >= 700 && _movement < 800) {
      return "0";
    }
    return null;
  }

  // ----------------------------- Widget Tree ----------------------------- //
  @override
  Widget build(BuildContext context) {
    // Construct rotary geometry
    Widget rotary = new Container(
      width: 350.0,
      height: 350.0,
      decoration: new BoxDecoration(
          color: Color.fromRGBO(42, 61, 81, 1), shape: BoxShape.circle),
    );

    return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Container(
            padding: EdgeInsets.only(left: 10),
            // Reset Button
            child: FloatingActionButton(
              heroTag: "reset",
              child: Icon(Icons.arrow_back),
              backgroundColor: Color.fromRGBO(138, 131, 222, 1),
              onPressed: () {
                setState(() {
                  _selection = "";
                  results = "";
                  // _history = [];
                  display = ""; // Also clear displayed results!
                  print(_selection);
                });
              },
              elevation: 0,
            ),
          ),
          actions: [
            Container(
              padding: EdgeInsets.only(right: 10),
              // History Button
              child: FloatingActionButton(
                heroTag: "history",
                child: Icon(Icons.history),
                elevation: 0,
                backgroundColor: Color.fromRGBO(138, 131, 222, 1),
                onPressed: () {
                  // Open history page and pass the results variable
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return History(); //------------- Use Firestore -------------//
                  }));
                },
              ),
            )
          ],
        ),
        body: Center(
          child: Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              // Draw rotary image and place numbers appropriately
              Align(
                child: rotary,
                alignment: Alignment.topCenter,
              ),
              Labels(),
              Positioned(
                  top: 45,
                  left: 55,
                  child: Transform.rotate(
                      angle: _rotationAngle,
                      child: GestureDetector(
                          onPanUpdate: _panHandler,
                          onPanEnd: _panEnd,
                          child: Container(
                              height: radius * 2,
                              width: radius * 2,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/rotaryWheel.png"))))))),
              Positioned(
                  top: 60,
                  left: 160,
                  child: Transform(
                      transform: Matrix4.rotationZ(pi * 0.1),
                      child: Container(
                          child: CustomPaint(painter: StopPosition())))),
              Positioned(
                top: 500,
                child: (display.isNotEmpty)
                    ? Row(
                        // children: _displaySelection() ?? [Container()], // This didn't work becuase the second call to _displaySelection was also submitting another item to Firestore
                        children: (display.length > 10) ? result : _incorrect,
                      )
                    : Container(
                        child: Text(
                        "${_movement.round()}",
                        style: TextStyle(color: Colors.white, fontSize: 32),
                      )),
              ),
              SizedBox(
                height: 200,
              ),
              Positioned(
                  top: 550,
                  child: Container(
                      child: Text(
                    (_movementdx() != null)
                        ? "${_movementdx()}"
                        : "Rotate the wheel",
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  )))
            ],
          ),
        ));
  }
}
