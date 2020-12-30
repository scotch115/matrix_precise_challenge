// Written by Jordan Gamache © December, 2020
import 'package:flutter/material.dart';

import 'main.dart';

class History extends StatefulWidget {
  final List<Widget> inputResults;
  History(this.inputResults);

  @override
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<Widget> results = [];

  // --------------------------- Class Variables --------------------------- //

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    results = widget.inputResults;
  }

  // ----------------------------- Widget Tree ----------------------------- //
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
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: Container(
                    padding: EdgeInsets.only(left: 10),
                    child: FloatingActionButton(
                      child: Text(
                        "X",
                        style: TextStyle(fontSize: 32),
                      ),
                      backgroundColor: Color.fromRGBO(138, 131, 222, 1),
                      onPressed: () => Navigator.of(context).pop(true),
                    )),
              ),
              backgroundColor: Colors.transparent,
              body: Container(
                // Draw background image
                // decoration: BoxDecoration(
                //     image: DecorationImage(
                //         image: AssetImage("assets/background.png"), fit: BoxFit.cover)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Display history in chronological order
                    Center(
                        child: Text(
                      "History",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                          color: Colors.white),
                    )),
                    Column(
                      children: (widget.inputResults != null)
                          ? widget.inputResults
                          : [Container()],
                      // style: TextStyle(color: Colors.white, fontSize: 20),
                    )
                  ],
                ),
              ),
            )));
  }
}
