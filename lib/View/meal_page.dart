import 'package:flutter/material.dart';

import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class MealPage extends StatefulWidget {
  final String mealURL;
  final String photo;
  final String label;

  final Function saveMeal;

  MealPage(this.mealURL, this.photo, this.label, this.saveMeal);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Mealpage();
  }
}

class _Mealpage extends State<MealPage> {

  bool _buttonPressed = false;

  save() {

    Map meal = {
        "URL": widget.mealURL,
        "Photo": widget.photo,
        "Label": widget.label
      };

      widget.saveMeal(meal);


    setState(() {
      _buttonPressed =true;
    });

    print("Saved");
  }

  @override
  Widget build(BuildContext context) {
    

    return WebviewScaffold(
      appBar: AppBar(
        actions: <Widget>[
          FlatButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            child: Text(
              _buttonPressed ? "Saved" : "Save Meal",
              style: TextStyle(color: Colors.greenAccent),
            ),
            onPressed: _buttonPressed ? (){return null;} : (){
              save();
            },
          )
        ],
        title: Text("Recipe"),
      ),
      url: widget.mealURL,
      clearCache: true,
      clearCookies: true,
      supportMultipleWindows: false,
    );
  }
}
