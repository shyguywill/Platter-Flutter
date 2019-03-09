import 'package:flutter/material.dart';




class AddItems extends StatefulWidget{

  final Function _addItem;


  AddItems(this._addItem);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AddItems();
  }
}

class _AddItems extends State<AddItems>{


  @override
  Widget build(BuildContext context) {
    
    return FloatingActionButton(
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
      );
  }
}