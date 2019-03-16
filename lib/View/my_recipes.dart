import 'package:flutter/material.dart';

import './meal_page.dart';

class MyRecipes extends StatefulWidget {
  final List savedMeals;

  final Function loadMeals;
  final Function deleteMeal;

  MyRecipes(this.savedMeals, this.loadMeals, this.deleteMeal);

  @override
  State<StatefulWidget> createState() {
    
    return _MyRecipes();
  }
}

class _MyRecipes extends State<MyRecipes> {
  @override
  void initState() {
    super.initState();

    widget.loadMeals();
  }

  @override
  Widget build(BuildContext context) {
    //print("These are ${widget.savedMeals}");

    return widget.savedMeals.isEmpty
        ? Center(
            child: Text("All the recipes you love will appear right here", textAlign: TextAlign.center,),
          )
        : ListView.separated(
            separatorBuilder: (context, index) {
              return Divider(
                color: Colors.black,
              );
            },
            itemBuilder: (context, index) {
              return Container(
                  margin: EdgeInsets.only(top: 30),
                  height: 100,
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MealPage(
                                    widget.savedMeals[index]["URL"],
                                    destination: "Store",
                                  )));
                    },
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          widget.deleteMeal(index);
                          widget.loadMeals();
                        });
                      },
                    ),
                    title: Text(widget.savedMeals[index]["Label"]),
                    leading: Image.network(widget.savedMeals[index]["Photo"]),
                  ));
            },
            itemCount: widget.savedMeals.length,
          );
  }
}
