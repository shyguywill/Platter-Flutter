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
  List data = [];
  String finalUrl;

  @override
  void initState() {
    super.initState();

    print("initstate");

    finalUrl = widget._finalURL;
  }

  Future<String> getData() async {
    //Network
    print("Setting getting data");
    var res = await http.get(Uri.encodeFull(finalUrl), headers: {"Accept": "application/json"});

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

    getData(); //start networking

    return ListView.builder(
      itemCount: data.length,
        itemBuilder: (BuildContext context, int row) {

          return data.isEmpty ? Container(
            height: 150,
            margin: EdgeInsets.all(5),
            child: ListTile()
          ) : Container(
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
                        image: DecorationImage(
                          colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.darken), //Assign image asvdecoration, allowing for cropping
                          image: NetworkImage(
                            data[row]["recipe"]["image"],
                            
                            
                          ),
                          fit: BoxFit.cover,
                        ),
                        
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
                        
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    data[row]["recipe"]["label"],
                    
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
        
        );
  }
}
