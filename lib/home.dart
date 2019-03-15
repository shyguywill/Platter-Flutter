import 'package:flutter/material.dart';

import "./View/start_page.dart";
import "./View/my_recipes.dart";
import './View/auth.dart';


class Home extends StatelessWidget {

  final List myMeals;

  final Function load;

  final Function delete;




  Home(this.myMeals,this.load, this.delete);

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
          title: Text("platter",style: TextStyle(
            color: Theme.of(context).accentColor,
            fontFamily: "Futura"
          ),),
          bottom: TabBar(
            indicatorColor: Colors.pinkAccent,
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.home),
                
              ),
              Tab(
                icon: Icon(Icons.fastfood),
                
              ),
              Tab(
                icon: Icon(Icons.account_circle),
              )
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[StartPage(), MyRecipes(myMeals,load, delete), Auth()],
        ),
      ),
    );



    
  }
}

// Widget buildTabname(int tab) {
//   String tabName;

//   if (tab == 1) {
//     tabName = "Home";
//   }
//   if (tab == 2) {
//     tabName = "Find Recipes";
//   }
//   if (tab == 3) {
//     tabName = "My Recipes";
//   }

//   return Text(tabName,
//   style: TextStyle(
//     color: Colors.indigo[900],

//   ),);
// }
