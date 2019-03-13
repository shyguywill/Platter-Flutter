import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:progress_hud/progress_hud.dart';

import '../View/recipe_ingredients.dart';
import './pantry_list_table.dart';

class RecipeTable extends StatefulWidget {
  final String _finalURL;

  RecipeTable(this._finalURL);

  @override
  State<StatefulWidget> createState() {
    return _RecipeTable();
  }
}

class _RecipeTable extends State<RecipeTable> {
  ProgressHUD _progressHUD;
  List data;
  String finalUrl;

  @override
  void initState() {
    super.initState();

    print("initstate");

    finalUrl = widget._finalURL; //recieve URL

    getData(); //start networking

    _progressHUD = new ProgressHUD(
      backgroundColor: Colors.black12,
      color: Colors.white,
      containerColor: Colors.green,
      borderRadius: 5.0,
      //text: 'Finding tasty meals',
    );
  }

  String difference(List ingredientList) {
    var listCount = ingredientList.length;
    String stringedList = ingredientList.join(" ");

    var parameters = IngredientTable.selectedItem;

    for (String item in parameters) {
      if (stringedList.toLowerCase().contains(item.toLowerCase())) {
        listCount -= 1;
      }
    }

    if (listCount < 0) {
      listCount = 0;
    }

    if (listCount == 1){
      return "1 ingredient needed";
    }

    return "$listCount ingredients needed";
  }

  void getData() async {
    //Network
    print("Setting getting data");
    var res = await http
        .get(Uri.encodeFull(finalUrl), headers: {"Accept": "application/json"});

    //Parse Json
    setState(() {
      print("Setting state");
      var resBody = json.decode(res.body);
      data = resBody["hits"];
      print("This is data lenght ${data.length}");
      if (data.length < 3) {
        print("else");
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Uh oh"),
                content: Text(
                    "Please try a different combination of, or less, ingredients"),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Got it"),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                  )
                ],
              );
            });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      print("if");
      return Scaffold(
        body: Stack(
          children: <Widget>[
            _progressHUD,
            Align(
                alignment: Alignment.bottomCenter,
                child: Text("Finding something tasty"))
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (BuildContext context, int row) {

        double calories = (data[row]["recipe"]["calories"])/(data[row]["recipe"]["yield"]);
        int calorieCount = calories.toInt();

        print("building list");

        return Container(
          height: 150,
          margin: EdgeInsets.all(5),
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Container(
                  child: ListTile(
                    onTap: () {
                      List details = [
                        data[row]["recipe"]["label"],
                        data[row]["recipe"]["image"],
                        data[row]["recipe"]["source"],
                        data[row]["recipe"]["url"],
                      ];
                      List ingredients = data[row]["recipe"]["ingredientLines"];

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  RecipeIngredeints(details, ingredients)));

                      //print(details);
                      //print(ingredients);
                    },
                  ),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.3),
                            BlendMode
                                .darken), //Assign image asvdecoration, allowing for cropping
                        image: NetworkImage(
                          data[row]["recipe"]["image"],
                        ),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  data[row]["recipe"]["label"],
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Text("Calories:$calorieCount",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: "Futura",
                        fontWeight: FontWeight.w400)),
              ),
              Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    difference(data[row]["recipe"]["ingredientLines"]),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontFamily: "Futura",
                      fontWeight: FontWeight.w400,
                    ),
                  ))
            ],
          ),
        );
      },
    );
  }
}
