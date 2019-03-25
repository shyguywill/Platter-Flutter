import 'package:flutter/material.dart';
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
  List data;
  String items = "";
  bool isLoading = false;

  void getData(String url) async {
    //Network
    print("Setting getting data");

    setState(() {
      isLoading = true;
    });
    var res = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    //Parse Json
    setState(() {
      print("Setting state");
      var resBody = json.decode(res.body);
      data = resBody["hits"];
      isLoading = false;

      if (data.length < 1) {
        print("else");
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Uh oh"),
                content: Text("It seems we couldn't find you any meals under '$items', please try a different meal."),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Got it"),
                    onPressed: () {
                      Navigator.pop(context);
                     
                    },
                  )
                ],
              );
            });
      }
    });
  }

  String createURL(String item) {
    return "${EdmAPI.baseURL + item}&app_id=${EdmAPI.appID}&app_key=${EdmAPI.appKey}&from=0&to=100";
  }

  Widget showCircularLoader() {
    return isLoading ? CircularProgressIndicator() : SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    print (height/1.55);

    return Stack(children: <Widget>[
      SingleChildScrollView(
          child: Container(
        height: height/1.1 ,
        width: width,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(35)),
              child: TextField(
                textCapitalization: TextCapitalization.sentences,
                autocorrect: true,
                decoration: InputDecoration(
                 
                  hintText: "Search for something yummy!",
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
                  if (value != null) {
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
              height: 5.0,
            ),
            data == null
                ? Container(
                    width: width / 1.2,
                    height: height / 1.45,
                    child: Card(
                        elevation: 4.0,
                        child: 
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Center(
                          child: Text(
                            "Find new recipes for meals you already love!",
                            textAlign: TextAlign.center,
                            style: TextStyle()
                                //color: Colors.,
                                //fontWeight: FontWeight.bold,
                                //fontSize: 17),
                          ),
                        ))))
                : Container(
                  margin: EdgeInsets.only(left: 10),
                    width: width / 1,
                    height: height / 1.3,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, row) {
                        double calories = data[row]["recipe"]["calories"];
                        double serving = data[row]["recipe"]["yield"];
                        var servingParsed = serving.toInt();
                        List dietLabels = data[row]["recipe"]["dietLabels"];
                        double prepTime = data[row]["recipe"]["totalTime"];
                        String finalTime = "N/A";
                        if (prepTime != 0) {
                          finalTime = "${prepTime.round()} mins";
                        }

                        return Card(
                            color: Colors.transparent,
                            elevation: 4.0,
                            child: new Container(
                                 width: width / 1.2,
                                // height: height / 1.6,
                                  
                                decoration: new BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: new BorderRadius.circular(8.0),
                                ),
                                child: Column(
                                    // crossAxisAlignment: CrossAxisAlignment.start,

                                    children: <Widget>[
                                      new Container(
                                        width: width / 1.5,
                                        height: height / 2.5,
                                        decoration: new BoxDecoration(
                                          borderRadius: new BorderRadius.only(
                                              topLeft: new Radius.circular(8.0),
                                              topRight:
                                                  new Radius.circular(8.0)),
                                          image: DecorationImage(
                                              //fit: BoxFit.contain,
                                              image: NetworkImage(data[row]
                                                  ["recipe"]["image"])),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 10),
                                        
                                        child:
                                      Text(
                                        
                                        "${data[row]["recipe"]["label"]}",
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        softWrap: true,
                                        style: TextStyle(
                                            color: Colors.pinkAccent,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16),
                                      )),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                          padding: EdgeInsets.only(left: 32),
                                          height: 130,
                                          width: width / 1.1,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                "Calories: ${(calories ~/ data[row]["recipe"]["yield"])}",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text("Serves: $servingParsed",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                "Dietary Labels: ${dietLabels.join(", ")}",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w600),
                                                maxLines: 2,
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                  "Time to prepare: $finalTime",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                            ],
                                          )),
                                      Container(
                                        height: 40,
                                          padding: EdgeInsets.only(top: 10),
                                          child: RaisedButton(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            color: Colors.greenAccent,
                                            child: Text(
                                                "Check it out on ${data[row]["recipe"]["source"]}",
                                                maxLines: 1,),
                                            onPressed: () {
                                              Navigator.pushNamed(context,
                                                  "*mealpage*${data[row]["recipe"]["url"]}*${data[row]["recipe"]["image"]}*${data[row]["recipe"]["label"]}");
                                            },
                                          )),
                                    ])));
                      },
                      itemCount: data.length,
                    ))
          ],
        ),
      )),
      Align(
        alignment: Alignment.center,
        child: showCircularLoader(),
      )
    ]);
  }
}
