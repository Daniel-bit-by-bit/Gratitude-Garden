import 'package:gratitude_garden/GGUser.dart';
import 'package:flutter/material.dart';
import 'package:gratitude_garden/main.dart';
import 'package:firebase_database/firebase_database.dart';

class DataList extends StatefulWidget {
  DataList({Key key}) : super(key: key);

  @override
  _DataListState createState() => _DataListState();
}

class _DataListState extends State<DataList> {
  final dbref = FirebaseDatabase(
      databaseURL: 'https://gratitude-garden-83e02-default-rtdb.firebaseio.com/'
  ).reference().child("Users");
  List<Map<dynamic, dynamic>> lists = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Data')),
        body: StreamBuilder(
            stream: dbref.onValue,
            builder: (context, AsyncSnapshot<Event> snapshot) {
              if (snapshot.hasData) {
                debugPrint('has data');
                lists.clear();
                DataSnapshot dataValues = snapshot.data.snapshot;
                Map<dynamic, dynamic> values = dataValues.value;
                debugPrint(values.toString());
                if (values != null) {
                  values.forEach((key, values) {
                    lists.add(values);
                  });
                } else {
                  return LinearProgressIndicator();
                }
                return new ListView.builder(
                    itemCount: lists.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Name: " + lists[index]["name"]),
                              Text("Email: " + lists[index]["email"]),
                              Text("Friends: " + lists[index]["plants"].toString()),
                              Text("Friends: " + lists[index]["friends"].toString()),
                              Text("Privacy: " + PrivacyValues.values[(lists[index]["privacy"])].toString()),
                            ],
                          ),
                        ),
                      );
                    }
                );
              } else {
                debugPrint("no data");
              }
              return LinearProgressIndicator();
            }
        )
    );
  }
}
