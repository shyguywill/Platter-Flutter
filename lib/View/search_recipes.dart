import 'package:flutter/material.dart';

class SearchRecipes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(children: <Widget>[ Container(
      height: 550,
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: Column(children: <Widget>[
          
          Container(
            
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(35)),
            child:  TextField(
              style: TextStyle(
                height: 0.5
              ),
              decoration: InputDecoration(
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(35))),
                suffixIcon: IconButton(icon:
                  Icon(Icons.search),
                  color: Theme.of(context).accentColor,
                  onPressed: (){

                    print ("Ive been pressed");

                  },
                ),
                filled: true,
              ),
              onChanged: (value) {},
            ),)
          ,
          SizedBox(
            height: 10.0,
          ),
          Expanded(
              child: Card(
            child: Center(
              child: Text("Search for your favourite recipes"),
            ),
          ))
        ]))],);
  }
}
