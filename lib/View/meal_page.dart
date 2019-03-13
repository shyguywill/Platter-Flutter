import 'package:flutter/material.dart';

import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';


class MealPage extends StatelessWidget{

  final String mealURL;

  MealPage(this.mealURL);

  @override
  Widget build(BuildContext context) {
    
    return WebviewScaffold(

      appBar: AppBar(
        title: Text("Recipe"),
      ),
      url: mealURL,
      clearCache: true,
      clearCookies: true,
    );

}}