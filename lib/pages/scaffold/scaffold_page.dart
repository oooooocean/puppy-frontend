import 'package:flutter/material.dart';

class ScaffoldPage extends StatefulWidget {
  const ScaffoldPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ScaffoldState();
}

class _ScaffoldState extends State<ScaffoldPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('主页'),
      ),
    );
  }
}
