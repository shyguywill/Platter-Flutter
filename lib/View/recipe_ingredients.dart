import 'package:flutter/material.dart';

import 'package:stretchy_header/stretchy_header.dart';

class RecipeIngredeints extends StatelessWidget {
  final List _ingredients;
  final List _pageDetails;

  RecipeIngredeints(this._pageDetails, this._ingredients);

  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
          color: Theme.of(context).accentColor
        ),
          

          title: Text(
            _pageDetails[0],
            maxLines: 1,style: TextStyle(color: Theme.of(context).accentColor),
          ),
        ),
        body: Stack(
          children: <Widget>[
            StretchyHeader(
              blurContent: false,
              headerHeight: 150.0,
              header: Image.network(
                _pageDetails[1],
                fit: BoxFit.cover,
              ),
              body: ListView.builder(
                itemCount: (_ingredients.length),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      _ingredients[(index)],
                      maxLines: 1,
                    ),
                  );
                },
              ),
            ),
            Align(
                alignment: Alignment.topCenter,
                child: Container(
                  padding: EdgeInsets.only(top: 25),
                  height: 75,
                  width: 200,
                  child: RawMaterialButton(
                      fillColor: Colors.pinkAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      elevation: 5.0,
                      child: Text(
                        "Go to recipe on ${_pageDetails[2]}",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                        maxLines: 2,
                      ),
                      onPressed: () {


                        print("*mealpage*${_pageDetails[3]}*${_pageDetails[1]}*${_pageDetails[0]}");


                        //passing in URL(3),Image(1),Label(0)



                        Navigator.pushNamed(context, "*mealpage*${_pageDetails[3]}*${_pageDetails[1]}*${_pageDetails[0]}");
                      }),
                ))
          ],
        ),
      ),
    );
  }
}
