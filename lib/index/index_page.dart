import 'package:flutter/material.dart';
import 'package:what_to_eat/index/index_body.dart';
import 'package:what_to_eat/food/food_page.dart';

class IndexPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return IndexPageState();
  }
}

class IndexPageState extends State<IndexPage> {
  void _onIconListPressed() {
    Navigator.push(context, MaterialPageRoute(builder: (contenxt) {
      return FoodPage();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("今天吃什么"),
          centerTitle: true,
          backgroundColor: Color(0xfff6b26b),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.list), onPressed: _onIconListPressed),
          ],
        ),
        body: IndexBody());
  }
}
