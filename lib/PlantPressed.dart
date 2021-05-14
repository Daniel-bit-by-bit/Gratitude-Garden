import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:gratitude_garden/confirmFriend.dart';

// dart
import 'package:gratitude_garden/MyAccountSettings.dart';
import 'package:gratitude_garden/PrivacySettings.dart';
import 'package:gratitude_garden/AddGratitude.dart';

import 'ViewGratitude.dart';

class PlantPressed extends StatefulWidget {
  PlantPressed({this.index, this.plant, this.uid});
  final int index;
  Map<dynamic, dynamic> plant;
  final String uid;

  @override
  _PlantPressedState createState() => _PlantPressedState(index: index, plant: plant, uid: uid);
}

class _PlantPressedState extends State<PlantPressed> {
  _PlantPressedState({this.index, this.plant, this.uid});
  final int index;
  Map<dynamic, dynamic> plant;
  final String uid;

  @override
  Widget build(BuildContext context) {
    DatabaseReference userref = FirebaseDatabase(
        databaseURL: 'https://gratitude-garden-83e02-default-rtdb.firebaseio.com/')
        .reference()
        .child('Users')
        .child(uid);

    String path = 'images/' +'${plant['type']}' + '-' + '${plant['level']}' + '.png';
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 205,
                  child: StreamBuilder(
                      stream: userref.onValue,
                      builder: (_context, AsyncSnapshot<Event> snapshot) {
                        if (snapshot.hasData) {
                          DataSnapshot dataValues = snapshot.data.snapshot;
                          Map<dynamic, dynamic> userValues = dataValues.value;
                          return Row(
                            children: [
                              Container(
                                width: 45,
                                height: 45,
                                child: CircleAvatar(
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: userValues['avatar'] == 'none'
                                        ? Text(userValues['name'].toString()[0])
                                        : Text(userValues['avatar'],),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: 145,
                                child: FittedBox(
                                  alignment: Alignment.centerLeft,
                                  fit: BoxFit.scaleDown,
                                  child: Text(userValues['name'],
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                        return LinearProgressIndicator();
                      }
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'Gratitude Garden',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ],
            )
        ),
        endDrawer: Drawer(
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                'Settings',
                style: TextStyle(fontSize: 16),
              ),
            ),
            body: Column(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MyAccountSettings(uid: uid))).then((value) => setState(() {}));
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 10, top: 12, right: 10, bottom: 12),
                    child: Row(children: [
                      Icon(Icons.account_circle),
                      SizedBox(
                        width: 16,
                      ),
                      Text('My Account')
                    ]),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PrivacySettings(uid: uid)));
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 10, top: 12, right: 10, bottom: 12),
                    child: Row(children: [
                      Icon(Icons.lock),
                      SizedBox(
                        width: 16,
                      ),
                      Text('Privacy')
                    ]),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    signOutUser();
                    Navigator.popUntil(context, ModalRoute.withName('/'));
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 10, top: 12, right: 10, bottom: 12),
                    child: Row(children: [
                      Icon(Icons.logout),
                      SizedBox(
                        width: 16,
                      ),
                      Text('Log Out')
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: RawMaterialButton(
                  child: Container(
                    width: 60,
                    child: Icon(Icons.arrow_back),
                    alignment: Alignment.centerLeft,),
                  onPressed: () => Navigator.pop(context)),
            ),
            Container(
              width: 400,
              child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(alignment: Alignment.topCenter),
                    Container(
                      height: 200,
                      width: 200,
                      child: Image(image: AssetImage(path)),
                    ),
                  ], //children-inner
                ), //row1
                SizedBox(height: 20),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Card(
                    color: Colors.blue,
                    child: Container(
                      margin: EdgeInsets.all(2),
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        height: 180,
                        width: 220,
                        color: Colors.blue,
                        child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                          Container(
                              width: 190,
                              height: 40,
                              color: Colors.lightBlueAccent,
                              child: TextButton(
                                  child: Text('Feed Gratitude', style: TextStyle(fontSize: 16, color: Colors.white)),
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => AddGratitude(uid: uid, index: index, plant: plant)));
                                  })),
                          Container(
                              width: 190,
                              height: 40,
                              color: Colors.lightBlueAccent,
                              child: TextButton(
                                  child: Text('View Gratitude', style: TextStyle(fontSize: 16, color: Colors.white)),
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => ViewGratitude(gratitude: plant['gratitude'], plantImage: path)));
                                  })),
                          Container(
                              width: 190,
                              height: 40,
                              color: Colors.lightBlueAccent,
                              child: TextButton(
                                  child: Text('Send a Plant', style: TextStyle(fontSize: 16, color: Colors.white)),
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => confirmFriend(uid: uid)));
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                              title: Text('Error'),
                                              content: Text('Function not implemented.'),
                                              actions: [
                                                TextButton(
                                                    child: Text('Ok'),
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                    }
                                                )
                                              ]
                                          );
                                        });
                                  })),
                        ]) //children
                    ),
                  ),
                ])
              ]),
            ),
          ],
        ), //children-outer
      ),
    );
  }

  void signOutUser() async {
    await FirebaseAuth.instance.signOut();
  }
}