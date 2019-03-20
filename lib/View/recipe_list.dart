import 'package:flutter/material.dart';
import '../Controller/recipe_list_table.dart';



class RecipePage extends StatelessWidget{

  final String finalURL;

  RecipePage(this.finalURL);

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Theme.of(context).accentColor
        ),
        title: Text("Meals", style: TextStyle(color: Theme.of(context).accentColor),),
      ),
      body: RecipeTable(finalURL),
    
    );
  }


  
}

