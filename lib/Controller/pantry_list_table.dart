import 'package:flutter/material.dart';
import '../secrets.dart';
import '../View/recipe_list.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class IngredientTable extends StatefulWidget {
  final Function deleteItem;
  final Function loadIngredients;
  final List<Map> ingredientMap;

  IngredientTable(this.deleteItem,this.loadIngredients,this.ingredientMap);

  static List selectedItem;

  @override
  State<StatefulWidget> createState() {
    return _IngredientTable();
  }
}

class _IngredientTable extends State<IngredientTable> {
 
  
  @override
  void initState() {
    
    super.initState();

    print("Init state built");

    widget.loadIngredients();
  }

  void updateIngredients(item) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setStringList("Pantry", item);
    widget.loadIngredients();
  }

  @override
  Widget build(BuildContext context) {
    IngredientTable.selectedItem = [];
    List ingredientArray = [];

    

    for (var i in widget.ingredientMap) {
      //Create List of selected ingredients
      if (i["Selected"] == true) {
        ingredientArray.add(i["Ingredient"]);

        IngredientTable.selectedItem = ingredientArray;

        print("This is $ingredientArray");
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
                      widget.loadIngredients();
                    });
                  },
                ),
                leading: Checkbox(
                  activeColor: Colors.green[200],
                  value: widget.ingredientMap[row]["Selected"],
                  onChanged: (bool value) {
                    widget.ingredientMap[row]["Selected"] = value;

                    setState(() {
                      List<String> newItem = [];
                      for (var item in widget.ingredientMap) {
                        newItem.add(json.encode(item));
                      }
                      updateIngredients(newItem);
                    });
                  },
                ),
                title: Text(widget.ingredientMap[row]["Ingredient"]),
              );
            },
            itemCount: widget.ingredientMap.length,
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
