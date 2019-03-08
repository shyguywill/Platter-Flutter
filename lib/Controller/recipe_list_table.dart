import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RecipeTable extends StatefulWidget {
  final String _finalURL;

  RecipeTable(this._finalURL);

  @override
  State<StatefulWidget> createState() {
    return _RecipeTable();
  }
}

class _RecipeTable extends State<RecipeTable> {
  List data;
  String finalUrl;

  @override
  void initState() {
    super.initState();

    finalUrl = widget._finalURL;
  }

  Future<String> getData() async {
    //Netwwork
    print("Setting getting data");
    var res = await http
        .get(Uri.encodeFull(finalUrl), headers: {"Accept": "application/json"});

    setState(() {
      //Parse Json
      print("Setting state");
      var resBody = json.decode(res.body);
      data = resBody["hits"];
    });

    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (BuildContext context, int row) {
          return Container(
            height: 150,
            margin: EdgeInsets.all(5),
            child: 
            Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Container(
                  child: ListTile(
                    onTap: (){
                      
                      print ("Ive been tapped");
                    },
                  ),
                    decoration: BoxDecoration(
                        image: DecorationImage( //Assign image asvdecoration, allowing for cropping
                          image: AssetImage(
                            "assets/testimage.jpg",
                          ),
                          fit: BoxFit.cover,
                        ),
                        //border: Border.all(w),
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
                        
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    "Title here",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontFamily: "Futura",
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
        itemCount: 10 //data.length,
        );
  }
}
