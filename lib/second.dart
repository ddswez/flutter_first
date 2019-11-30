import 'package:flutter/material.dart';

//void main() => runApp(MySecondApp()); //2

class MySecondApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Scaffold test"),
        ),
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: Text("Scaffold"),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Container(height: 50),
        ),
        drawer: Drawer(
          child: Center(
            child: Text("抽屉"),
          ),
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add)),
      ),
    );
  }
}
