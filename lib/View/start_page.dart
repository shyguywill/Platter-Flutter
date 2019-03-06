import 'package:flutter/material.dart';


class StartPage extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      children: <Widget>[
        Center(child:
        Container(
          padding: EdgeInsets.symmetric(vertical: 50,horizontal: 30),
          child:
        Text("Let's cook!",
        style: TextStyle(
          fontSize: 40,
          color: Colors.pink[300],
          fontFamily: "Futura",
          fontWeight: FontWeight.w700,
        ),),),),
        FlatButton(
          onPressed: (){
            Navigator.pushNamed(context, "/pantry");
          },
          child: Image.asset("assets/go.png",
          scale: 1,),
        )
      ],
    );
  }
}