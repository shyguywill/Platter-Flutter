import 'package:flutter/material.dart';

import './pantry_list.dart';
import './search_recipes.dart';

class SearchList extends StatelessWidget{

  final List _ingredients;
  final Function _addIngredients;
  final Function _deleteIngredients;

  SearchList(this._ingredients,this._addIngredients,this._deleteIngredients);


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
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
            Pantry(_ingredients,_addIngredients,_deleteIngredients),
            SearchRecipes()
          ],

        ),
      ),
      
    );
  }
}