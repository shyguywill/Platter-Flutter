import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:progress_hud/progress_hud.dart';

import '../View/recipe_ingredients.dart';
import '../Model/sort_list.dart';
import '../Model/ingredients.dart';


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
  List<Recipes> ingredientArray = [];

  @override
  void initState() {
    super.initState();

    print("initstate");

    finalUrl = widget._finalURL; //recieve URL

    getData(); //start networking

    _progressHUD = new ProgressHUD(
      backgroundColor: Colors.black12,
      color: Colors.white,
      containerColor: Colors.greenAccent,
      borderRadius: 10.0,
      //text: 'Finding tasty meals',
    );
  }

  String ingredientLabel(int number) {
    if (number == 1) {
      return "1 ingredient needed";
    }

    return "$number ingredients needed";
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

      collectItems();

      ingredientArray.sort((a, b) =>
          a.ingredients.difference().compareTo(b.ingredients.difference()));

      print("This is data lenght ${data.length}");

      if (data.length < 1) {
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
                child: Text("Finding something tasty..."))
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (BuildContext context, int row) {
        
        int calorieCount = ingredientArray[row].calories; 

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
                        ingredientArray[row].label,
                        ingredientArray[row].image,
                        ingredientArray[row].source,
                        ingredientArray[row].url,
                      ];
                      List ingredients = ingredientArray[row].ingredients;

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  RecipeIngredeints(details, ingredients)));

                      print(details);
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
                          ingredientArray[row].image,
                        ),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  ingredientArray[row].label,
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
                    ingredientLabel(
                        ingredientArray[row].ingredients.difference()),
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

  void collectItems() {
    SortList<Recipes> recipeHold = SortList();

    print("got the recipe data");

    for (var meal = 0; meal < data.length; meal++) {
      var recipes = Recipes();

      var food = data[meal]["recipe"];

      recipes.label = food["label"];
      recipes.image = food["image"];
      recipes.source = food["source"];
      recipes.url = food["url"];

      double amount = food["yield"];
      double totalCalories = food["calories"];

      recipes.calories = (totalCalories ~/ amount);

      List recipeLists = food["ingredientLines"];

      for (var item in recipeLists) {
        recipes.ingredients.add(item);
      }

      recipeHold.add(recipes);
    }

    ingredientArray = recipeHold;

    print("got everything");
  }
}
