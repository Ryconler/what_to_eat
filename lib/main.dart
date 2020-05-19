import 'package:flutter/material.dart';
import 'package:what_to_eat/index/index_page.dart';
import 'package:what_to_eat/utils/common.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Common.getDeviceInfo();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IndexPage(),
    );
  }
}
