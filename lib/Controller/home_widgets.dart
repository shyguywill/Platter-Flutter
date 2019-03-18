import 'package:flutter/material.dart';



Widget userEncouragement(int streak) {
    if (streak >= 7) {
      return Text("You're a Platter Superstar!");
    }

    return Text("Keep it going");
  }

  Widget streakBanner(int streak) {
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

  Widget buildStreak(int streak) {
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

  Widget streakAward(int streak) {
    if (streak >= 7) {
      return Icon(
        Icons.star,
        color: Colors.yellow,
      );
    }
    return SizedBox();
  }

