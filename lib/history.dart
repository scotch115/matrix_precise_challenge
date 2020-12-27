// Written by Jordan Gamache © December, 2020
import 'package:flutter/material.dart';

class History extends StatefulWidget {
  final String inputResults;
  History(this.inputResults);

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  String results;

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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        // Draw background image
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/background.png"), fit: BoxFit.cover)),
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
            Center(
              child: Text(
                widget.inputResults ?? "Nothing has been run yet",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            )
          ],
        ),
      ),
    );
  }
}
