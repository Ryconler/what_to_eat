import 'package:flutter/material.dart';

class FoodList extends StatefulWidget {
  FoodList({Key key, this.foods, this.onFoodDelete}) : super(key: key);

  final List<String> foods;

  final Function onFoodDelete;

  @override
  State<StatefulWidget> createState() {
    return FoodListState();
  }
}

class FoodListState extends State<FoodList> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: ListTile.divideTiles(
          context: context,
          tiles: widget.foods.asMap().keys.map((int index) {
            return ListTile(
              title: Text(widget.foods[index]),
              trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    widget.onFoodDelete(index);
                  }),
            );
          })).toList(),
    );
  }
}
