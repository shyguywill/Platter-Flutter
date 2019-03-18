import 'package:flutter/material.dart';
import 'dart:core';

import '../Controller/home_widgets.dart';
import './auth.dart';
import "./my_recipes.dart";

class StartPage extends StatefulWidget {
  final int streak;
  final Function getStreak;

  final List myMeals;
  final Function load;
  final Function delete;

  StartPage(this.streak, this.getStreak, this.myMeals, this.load, this.delete);

  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _StartPage();
  }
}

class _StartPage extends State<StartPage> {




 


  @override
  Widget build(BuildContext context) {

     widget.getStreak();
    

    widget.load();

    return Container(
      
        margin: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Card(
              
              elevation: 15,
              child: Column(
                children: <Widget>[
                  Center(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                      child: streakBanner(widget.streak),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 30),
                    child: buildStreak(widget.streak),
                  ),
                  Container(
                    child: streakAward(widget.streak),
                  ),
                  userEncouragement(widget.streak)
                ],
              ),
            ),
            Card(
              elevation: 15,
              child: ListTile(
                leading: Icon(Icons.account_circle,color: Colors.pinkAccent,),
                title: Text(
                  "Log in to share your own recipes with other Platter Users",
                  textAlign: TextAlign.center,
                ),
                trailing: IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Auth()));
                  },
                  icon: Icon(Icons.arrow_forward_ios),
                ),
              ),
            ),
            Card(
              elevation: 25,
              child: Container(
                  height: widget.myMeals.isNotEmpty ? (300 + (widget.myMeals.length.toDouble() * 10 ?? 0)) : 200,
                  child: MyRecipes(widget.myMeals, widget.load, widget.delete)),
            )
          ],
        ));
  }
}
