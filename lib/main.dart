// Written by Jordan Gamache © December, 2020
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_spinning_wheel/flutter_spinning_wheel.dart';
import 'Labels.dart';
import 'history.dart';

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
  // Initialize empty string variables
  String _selection = "", display = "", results = "";
  int counter = 0; // Counter to determine if number of results have changed

  // --------------------------- Class Variables --------------------------- //

  // Computational algorithm -- check each digit in selection and test for all potential expressions to equal target (24)
  void check(
      double sum, double previous, String digits, double target, String expr) {
    counter = results.length; // Set counter to current length of results
    // stop if EOL
    if (digits.length == 0) {
      // If the current number being tested (sum) + the last number equals the target number, add the expression to results
      if (sum + previous == target) {
        print("$expr = $target");
        // remove repetitive recursive checks from computed results
        if (!expr.contains("24")) {
          // Only save one version (duplicates due to associative property sometimes occur)
          if (!results.contains("$expr = $target \n")) {
            results += "$expr = $target \n";
          }
        }
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

    if (counter != results.length) {
      print("green bubbles");
    } else {
      print("red bubbles");
    }
  }

  _checkList(String selection, double target) {
    print("Current selection: $selection");
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
        _displaySelection();
      }

      // After algorithm has been processed, clear the storage variable and reload scaffold
      setState(() {
        _selection = "";
        print(_selection);
      });
    } else {
      return;
    }
  }

  // ignore: missing_return
  List<Widget> _displaySelection() {
    List<Widget> result = [];
    if (results.isNotEmpty) {
      /* In theory, the following code would be used to return the UI-specific results (red if wrong and colorful if correct) */
      for (int i = 0; i < results.length; i++) {
        if (results[i] != " ") {
          var str = results[i].split('.');
          str[0].runes.forEach((element) {
            if (String.fromCharCode(element) != "0")
              display += new String.fromCharCode(element);
          });
        }
      }
      result.add(Row(children: [
        Container(
            width: 50,
            height: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.black54,
                  blurRadius: 15.0,
                  offset: Offset(0.0, 0.75))
            ], shape: BoxShape.circle, color: Color.fromRGBO(125, 202, 160, 1)),
            child: Text(
              (display != null) ? display[0] : "null",
              style: TextStyle(color: Colors.white, fontSize: 32),
            )),
        Text(
          display[1],
          style: TextStyle(color: Colors.white, fontSize: 32),
        ),
        Container(
            width: 50,
            height: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.black54,
                  blurRadius: 15.0,
                  offset: Offset(0.0, 0.75))
            ], shape: BoxShape.circle, color: Color.fromRGBO(125, 202, 160, 1)),
            child: Text(
              display[2],
              style: TextStyle(color: Colors.white, fontSize: 32),
            )),
        Text(
          display[3],
          style: TextStyle(color: Colors.white, fontSize: 32),
        ),
        Container(
            width: 50,
            height: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.black54,
                  blurRadius: 15.0,
                  offset: Offset(0.0, 0.75))
            ], shape: BoxShape.circle, color: Color.fromRGBO(96, 136, 175, 1)),
            child: Text(display[4],
                style: TextStyle(color: Colors.white, fontSize: 32))),
        Text(
          display[5],
          style: TextStyle(color: Colors.white, fontSize: 32),
        ),
        Container(
            width: 50,
            height: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.black54,
                  blurRadius: 15.0,
                  offset: Offset(0.0, 0.75))
            ], shape: BoxShape.circle, color: Color.fromRGBO(96, 136, 175, 1)),
            child: Text(display[6],
                style: TextStyle(color: Colors.white, fontSize: 32))),
        Text(
          display[7],
          style: TextStyle(color: Colors.white, fontSize: 32),
        ),
        Container(
            width: 50,
            height: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.black54,
                  blurRadius: 15.0,
                  offset: Offset(0.0, 0.75))
            ], shape: BoxShape.circle, color: Color.fromRGBO(96, 136, 175, 1)),
            child:
                Text("24", style: TextStyle(color: Colors.white, fontSize: 32)))
      ]));
      return result;
    }
  }

  final StreamController _dividerController = StreamController<int>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _dividerController.close();
    print("Divider Stream Controller closed");
  }

  int labels(dynamic selection) {
    Map<int, int> numbers = {
      1: 8,
      2: 9,
      3: 0,
      4: 1,
      5: 2,
      6: 3,
      7: 4,
      8: 5,
      9: 6,
      10: 7
    };

    return numbers[selection];
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
                    return History(_displaySelection());
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
                top: 35,
                left: 25,
                child: Transform(
                  // angle: 90,
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(3),
                  child: SpinningWheel(
                    Image.asset("assets/rotaryWheel.png"),
                    width: 300,
                    height: 300,
                    dividers: 10,
                    initialSpinAngle: 0,
                    spinResistance: 0.8,
                    onEnd: _dividerController.add,
                    onUpdate: _dividerController.add,
                  ),
                ),
              ),
              Positioned(
                  top: 365,
                  child: StreamBuilder(
                    stream: _dividerController.stream,
                    builder: (context, snapshot) => snapshot.hasData
                        ? MaterialButton(
                            child: Text("${labels(snapshot.data)}",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 32)),
                            onPressed: () => {
                                  _selection +=
                                      labels(snapshot.data).toString(),
                                  _checkList(_selection, 24)
                                })
                        : Container(),
                  )),
              Positioned(
                top: 500,
                child: (display.isNotEmpty)
                    ? Row(
                        children: (_displaySelection() != null)
                            ? _displaySelection()
                            : [Container()],
                      )
                    : Container(),
              )
            ],
          ),
        ));
  }
}
