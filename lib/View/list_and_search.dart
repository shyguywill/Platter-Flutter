import 'package:flutter/material.dart';

import './pantry_list.dart';
import './search_recipes.dart';

class SearchList extends StatelessWidget{

  
  final Function _addIngredients;
  final Function _deleteIngredients;
  final Function _load;
  final List<Map> _ingredients;

  SearchList(this._addIngredients,this._deleteIngredients,this._load,this._ingredients);


  @override
  Widget build(BuildContext context) {
    
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Theme.of(context).accentColor
          ),
          
          title: Text("platter",style: TextStyle(
            color: Theme.of(context).accentColor,
            fontFamily: "Futura"
          ),),
          bottom: TabBar(
            indicatorColor: Colors.pinkAccent,
            tabs: <Widget>[
              Tab(
                text: "Pantry",
              ),
              Tab(
                text: "Search Recipes",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Pantry(_addIngredients,_deleteIngredients,_load,_ingredients),
            SearchRecipes()
          ],

        ),
      ),
      
    );
  }
}