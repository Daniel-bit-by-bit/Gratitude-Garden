import 'package:flutter/material.dart';
import 'package:gratitude_garden/main.dart';
import 'package:firebase_database/firebase_database.dart';

class ViewGratitude extends StatefulWidget {
  ViewGratitude({this.gratitude, this.plantImage});
  final String gratitude;
  final String plantImage;
  @override
  _ViewGratitudeState createState() => _ViewGratitudeState(gratitude: gratitude, plantImage: plantImage);
}

class _ViewGratitudeState extends State<ViewGratitude> {
  _ViewGratitudeState({this.gratitude, this.plantImage});
  final String gratitude;
  final String plantImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('View Gratitude', style: TextStyle(fontSize: 16))),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                image: DecorationImage(
                  image: AssetImage(plantImage),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            Expanded(
              child: Container(
                  padding: EdgeInsets.all(20),
                  child: Container(
                      color: Colors.blue,
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text('My Gratitude', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16)),
                          ),
                          Expanded(
                              child: Container(
                                  color: Colors.white,
                                  padding: EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 10),
                                  child: Scrollbar(
                                    child: SingleChildScrollView(
                                      padding: EdgeInsets.only(right: 15),
                                      child: Text(gratitude, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
                                    ),
                                  ))),
                        ],
                      ))),
            )
          ],
        ),
      ),
    );
  }
}
