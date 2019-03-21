import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../secrets.dart';

class SearchRecipes extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SearchRecipes();
  }
}

class _SearchRecipes extends State<SearchRecipes> {
  var data;
  String items = "";

  void getData(String url) async {
    //Network
    print("Setting getting data");
    var res = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    //Parse Json
    setState(() {
      print("Setting state");
      var resBody = json.decode(res.body);
      data = resBody["hits"];
    });
  }

  String createURL(String item) {
    return "${EdmAPI.baseURL + item}&app_id=${EdmAPI.appID}&app_key=${EdmAPI.appKey}&from=0&to=100";
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Column(
      children: <Widget>[
      
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(35)),
          child: TextField(
            decoration: InputDecoration(
              fillColor: Colors.white,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(35))),
              suffixIcon: IconButton(
                icon: Icon(Icons.search),
                color: Theme.of(context).accentColor,
                onPressed: () {
                  //Network
                  getData(createURL(items));
                },
              ),
              filled: true,
            ),
            onSubmitted: (value) {
              //Network
              if (value !=null){

                getData(createURL(value));

              }
              
            },
            onChanged: (value) {
              setState(() {
                items = value;
              });
            },
          ),
        ),
        SizedBox(
          height: 10.0,
        ),data == null ? Container(
          width: width / 1.1,
          height: height / 1.5,
          child:Card(
          child: Center(child:Text("Search for something Yummy"),)
        )):
        Expanded(child:
        
        ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, row) {
            return Card(
                color: Colors.transparent,
                elevation: 4.0,
                child: new Container(
                    width: width / 1.2,
                    height: height / 1.7,
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      borderRadius: new BorderRadius.circular(8.0),
                    ),
                    child: new Column(children: <Widget>[
                      new Container(
                        width: width / 1.2,
                        height: height / 2.2,
                        decoration: new BoxDecoration(
                          borderRadius: new BorderRadius.only(
                              topLeft: new Radius.circular(8.0),
                              topRight: new Radius.circular(8.0)),
                          image: DecorationImage(
                            image: NetworkImage(data[row]["recipe"]["image"])
                          ),
                        ),
                      ),
                      Container(
                        height: 20,
                        
                        child: 
                      FlatButton(
                        child: Text("Check it out"),
                        onPressed: (){},
                      ))
                    ])));
          },
          itemCount: 10,
        ))
      ],
    );
  }
}
