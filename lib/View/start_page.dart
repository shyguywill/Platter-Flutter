import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      children: <Widget>[
        Card(
          child: Column(
            children: <Widget>[
              Center(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                  child: Text("Your Streak"),
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 30),
                child: _buildStreak(5),
              ),
              Text("You're a Platter Superstar!")
            ],
          ),
        ),
        Container(
            child: Card(
              child:Column(children: <Widget>[
                 
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "Let's cook",
                            style: TextStyle(
                                fontFamily: "Futura",
                                fontSize: 35,
                                color: Colors.pink[300]),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          height: 300,
                          width: 300,
                          child: FlatButton(
                            onPressed: () {
                              Navigator.pushNamed(context, "/search");
                            },
                            child: Image.asset("assets/go.png"),
                          ),
                        ),
                      ],
                    ),
            ))
      ],
    );
  }
}

Widget _buildStreak(int streak) {
  
  var streakNumber = streak;

  Color _boxColor() {
    
    if (streakNumber >= 1) {
      
      streakNumber = (streakNumber - 1);

      return Colors.green;
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
              border: Border.all(width: 0.5),
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
              border: Border.all(width: 0.5),
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
              border: Border.all(width: 0.5),
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
              border: Border.all(width: 0.5),
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
              border: Border.all(width: 0.5),
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
              border: Border.all(width: 0.5),
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
              border: Border.all(width: 0.5),
              color: _boxColor(),
              borderRadius: BorderRadius.circular(5)),
        ),
      )
    ],
  );
}
