import 'package:flutter/material.dart';
import 'dart:core';

import '../Controller/home_widgets.dart';
import './auth.dart';
import "./my_recipes.dart";

class StartPage extends StatelessWidget {
  final int streak;
  final Function getStreak;

  final List myMeals;
  final Function load;
  final Function delete;

  StartPage(this.streak, this.getStreak, this.myMeals, this.load, this.delete);

 
  @override
  Widget build(BuildContext context) {
    print("Start build");

    load();

    getStreak();

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets/logoNoBackground.png")
        )
      ),
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
                      child: streakBanner(streak),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 30),
                    child: buildStreak(streak),
                  ),
                  Container(
                    child: streakAward(streak),
                  ),
                  userEncouragement(streak)
                ],
              ),
            ),
            Card(
              elevation: 15,
              child: ListTile(
                leading: Icon(
                  Icons.account_circle,
                  color: Colors.pinkAccent,
                ),
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
                  height: myMeals.isNotEmpty
                      ? (300 + (myMeals.length.toDouble() * 10 ?? 0))
                      : 200,
                  child: MyRecipes(myMeals, load, delete)),
            )
          ],
        ));
  }
}
