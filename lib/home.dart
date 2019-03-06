import 'package:flutter/material.dart';

import "./View/start_page.dart";
import "./View/my_recipes.dart";
import './View/search_recipes.dart';

class Home extends StatelessWidget {

  

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        drawer: Drawer(),
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Theme.of(context).accentColor
          ),
          title: Image.asset("assets/logo.png"),
          bottom: TabBar(
            indicatorColor: Colors.pinkAccent,
            tabs: <Widget>[
              Tab(
                child: buildTabname(1),
              ),
              Tab(
                child: buildTabname(2),
              ),
              Tab(
                child: buildTabname(3),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[StartPage(), SearchRecipes(), MyRecipes()],
        ),
      ),
    );



    
  }
}

Widget buildTabname(int tab) {
  String tabName;

  if (tab == 1) {
    tabName = "Home";
  }
  if (tab == 2) {
    tabName = "Find Recipes";
  }
  if (tab == 3) {
    tabName = "My Recipes";
  }

  return Text(tabName,
  style: TextStyle(
    color: Colors.indigo[900],

  ),);
}
