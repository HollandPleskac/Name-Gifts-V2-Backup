import 'package:flutter/material.dart';

import './screens/home_screen.dart';
import './tab_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TabPage(),
    );
  }
}