import 'package:flutter/material.dart';

class Auth extends StatefulWidget{
@override
  State<StatefulWidget> createState() {
    
    return _Auth();
  }

}

class _Auth extends State<Auth>{

  @override
  Widget build(BuildContext context) {
    
    return Center(
      child: Text("Log in to share your own recipes with other Platter Users", textAlign: TextAlign.center,),
    );
  }



}