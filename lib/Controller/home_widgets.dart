import 'package:flutter/material.dart';

Widget userEncouragement(int streak) {
  String message = "";

  if (streak == 0) {
    message = "Keep it going!";
  }

  if (streak == 1) {
    message = "Back to the Platter.";
  }

  if (streak == 2) {
    message = "Hello! Is it Platter you're looking for?";
  }

  if (streak == 3) {
    message = "Oh, I wanna Platter with somebody.";
  }

  if (streak == 4) {
    message = "Come with me if you want to Platter!";
  }

  if (streak == 5) {
    message = "Just your friendly neighborhood Platter-Man.";
  }
  if (streak == 6) {
    message = "R.I.P Stan Lee.";
  }

  if (streak >= 7) {
    message = "You're a Platter Superstar!";
  }

  return Container(
      padding: EdgeInsets.only(bottom: 5),
      child: Text(
        message,
        softWrap: true,
        textAlign: TextAlign.center,
        maxLines: 2,
      ));
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
