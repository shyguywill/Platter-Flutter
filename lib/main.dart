import 'package:flutter/material.dart';
import './home.dart';

import './View/pantry_list.dart';

main() => runApp(MyApp());

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
      home: Home(),
      routes: {
        "/pantry":(context) => Pantry(pantryIngredients,addIngredient,deleteIngredient)
      },

    );
  }
}
