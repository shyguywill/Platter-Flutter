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
    
    return Scaffold(
        appBar: AppBar(
          title: Text('platter'),
        ),
        body: Container(
            padding: EdgeInsets.all(10),
            child: Center(child: SingleChildScrollView(child: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(hintText: "E-mail",filled: true, fillColor: Colors.white),
                  onChanged: (value) {},
                ),
                
                TextField(
                  decoration: InputDecoration(hintText: "Confirm E-mail",filled: true, fillColor: Colors.white),
                  onChanged: (value) {},
                ),SizedBox(
                  height: 10.0,
                ),
                TextField(
                  decoration: InputDecoration(hintText: "Password",filled: true, fillColor: Colors.white),
                  onChanged: (value) {},
                ),
                SizedBox(height: 10.0),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        child: Text("Sign up"),
                        color: Colors.greenAccent,
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, "/");
                        },
                      ),
                    )
                  ],
                ),
              ],))
            )));
  }



}