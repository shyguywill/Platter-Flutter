import 'package:flutter/material.dart';
import 'dart:core';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

import '../Controller/home_widgets.dart';
import './auth.dart';
import "./my_recipes.dart";
import '../secrets.dart';

class StartPage extends StatefulWidget {
  final int streak;
  final Function getStreak;

  final List myMeals;
  final Function load;
  final Function delete;

  StartPage(this.streak, this.getStreak, this.myMeals, this.load, this.delete);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _StartPage();
  }
}

class _StartPage extends State<StartPage> {
  bool userSignedUp = false;
  Map data;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.getStreak();
    getData();
  }

  void getUserStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool status = prefs.getBool("user") ?? false;

    userSignedUp = status;
  }

   void getData() async {
    //Network
    print("Setting getting data");
    var res = await http.get(Uri.encodeFull(createURL()), headers: {"accept": "application/json"});

    //Parse Json
      print("Setting state");
      var resBody = json.decode(res.body);
      Random random = new Random();
      int randomNumber = random.nextInt(100); 
      //print("This is data lenght ${data.length}");
      //print(randomNumber);
       //print(resBody["hits"][randomNumber]["recipe"]);

       setState(() {
         data = resBody["hits"][randomNumber]["recipe"];
       });
    
  }

  String createURL() { //Creates restfulAPI URL
    return "${EdmAPI.baseURL + 'chicken'}&app_id=${EdmAPI.appID}&app_key=${EdmAPI.appKey}&from=0&to=100";
  }


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height; //User Screen height

    widget.load();
    //widget.getStreak();

    getUserStatus();

    print("Start build");

    return Container(
        margin: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Card(
              elevation: 15,
              child: Column(
                children: <Widget>[
                  Center(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                      child: streakBanner(widget.streak),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 30),
                    child: buildStreak(widget.streak),
                  ),
                  Container(
                    child: streakAward(widget.streak),
                  ),
                  userEncouragement(widget.streak),
                ],
              ),
            ),
            userSignedUp
                ? alternateUserCard()
                : Card(
                    elevation: 15,
                    child: ListTile(
                      onTap: () {
                        Navigator.push(context,
                                MaterialPageRoute(builder: (context) => Auth()))
                            .then((onValue) {
                          setState(() {});
                        });
                      },
                      leading: Icon(
                        Icons.account_circle,
                        color: Colors.pinkAccent,
                      ),
                      title: Text(
                        "Log in to share your own recipes with other Platter users",
                        textAlign: TextAlign.center,
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                Card( //Meal of the day
                  elevation: 25,
                  child:  data != null ?
                    Container(  
                    margin: EdgeInsets.only(top: 15),
                    child: ListTile(
                      // onTap: () {
                      //   List details = [
                      //     ingredientArray[row].label,
                      //     ingredientArray[row].image,
                      //     ingredientArray[row].source,
                      //     ingredientArray[row].url,
                      //   ];
                      //   List ingredients = ingredientArray[row].ingredients;

                      //   Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (BuildContext context) =>
                      //               RecipeIngredeints(details, ingredients)));

                      //   print(details);
                      //   //print(ingredients);
                      // },
                      leading: Container(
                          height: 100,
                          child: Image.network(
                            data['image'],
                            fit: BoxFit.contain,
                          )),
                      //isThreeLine: true,
                      title: Container(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text(
                            data['label'],
                            textAlign: TextAlign.center,
                            maxLines: 2,
                          )),
                    )) : 
                Container(
                  child: Text("Loading")
                )),
            Card(
              elevation: 25,
              child: Container(
                  height: widget.myMeals.isNotEmpty
                      ? (height / 2.22 +
                          (widget.myMeals.length.toDouble() * 10 ?? 0))
                      : 200,
                  child: MyRecipes(widget.myMeals, widget.load, widget.delete)),
            )
          ],
        ));
  }

  Widget alternateUserCard() {
    return Card(
      elevation: 10,
      child: ListTile(
        onTap: () {},
        leading: Icon(
          Icons.account_circle,
          color: Colors.greenAccent,
        ),
        title: Text(
            "We are building your new community. Log in will be available shortly.",
            textAlign: TextAlign.start),
      ),
    );
  }
}
