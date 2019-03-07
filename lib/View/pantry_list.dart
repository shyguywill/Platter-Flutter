import 'package:flutter/material.dart';

import '../Controller/pantry_list_table.dart';
import "../secrets.dart";
import './recipe_list.dart';

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
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            iconSize: 35,
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
            icon: Icon(
              Icons.add_circle,
              color: Colors.indigo[900],
            ),
          )
        ],
        title: Text(
          "Pantry",
          style: TextStyle(color: Theme.of(context).accentColor),
        ),
      ),
      body: IngredientTable(widget.ingredients, widget._deleteItem),
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
            onPressed: () {
              if (IngredientTable.selectedItem != null) {
                var items = IngredientTable.selectedItem
                    .join(",")
                    .replaceAll(" ", "%20");

                var url =
                    "${EdmAPI.baseURL + items}&app_id=${EdmAPI.appID}&app_key=${EdmAPI.appKey}&from=0&to=100";

                print(url);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => RecipePage(url),
                    ));
              }
            }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
