import 'package:flutter/material.dart';

import "./View/start_page.dart";

class Home extends StatefulWidget {
  final List myMeals;

  final Function load;

  final Function delete;

  final int userStreak;

  final Function displayStreak;

  Home(this.myMeals, this.load, this.delete, this.userStreak,
      this.displayStreak);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Home();
  }
}

class _Home extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).accentColor),
        title: Text(
          "platter",
          style: TextStyle(color: Theme.of(context).accentColor),
        ),
      ),
      body: StartPage(widget.userStreak, widget.displayStreak, widget.myMeals,
          widget.load, widget.delete),
      floatingActionButton: Container(
          width: 200.0,
          height: 50.0,
          child: RawMaterialButton(
            child: Text(
              "Let's cook !",
              style: TextStyle(color: Colors.white),
            ),
            fillColor: Colors.greenAccent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            elevation: 5.0,
            onPressed: () {
              Navigator.pushNamed(context, "/search").then((value) {

                widget.load(key: 1);
              });
            },
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
