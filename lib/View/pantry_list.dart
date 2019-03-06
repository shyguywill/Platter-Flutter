import 'package:flutter/material.dart';

import '../Controller/pantry_list_controller.dart';

class Pantry extends StatelessWidget {
  final List<Map> ingredients;

  Pantry(this.ingredients);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            iconSize: 35,
            onPressed: (){},
            icon: Icon(Icons.add_circle,
            color: Colors.indigo[900],
            ),
          )
        ],
        title: Text(
          "Pantry",
          style: TextStyle(color: Theme.of(context).accentColor),
        ),
      ),
      body: IngredientTable(ingredients),
      floatingActionButton: Container(
                width: 120.0,
                height: 50.0,
                child: RawMaterialButton(
                  fillColor: Colors.pinkAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  elevation: 5.0,
                  child: Text(
                    "Platter Me",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {},
                )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
