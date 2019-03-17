import 'package:flutter/material.dart';
import 'dart:core';


class StartPage extends StatelessWidget {


  final int streak;
  final Function getStreak;



  StartPage(this.streak,this.getStreak){
    getStreak();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Card(
          child: Column(
            children: <Widget>[
              Center(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: _streakBanner(streak),
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 30),
                child: _buildStreak(streak),
              ),
              Container(
                child: _streakAward(streak),
              ),
              _userEncouragement(streak)
            ],
          ),
        ),
        Container(
          height: 350,
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Let's cook!",
                  style: TextStyle(fontSize: 35, color: Colors.pink[300]),
                ),
              ),
              Flexible(
                  fit: FlexFit.tight,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: FlatButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/search");
                      },
                      child: Image.asset("assets/go.png"),
                    ),
                  )),
            ],
          ),
        )
      ],
    );
  }


Widget _userEncouragement(int streak) {
  if (streak >= 7) {
    return Text("You're a Platter Superstar!");
  }

  return Text("Keep it going");
}

Widget _streakBanner(int streak) {
  return Container(
    height: 50,
    child: Column(
      children: <Widget>[
        Text("Streak"),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(streak.toString()),
            Icon(
              Icons.flash_on,
              color: Colors.greenAccent,
            )
          ],
        )
      ],
    ),
  );
}

Widget _buildStreak(int streak) {
  Color _boxColor() {
    if (streak >= 1) {
      streak = (streak - 1);

      return Colors.greenAccent;
    }

    return Colors.white;
  }

  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Container(
        margin: EdgeInsets.all(5),
        height: 5,
        width: 25,
        child: DecoratedBox(
          decoration: BoxDecoration(
              border: Border.all(width: 0.5, color: Colors.grey),
              color: _boxColor(),
              borderRadius: BorderRadius.circular(5)),
        ),
      ),
      Container(
        margin: EdgeInsets.all(5),
        height: 5,
        width: 25,
        child: DecoratedBox(
          decoration: BoxDecoration(
              border: Border.all(width: 0.5, color: Colors.grey),
              color: _boxColor(),
              borderRadius: BorderRadius.circular(5)),
        ),
      ),
      Container(
        margin: EdgeInsets.all(5),
        height: 5,
        width: 25,
        child: DecoratedBox(
          decoration: BoxDecoration(
              border: Border.all(width: 0.5, color: Colors.grey),
              color: _boxColor(),
              borderRadius: BorderRadius.circular(5)),
        ),
      ),
      Container(
        margin: EdgeInsets.all(5),
        height: 5,
        width: 25,
        child: DecoratedBox(
          decoration: BoxDecoration(
              border: Border.all(width: 0.5, color: Colors.grey),
              color: _boxColor(),
              borderRadius: BorderRadius.circular(5)),
        ),
      ),
      Container(
        margin: EdgeInsets.all(5),
        height: 5,
        width: 25,
        child: DecoratedBox(
          decoration: BoxDecoration(
              border: Border.all(width: 0.5, color: Colors.grey),
              color: _boxColor(),
              borderRadius: BorderRadius.circular(5)),
        ),
      ),
      Container(
        margin: EdgeInsets.all(5),
        height: 5,
        width: 25,
        child: DecoratedBox(
          decoration: BoxDecoration(
              border: Border.all(width: 0.5, color: Colors.grey),
              color: _boxColor(),
              borderRadius: BorderRadius.circular(5)),
        ),
      ),
      Container(
        margin: EdgeInsets.all(5),
        height: 5,
        width: 25,
        child: DecoratedBox(
          decoration: BoxDecoration(
              border: Border.all(width: 0.5, color: Colors.grey),
              color: _boxColor(),
              borderRadius: BorderRadius.circular(5)),
        ),
      )
    ],
  );
}

Widget _streakAward(int streak) {
  if (streak >= 7) {
    return Icon(
      Icons.star,
      color: Colors.yellow,
    );
  }
  return SizedBox();
}}
