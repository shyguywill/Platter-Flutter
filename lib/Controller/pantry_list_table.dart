import 'package:flutter/material.dart';

class IngredientTable extends StatefulWidget {
  final List<Map> _ingredientlist;
 
  

  IngredientTable(this._ingredientlist);

  @override
  State<StatefulWidget> createState() {
   
    return _IngredientTable();
  }
}

class _IngredientTable extends State<IngredientTable> {
  bool checkBoxValue = false;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(
        color: Colors.black,
      ),
      itemBuilder: (BuildContext context, int row) {
        return ListTile(
          onTap: () {},
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
