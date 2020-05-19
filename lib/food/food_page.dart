import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:what_to_eat/food/food_list.dart';

class FoodPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FoodPageState();
  }
}

class FoodPageState extends State<FoodPage> {
  String _inputFoodText = "";

  List<String> _foods = [];

  Future<List<String>> _getFoods() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList("foods") ?? [];
  }

  Future<List<String>> _addFood(String food) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> foods = prefs.getStringList("foods") ?? [];
    foods.add(food);
    prefs.setStringList("foods", foods);
    return foods;
  }

  Future<List<String>> _removeFood(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> foods = prefs.getStringList("foods") ?? [];
    foods.removeAt(index);
    prefs.setStringList("foods", foods);
    return foods;
  }

  Future<List<String>> _clearFoods() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList("foods", []);
    return [];
  }

  void _onButtonAddPressed() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("添加食物"),
          titlePadding: EdgeInsets.all(10),
          content: TextField(
            onChanged: (String text) {
              _inputFoodText = text;
            },
          ),
          contentPadding: EdgeInsets.all(0),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                _inputFoodText = "";
                Navigator.pop(context);
              },
              child: Text('取消'),
            ),
            FlatButton(
              onPressed: () {
                _addFood(_inputFoodText).then((List<String> foods) {
                  setState(() {
                    _foods = foods;
                  });
                });
                Navigator.pop(context);
              },
              child: Text('确定'),
            ),
          ],
        );
      },
    );
  }

  void _onIconClearPressed() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("清空食物"),
          titlePadding: EdgeInsets.all(10),
          content: Text("是否清空食物？"),
          contentPadding: EdgeInsets.all(10),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('取消'),
            ),
            FlatButton(
              onPressed: () {
                _clearFoods().then((List<String> foods) {
                  setState(() {
                    _foods = [];
                  });
                });
                Navigator.pop(context);
              },
              child: Text('确定'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _getFoods().then((List<String> foods) {
      setState(() {
        _foods = foods;
      });
    });

    return Scaffold(
      appBar: AppBar(
        title: Text("食物列表"),
        centerTitle: true,
        backgroundColor: Color(0xfff6b26b),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.clear), onPressed: _onIconClearPressed),
        ],
      ),
      body: FoodList(
          foods: _foods,
          onFoodDelete: (int index) {
            _removeFood(index).then((List<String> foods) {
              setState(() {
                _foods = foods;
              });
            });
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: _onButtonAddPressed,
        child: Icon(Icons.add),
        backgroundColor: Color(0xfff6b26b),
      ), //
    );
  }
}
