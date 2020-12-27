// Written by Jordan Gamache © December, 2020
import 'package:flutter/material.dart';
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
          child: MyHomePage()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Initialize empty string variables
  String _selection = "", display = "", results = "";

  // --------------------------- Class Variables --------------------------- //

  // Computational algorithm -- check each digit in selection and test for all potential expressions to equal target (24)
  void check(
      double sum, double previous, String digits, double target, String expr) {
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
  }

  _checkList(String selection, double target) {
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
    if (results != " ") {
      result.add(Text(
        results,
        style: TextStyle(color: Colors.white, fontSize: 24),
      ));
      /* In theory, the following code would be used to return the UI-specific results (red if wrong and colorful if correct) */
      // for (int i = 0; i < results.length; i++) {
      // if (results[i] != " ") {
      //   display += results[i];
      //   result.add(Container(
      //     child: Text(
      //       results[i],
      //       style: TextStyle(color: Colors.white, fontSize: 20),
      //     ),
      //     decoration:
      //         BoxDecoration(color: Colors.black, shape: BoxShape.circle),
      //     width: 20,
      //     alignment: Alignment.center,
      //   ));
      // }
      // if (results[i] == "*" ||
      //     results[i] == "+" ||
      //     results[i] == "-" ||
      //     results[i] == "/") {}
      // }
      return result;
    }
  }

  // ----------------------------- Widget Tree ----------------------------- //
  @override
  Widget build(BuildContext context) {
    // Construct rotary geometry
    Widget rotary = new Container(
      width: 300.0,
      height: 300.0,
      decoration:
          new BoxDecoration(color: Colors.white, shape: BoxShape.circle),
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
                  results = ""; // Also clear displayed results!
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
                    return History(results);
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
              Positioned(child: rotary, top: 20),
              Positioned(
                top: 70,
                left: 250,
                child: FloatingActionButton(
                  child: Text("1"),
                  elevation: 0,
                  backgroundColor: Color.fromRGBO(42, 61, 81, 1),
                  heroTag: null,
                  onPressed: () => {
                    _selection += "1",
                    _checkList(_selection, 24),
                    print(_selection)
                  },
                ),
              ),
              Positioned(
                top: 32,
                left: 195,
                child: FloatingActionButton(
                  child: Text("2"),
                  elevation: 0,
                  backgroundColor: Color.fromRGBO(42, 61, 81, 1),
                  heroTag: null,
                  onPressed: () => {
                    _selection += "2",
                    _checkList(_selection, 24),
                    print(_selection)
                  },
                ),
              ),
              Positioned(
                top: 25,
                left: 130,
                child: FloatingActionButton(
                  child: Text("3"),
                  elevation: 0,
                  backgroundColor: Color.fromRGBO(42, 61, 81, 1),
                  heroTag: null,
                  onPressed: () => {
                    _selection += "3",
                    _checkList(_selection, 24),
                    print(_selection)
                  },
                ),
              ),
              Positioned(
                top: 60,
                left: 80,
                child: FloatingActionButton(
                  child: Text("4"),
                  elevation: 0,
                  backgroundColor: Color.fromRGBO(42, 61, 81, 1),
                  heroTag: null,
                  onPressed: () => {
                    _selection += "4",
                    _checkList(_selection, 24),
                    print(_selection)
                  },
                ),
              ),
              Positioned(
                top: 110,
                left: 45,
                child: FloatingActionButton(
                  child: Text("5"),
                  elevation: 0,
                  backgroundColor: Color.fromRGBO(42, 61, 81, 1),
                  heroTag: null,
                  onPressed: () => {
                    _selection += "5",
                    _checkList(_selection, 24),
                    print(_selection)
                  },
                ),
              ),
              Positioned(
                top: 170,
                left: 45,
                child: FloatingActionButton(
                  child: Text("6"),
                  elevation: 0,
                  backgroundColor: Color.fromRGBO(42, 61, 81, 1),
                  heroTag: null,
                  onPressed: () => {
                    _selection += "6",
                    _checkList(_selection, 24),
                    print(_selection)
                  },
                ),
              ),
              Positioned(
                top: 220,
                left: 75,
                child: FloatingActionButton(
                  child: Text("7"),
                  elevation: 0,
                  backgroundColor: Color.fromRGBO(42, 61, 81, 1),
                  heroTag: null,
                  onPressed: () => {
                    _selection += "7",
                    _checkList(_selection, 24),
                    print(_selection)
                  },
                ),
              ),
              Positioned(
                top: 255,
                left: 125,
                child: FloatingActionButton(
                  child: Text("8"),
                  elevation: 0,
                  backgroundColor: Color.fromRGBO(42, 61, 81, 1),
                  heroTag: null,
                  onPressed: () => {
                    _selection += "8",
                    _checkList(_selection, 24),
                    print(_selection)
                  },
                ),
              ),
              Positioned(
                top: 255,
                left: 190,
                child: FloatingActionButton(
                  child: Text("9"),
                  elevation: 0,
                  backgroundColor: Color.fromRGBO(42, 61, 81, 1),
                  heroTag: null,
                  onPressed: () => {
                    _selection += "9",
                    _checkList(_selection, 24),
                    print(_selection)
                  },
                ),
              ),
              Positioned(
                top: 220,
                left: 240,
                child: FloatingActionButton(
                    child: Text("0"),
                    elevation: 0,
                    backgroundColor: Color.fromRGBO(42, 61, 81, 1),
                    heroTag: null,
                    onPressed: () => {
                          _selection += "0",
                          _checkList(_selection, 24),
                          print(_selection)
                        }),
              ),
              Positioned(
                  top: 400,
                  child: Row(children: _displaySelection() ?? [Container()])),
            ],
          ),
        ));
  }
}
