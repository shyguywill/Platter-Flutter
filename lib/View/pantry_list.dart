import 'package:flutter/material.dart';

import '../Controller/pantry_list_table.dart';
import '../Controller/pantry_floating_add.dart';





class Pantry extends StatelessWidget {
  
  final Function _addItem;
  final Function _deleteItem;
  final Function _load;
  final List<Map> _ingredients;

  Pantry(this._addItem, this._deleteItem,this._load,this._ingredients);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IngredientTable(_deleteItem,_load,_ingredients),

      floatingActionButton: AddItems(_addItem,_load),

      //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat
    );
  }
}
