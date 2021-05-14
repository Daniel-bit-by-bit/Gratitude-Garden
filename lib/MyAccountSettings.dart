import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';

// dart
import 'package:gratitude_garden/main.dart';
import 'package:gratitude_garden/AvatarGallery.dart';

class MyAccountSettings extends StatefulWidget {
  final String uid;
  MyAccountSettings({this.uid});
  @override
  _MyAccountSettingsState createState() => _MyAccountSettingsState(uid: uid);
}

class _MyAccountSettingsState extends State<MyAccountSettings> {
  final String uid;
  _MyAccountSettingsState({this.uid});
  TextStyle style = TextStyle(color: Colors.blue, fontWeight: FontWeight.w500, fontSize: 16);


  @override
  Widget build(BuildContext context) {
    DatabaseReference userref = FirebaseDatabase(
        databaseURL: 'https://gratitude-garden-83e02-default-rtdb.firebaseio.com/')
        .reference()
        .child('Users')
        .child(uid);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Account',
          style: TextStyle(fontSize: 16),
        ),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: userref.onValue,
            builder: (_context, AsyncSnapshot<Event> snapshot) {
              if (snapshot.hasData) {
                DataSnapshot dataValues = snapshot.data.snapshot;
                Map<dynamic, dynamic> userValues = dataValues.value;
                return Container(
                  padding: EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                              child: CircleAvatar(
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: userValues['avatar'] == 'none'
                                      ? Text(userValues['name'].toString()[0], style: TextStyle(fontSize: 32),)
                                      : Text(userValues['avatar'],),
                                ),
                              )
                          ),
                          TextButton(
                            child: Text(
                              'Change Profile Picture',
                              style: style,
                            ),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => AvatarGallery(uid: uid)));
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Name', style: style),
                          Text(userValues['name'], style: style),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Email', style: style),
                          Text(userValues['email'], style: style),
                        ],
                      ),
                      SizedBox(height: 20),
                      Container(
                        child: Text('Password', style: style),
                        padding: EdgeInsets.only(bottom: 10),
                        alignment: Alignment.centerLeft,
                      ),
                      Column(
                        children: [
                          Container(
                            width: 240,
                            height: 40,
                            child: TextField(
                              style: TextStyle(fontSize: 14),
                              obscureText: true,
                              autofocus: false,
                              decoration: InputDecoration(
                                hintText: 'Current Password',
                              ),
                            ),
                          ),
                          Container(
                            width: 240,
                            height: 40,
                            child: TextField(
                              style: TextStyle(fontSize: 14),
                              obscureText: true,
                              autofocus: false,
                              decoration: InputDecoration(
                                hintText: 'New Password',
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              }
              return LinearProgressIndicator();
            }
        ),
      ),
    );
  }
}