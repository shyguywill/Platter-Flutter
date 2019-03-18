import 'package:flutter/material.dart';

import "./View/start_page.dart";

class Home extends StatelessWidget {
  final List myMeals;

  final Function load;

  final Function delete;

  final int userStreak;

  final Function displayStreak;

  Home(this.myMeals, this.load, this.delete, this.userStreak,
      this.displayStreak);

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
      body: StartPage(userStreak, displayStreak, myMeals, load, delete),
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
              Navigator.pushNamed(context, "/search");
            },
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
