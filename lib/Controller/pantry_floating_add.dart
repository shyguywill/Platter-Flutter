import 'package:flutter/material.dart';

class AddItems extends StatefulWidget {
  final Function _addItem;
  final Function _loadItems;

  AddItems(this._addItem, this._loadItems);

  @override
  State<StatefulWidget> createState() {
   
    return _AddItems();
  }
}

class _AddItems extends State<AddItems> {
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
                title: Text("Add an item to your pantry"),
                content: TextField(
                  autofocus: true,
                  autocorrect: true,
                  textInputAction: TextInputAction.done,
                  textCapitalization: TextCapitalization.sentences,
                  onChanged: (item) {
                    newIngredient = item;
                  },
                  onSubmitted: (item) {
                    setState(() {
                      widget._addItem(item);
                      widget._loadItems();
                      Navigator.pop(context);
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
                        if (newIngredient !=null) {
                          widget._addItem(newIngredient);
                          widget._loadItems();
                          Navigator.pop(context);
                        }else{
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
