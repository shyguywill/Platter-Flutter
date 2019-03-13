import 'package:flutter/material.dart';
import './meal_page.dart';
import 'package:stretchy_header/stretchy_header.dart';

class RecipeIngredeints extends StatelessWidget {
  final List _ingredients;
  final List _pageDetails;

  RecipeIngredeints(this._pageDetails, this._ingredients);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            _pageDetails[0],
            maxLines: 1,
          ),
        ),
        body: Stack(
          children: <Widget>[
            StretchyHeader(
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
            
            child:RawMaterialButton(
            
                      fillColor: Colors.pinkAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      elevation: 5.0,
                      child: Text(
                        "Go to recipe on ${_pageDetails[2]}",
                        style: TextStyle(color: Colors.white),
                        maxLines: 1,
                      ),
                      onPressed: () {

                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> MealPage(_pageDetails[3])));

                        
                      }),
        ))
          ],
        ),
      ),
    );
  }
}
    
    
    
    
    // Scaffold(
    //     appBar: AppBar(
    //       title: Text(
    //         _pageDetails[0],
    //         maxLines: 1,
    //       ),
    //     ),
    //     body: ListView.builder(
          
    //       itemBuilder: (context, row) {
    //         if (row == 0) {
    //           return Container(
    //             decoration: BoxDecoration(
    //                 image: DecorationImage(
    //                     fit: BoxFit.cover,
    //                     image: NetworkImage(
    //                       _pageDetails[1],
    //                     ))),
    //             height: 120,
    //             child: Container(
    //               padding:
    //                   EdgeInsets.symmetric(vertical: 30.0, horizontal: 60.0),
    //               width: 120.0,
    //               height: 70.0,
    //               child: RawMaterialButton(
    //                   fillColor: Colors.pinkAccent,
    //                   shape: RoundedRectangleBorder(
    //                       borderRadius: BorderRadius.circular(10.0)),
    //                   elevation: 5.0,
    //                   child: Text(
    //                     "Go to recipe on ${_pageDetails[2]}",
    //                     style: TextStyle(color: Colors.white),
    //                     maxLines: 1,
    //                   ),
    //                   onPressed: () {

    //                     Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> MealPage(_pageDetails[3])));

                        
    //                   }),
    //             ),
    //           );
    //         }
    //         return ListTile(

    //           title: Text(
    //             _ingredients[(row - 1)],
    //             maxLines: 1,
    //           ),
    //         );
    //       },
    //       itemCount: (_ingredients.length + 1),
    //     ));
  //}
//}
