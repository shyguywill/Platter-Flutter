import 'package:flutter/material.dart';

import '../Controller/pantry_list_table.dart';

class Pantry extends StatefulWidget {
  final List<Map> ingredients;
  final Function _addItem;
  final Function _deleteItem;

  Pantry(this.ingredients, this._addItem, this._deleteItem);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Pantry();
  }
}

class _Pantry extends State<Pantry> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IngredientTable(widget.ingredients, widget._deleteItem),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          String newIngredient;
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Add an item to your Pantry"),
                  content: TextField(
                    onChanged: (item) {
                      newIngredient = item;
                    },
                    onSubmitted: (item) {
                      setState(() {
                        widget._addItem(item);
                      });
                    },
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("Cancel"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    FlatButton(
                      child: Text("Add item"),
                      onPressed: () {
                        setState(() {
                          if (newIngredient.isNotEmpty) {
                            widget._addItem(newIngredient);
                            Navigator.pop(context);
                          }
                        });
                      },
                    )
                  ],
                );
              });
        },
      ),

      //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat
    );
  }
}
