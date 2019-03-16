import '../Controller/pantry_list_table.dart';
import 'dart:collection';



class SortList<E> extends ListBase<E> {
  List innerList = new List();

  int get length => innerList.length;

  set length(int length) {
    innerList.length = length;
  }

  void operator[]=(int index, E value) {
    innerList[index] = value;
  }

  E operator [](int index) => innerList[index];

  // Though not strictly necessary, for performance reasons
  // you should implement add and addAll.

  void add(E value) => innerList.add(value);

  void addAll(Iterable<E> all) => innerList.addAll(all);



  int difference() {
    var listCount = this.length;
    String stringedList = this.join(" ");

    var parameters = IngredientTable.selectedItem;

    for (String item in parameters) {
      if (stringedList.toLowerCase().contains(item.toLowerCase())) {
        listCount -= 1;
      }
    }

    if (listCount < 0) {
      listCount = 0;
    }

    

    return listCount;
  }
}






