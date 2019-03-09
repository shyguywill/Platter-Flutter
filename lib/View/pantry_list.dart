import 'package:flutter/material.dart';

import '../Controller/pantry_list_table.dart';
import '../Controller/pantry_floating_add.dart';

class Pantry extends StatelessWidget {
  final List<Map> ingredients;
  final Function _addItem;
  final Function _deleteItem;

  Pantry(this.ingredients, this._addItem, this._deleteItem);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IngredientTable(ingredients, _deleteItem),

      floatingActionButton: AddItems(_addItem),

      //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat
    );
  }
}
