import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IndexBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return IndexBodyState();
  }
}

class IndexBodyState extends State<IndexBody> {
  String _text = "不知道";

  void _onButtonChangePressed() {
    _getFoods().then((List<String> foods) {
      if (foods.length == 0) {
        setState(() {
          _text = "请先添加食物";
        });
      } else {
        int randIndex = Random().nextInt(foods.length);
        setState(() {
          _text = foods[randIndex];
        });
      }
    });
  }

  Future<List<String>> _getFoods() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList("foods") ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          child: Text(_text),
          margin: EdgeInsets.symmetric(vertical: 20),
        ),
        Container(
          alignment: Alignment.center,
          child: RaisedButton(
            color: Color(0xfff6b26b),
            textColor: Colors.white,
            child: Text("换一个"),
            onPressed: _onButtonChangePressed,
          ),
        ),
      ],
    );
  }
}
