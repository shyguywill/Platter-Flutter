import 'package:flutter/material.dart';

class SearchRecipes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10),
        child: Column(children: <Widget>[
          Container(
            child: TextField(
              style: TextStyle(height: 0.7),
              decoration: InputDecoration(
                fillColor: Colors.white,
                border: 
                 OutlineInputBorder(
                  borderSide: BorderSide(
                    style: BorderStyle.solid,
                    width: 0.00
                  ),
                    borderRadius: BorderRadius.all(Radius.circular(35))),
                suffixIcon: Icon(
                  Icons.search,
                  color: Theme.of(context).accentColor,
                ),
                filled: true,
              ),
              onChanged: (value) {

              },
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Expanded(
              child: Card(
            child: Center(
              child: Text("Search for your favourite recipes"),
            ),
          ))
        ]));
  }
}
