import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:progress_hud/progress_hud.dart';

import '../View/recipe_ingredients.dart';

class RecipeTable extends StatefulWidget {
  final String _finalURL;

  RecipeTable(this._finalURL);

  @override
  State<StatefulWidget> createState() {
    return _RecipeTable();
  }
}

class _RecipeTable extends State<RecipeTable> {
  ProgressHUD _progressHUD;
  List data = [];
  String finalUrl;

  List<Map> recipeDetails;

  @override
  void initState() {
    super.initState();

    print("initstate");

    finalUrl = widget._finalURL; //recieve URL

    getData(); //start networking

    _progressHUD = new ProgressHUD(
      backgroundColor: Colors.black12,
      color: Colors.white,
      containerColor: Colors.green,
      borderRadius: 5.0,
      text: 'Loading...',
    );
  }

  void getData() async {
    //Network
    print("Setting getting data");
    var res = await http
        .get(Uri.encodeFull(finalUrl), headers: {"Accept": "application/json"});

    //Parse Json
    setState(() {
      print("Setting state");
      var resBody = json.decode(res.body);
      data = resBody["hits"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return data.isEmpty
        ? Scaffold(
            body: Stack(
              children: <Widget>[_progressHUD],
            ),
          )
        : ListView.builder(
            itemCount: data.length,
            itemBuilder: (BuildContext context, int row) {
              return Container(
                height: 150,
                margin: EdgeInsets.all(5),
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    
                    Container(
                        child: ListTile(
                          onTap: () {
                            List details = [
                              data[row]["recipe"]["label"],
                              data[row]["recipe"]["image"],
                              data[row]["recipe"]["source"],
                              data[row]["recipe"]["url"],
                            ];
                            List ingredients =
                                data[row]["recipe"]["ingredientLines"];

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        RecipeIngredeints(
                                            details, ingredients)));

                            print(details);
                            //print(ingredients);
                          },
                        ),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.3),
                                  BlendMode
                                      .darken), //Assign image asvdecoration, allowing for cropping
                              image: NetworkImage(
                                data[row]["recipe"]["image"],
                              ),
                              fit: BoxFit.cover,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        data[row]["recipe"]["label"],
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text("Total Calories: 250",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontFamily: "Futura",
                              fontWeight: FontWeight.w400)),
                    ),
                    Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          "1 ingredient remaining",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: "Futura",
                            fontWeight: FontWeight.w400,
                          ),
                        ))
                  ],
                ),
              );
            },
          );
  }
}
