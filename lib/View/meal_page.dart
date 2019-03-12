import 'package:flutter/material.dart';

import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';


class MealPage extends StatefulWidget{

  final String mealURL;


  MealPage(this.mealURL);

  @override
  State<StatefulWidget> createState() {
    
    return _MealPage();
  }
}

class _MealPage extends State<MealPage>{

  String editedURL;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    editedURL = widget.mealURL.replaceAll("http", "https");
    
  }

  


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WebviewScaffold(

      appBar: AppBar(
        title: Text("Recipe"),
      ),
      url: widget.mealURL,

    );



}}