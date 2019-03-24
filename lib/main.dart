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
  int streakNumber = 0;

  void displayStreak() async {
    streakCount();

    //SharedPreferences prefs = await SharedPreferences.getInstance();

    //streakNumber =  prefs.getInt("Streak") ?? 0;
  }

  void streakCount() async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();

    String lastLaunch = prefs1.getString("Launches");

    if (lastLaunch == null) {
      lastLaunch = DateTime.now().toString();

      await prefs1.setString("Launches", lastLaunch);
    }

    var time = DateTime.now();

    if (time.difference(DateTime.parse(lastLaunch)).inHours > 12 &&
        time.difference(DateTime.parse(lastLaunch)).inHours < (12* 4)) {
      //43200
      SharedPreferences pref = await SharedPreferences.getInstance();

      int streak = pref.getInt("Streak") ?? 1;

      int streak2 = streak + 1;

      print("This is your streak $streak2");

      await pref.setInt("Streak", streak2);

      await prefs1.setString("Launches", DateTime.now().toString());

      setState(() {
        streakNumber = streak + 1;
      });
    } else if (time.difference(DateTime.parse(lastLaunch)).inHours >
        (12 * 4)) {
      print("out of time range");
      await prefs1.setString("Launches", DateTime.now().toString());
      SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.setInt("Streak", 0);

      setState(() {
        streakNumber = 0;
      });
    }
    print(
        "This is the time differece:${time.difference(DateTime.parse(lastLaunch)).inSeconds}");

    print(lastLaunch);
  }

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

  void loadMeals({int key}) async {
    print("calling load");
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List mealItems = prefs.getStringList("MyMeals");

    if (mealItems != null) {
      print("meals isnt null");
      List<Map> newItems = [];

      for (var item in mealItems) {
        newItems.add(json.decode(item));
      }

      savedMealMap = newItems;

      if (key == 1) {
        setState(() {
          savedMealMap = newItems;
        });
      }
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
        "/": (context) => Home(
            savedMealMap, loadMeals, deleteMeal, streakNumber, displayStreak),
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
              builder: (context) => MealPage(
                    entry[2],
                    label: entry[4],
                    photo: entry[3],
                    saveMeal: saveMeal,
                  ));
        }
      },
    );
  }
}
