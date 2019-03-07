import 'package:flutter/material.dart';

class IngredientTable extends StatefulWidget {
  final List<Map> _ingredientlist;
  final Function deleteItem;

  IngredientTable(this._ingredientlist, this.deleteItem);

  static List selectedItem;

  @override
  State<StatefulWidget> createState() {
    return _IngredientTable();
  }
}

class _IngredientTable extends State<IngredientTable> {

  


  @override
  Widget build(BuildContext context) {
    IngredientTable.selectedItem = [];
    List ingredientArray = [];

    for (var i in widget._ingredientlist) { //Create List of selected ingredients 
      if (i["Selected"] == true) {

        ingredientArray.add(i["Ingredient"]);


        IngredientTable.selectedItem = ingredientArray;

        print(ingredientArray);
      }
    }

    return ListView.separated(
      separatorBuilder: (context, index) => Divider(
            color: Colors.black,
          ),
      itemBuilder: (BuildContext context, int row) {
        return ListTile(
          onTap: () {},
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              setState(() {
                widget.deleteItem(row);
              });
            },
          ),
          leading: Checkbox(
            activeColor: Colors.green[200],
            value: widget._ingredientlist[row]["Selected"],
            onChanged: (bool value) {
              setState(() {
                widget._ingredientlist[row]["Selected"] = value;
              });
            },
          ),
          title: Text(widget._ingredientlist[row]["Ingredient"]),
        );
      },
      itemCount: widget._ingredientlist.length,
    );
  }
}
