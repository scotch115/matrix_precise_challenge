// Written by Jordan Gamache © December, 2020
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'main.dart';

class History extends StatefulWidget {
  @override
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<Widget> results = [];
  final databaseReference = Firestore.instance;

  // --------------------------- Class Variables --------------------------- //

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  void getData() {
    databaseReference
        .collection('rotarySelection')
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((element) => print(
          '${element.data}')); // Once Firestore is properly configured, this will be updated to generate a WidgetList based on Firestore document data
    });
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Display history in chronological order
                    // Need to implement calls to Firestore, and method to filter passing and failing expressions to properly display each
                    Center(
                        child: Text(
                      "History",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                          color: Colors.white),
                    )),
                    Column(
                        // children: (widget.inputResults != null)
                        //     ? widget.inputResults
                        //     : [Container()],
                        // style: TextStyle(color: Colors.white, fontSize: 20),
                        )
                  ],
                ),
              ),
            )));
  }
}
