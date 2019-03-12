import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import './home.dart';
import "./View/list_and_search.dart";



void main(){
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

    List<Map> ingredientMap = [];

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
  
  void addIngredient(String item) async{

    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> pantryItems = prefs.getStringList("Pantry") ?? [];

    Map ingredients = {"Ingredient": item, "Selected": false};

    var newItem =json.encode(ingredients);

    pantryItems.add(newItem);

    await prefs.setStringList("Pantry", pantryItems);

    

    print (pantryItems);

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
        "/": (context) => Home(),
        "/search": (context) =>
            SearchList(addIngredient, deleteIngredient,loadIngredients,ingredientMap)
      },
    );
  }
}
