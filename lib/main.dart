import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import './home.dart';
import "./View/list_and_search.dart";
import './View/meal_page.dart';

void main() {
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp]) //Lock orientation to portrait
      .then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyApp();
  }
}

class _MyApp extends State<MyApp> {
  List<Map> savedMealMap = [];

  List<Map> ingredientMap = [];

  void saveMeal(Map meal) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> savedMeals = prefs.getStringList("MyMeals") ?? [];

    var newItem = json.encode(meal);

    savedMeals.add(newItem);

    await prefs.setStringList("MyMeals", savedMeals);

    print(savedMeals);
  }

  void deleteMeal(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> mealItems = prefs.getStringList("MyMeals") ?? [];

    mealItems.removeAt(index);

    await prefs.setStringList("MyMeals", mealItems);
  }

  void loadMeals() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List mealItems = prefs.getStringList("MyMeals");

    if (mealItems != null) {
      List<Map> newItems = [];

      for (var item in mealItems) {
        newItems.add(json.decode(item));
      }

      setState(() {
        savedMealMap = newItems;
      });
    }
  }

  void loadIngredients() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List pantryItems = prefs.getStringList("Pantry");

    if (pantryItems != null) {
      List<Map> newItems = [];

      for (var item in pantryItems) {
        newItems.add(json.decode(item));
      }

      setState(() {
        ingredientMap = newItems;
      });
    }
  }

  void addIngredient(String item) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> pantryItems = prefs.getStringList("Pantry") ?? [];

    Map ingredients = {"Ingredient": item, "Selected": true};

    var newItem = json.encode(ingredients);

    pantryItems.add(newItem);

    await prefs.setStringList("Pantry", pantryItems);

    print(pantryItems);
  }

  void deleteIngredient(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> pantryItems = prefs.getStringList("Pantry") ?? [];

    pantryItems.removeAt(index);

    await prefs.setStringList("Pantry", pantryItems);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //remove debug banner
      theme: ThemeData(
        fontFamily: "Futura",
        primaryColor: Colors.white,
        accentColor: Colors.indigo[900],
      ),
      routes: {
        "/": (context) => Home(savedMealMap, loadMeals, deleteMeal),
        "/search": (context) => SearchList(
            addIngredient, deleteIngredient, loadIngredients, ingredientMap)
      },
      onGenerateRoute: (RouteSettings settings) {
        List entry = settings.name.split("*");

        print(entry);

        if (entry[0] != "") {
          return null;
        }
        if (entry[1] == "mealpage") {
          return MaterialPageRoute(
              builder: (context) =>
                  MealPage(entry[2], entry[3], entry[4], saveMeal));
        }
      },
    );
  }
}
