// Written by Jordan Gamache © December, 2020
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'main.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<Widget> results = [];
  final databaseReference = Firestore.instance;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getData();
      setState(() {});
    });
  }
  // --------------------------- Class Variables --------------------------- //

  Future<void> _getData() async {
    databaseReference
        .collection('rotarySelection')
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((element) {
        String input =
            element.data.values.toString().replaceAll(new RegExp(r"\s+"), "");
        print(input);
        if (input.length > 10) {
          results.add(Column(children: [
            SizedBox(height: 30),
            Container(
              child: (input.length > 10)
                  ? Text(
                      "🎉",
                      style: TextStyle(fontSize: 45),
                    )
                  : Text(
                      "🗑",
                      style: TextStyle(fontSize: 45),
                    ),
            ),
            Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                        (input != null) ? input[1] : "null",
                        style: TextStyle(color: Colors.white, fontSize: 32),
                      )),
                  Text(
                    input[2],
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
                        input[3],
                        style: TextStyle(color: Colors.white, fontSize: 32),
                      )),
                  Text(
                    input[4],
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
                      child: Text(input[5],
                          style: TextStyle(color: Colors.white, fontSize: 32))),
                  Text(
                    input[6],
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
                      child: Text(input[7],
                          style: TextStyle(color: Colors.white, fontSize: 32)))
                ]),
            Container(
              child: Text("______________________",
                  style: TextStyle(color: Colors.white, fontSize: 32)),
            ),
            Container(
                child: Text("24",
                    style: TextStyle(color: Colors.white, fontSize: 32)))
          ]));
        } else {
          results.add(Column(children: [
            SizedBox(height: 30),
            Container(
              child: (input.length > 10)
                  ? Text(
                      "🎉",
                      style: TextStyle(fontSize: 45),
                    )
                  : Text(
                      "🗑",
                      style: TextStyle(fontSize: 45),
                    ),
            ),
            Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
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
                        input[1],
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
                        input[2],
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
                      child: Text(input[3],
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
                      child: Text(input[4],
                          style: TextStyle(color: Colors.white, fontSize: 32))),
                ])
          ]));
        }
      });
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
                          onPressed: () {
                            Navigator.pop(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => new Rotary()));
                          })),
                ),
                backgroundColor: Colors.transparent,
                body: StreamBuilder(
                  stream: Firestore.instance
                      .collection('rotarySelection')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return CircularProgressIndicator(
                        value: snapshot.connectionState.index.toDouble(),
                      );
                    }
                    return ListView(children: [
                      Center(
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
                            Column(children: results)
                          ],
                        ),
                      )
                    ]);
                  },
                ))));
  }
}
