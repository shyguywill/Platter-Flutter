import 'package:flutter/material.dart';
import '../secrets.dart';
import '../View/recipe_list.dart';

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

    for (var i in widget._ingredientlist) {
      //Create List of selected ingredients
      if (i["Selected"] == true) {
        ingredientArray.add(i["Ingredient"]);

        IngredientTable.selectedItem = ingredientArray;

        print(ingredientArray);
      }
    }

    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
              //height: 400,

              child: ListView.separated(
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
          )),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          width: 120.0,
          height: 70.0,
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
        )
      ],
    );
  }
}
