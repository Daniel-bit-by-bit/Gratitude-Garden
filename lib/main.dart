import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Center(child: Text('Gratitude Garden')),
        ),
        body: Center(child: Image(image: AssetImage('images/GG.jpg'))),
      ),
    ),
  );    //End of code
}