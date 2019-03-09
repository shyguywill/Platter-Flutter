import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import './home.dart';
import "./View/list_and_search.dart";



void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]) //Lock orientation to portrait
    .then((_) {
      runApp(new MyApp());
    });
}


class MyApp extends StatefulWidget{

@override
  State<StatefulWidget> createState() {
    
    return _MyApp();
  }

}

class _MyApp extends State<MyApp>{

   List<Map<String, Object>> pantryIngredients = [
    {"Ingredient": "Rice", "Selected": false},
    {"Ingredient": "Eggs", "Selected": false},
    {"Ingredient": "Chicken", "Selected": true}
  ];

   void addIngredient(String item){

     Map<String, Object> newItem = {"Ingredient": item, "Selected": false};
     pantryIngredients.add(newItem);
   }

   void deleteIngredient(int index){
     pantryIngredients.removeAt(index);
   }


@override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.white,
        accentColor: Colors.indigo[900],
      ), 
      routes: {
        "/":(context) => Home(),
        "/search":(context) => SearchList(pantryIngredients,addIngredient,deleteIngredient)
      },

    );
  }
}
