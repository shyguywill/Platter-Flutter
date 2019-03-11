import 'package:flutter/material.dart';

import '../Controller/pantry_list_table.dart';
import '../Controller/pantry_floating_add.dart';

class Pantry extends StatelessWidget {
  
  final Function _addItem;
  final Function _deleteItem;

  Pantry(this._addItem, this._deleteItem);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IngredientTable(_deleteItem,),

      floatingActionButton: AddItems(_addItem),

      //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat
    );
  }
}
