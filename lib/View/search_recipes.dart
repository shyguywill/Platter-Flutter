import 'package:flutter/material.dart';

class SearchRecipes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.only(top: 10.0,left: 5.0,right: 5.0),
      child: Column(children: <Widget>[
      Card(
        child: Column(
          children: <Widget>[
            Text("Search new recipes for meals you love"),
            SizedBox(
        height: 30.0,
      ),
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.green[100],
              ),
            ),
            SizedBox(
        height: 30.0,
      ),
      FlatButton(
        child: Text("Search"),
        onPressed: (){},
      ),
            
            SizedBox(
        height: 30.0,
      ),
          ],
        ),
      ),
    ]));
  }
}
