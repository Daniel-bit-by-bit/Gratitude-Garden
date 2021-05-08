import 'package:gratitude_garden/GGUser.dart';
import 'package:flutter/material.dart';
import 'package:gratitude_garden/Plant.dart';
import 'package:gratitude_garden/main.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:gratitude_garden/DataList.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PlantPressed extends StatefulWidget {
  @override
  _PlantPressedState createState() => _PlantPressedState();
}

class _PlantPressedState extends State<PlantPressed> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 45,
                    height: 45,
                    child: user.profilePicture == ''
                        ? CircleAvatar(
                      child: Text(user.name[0]),
                    )
                        : CircleAvatar(
                      backgroundImage: AssetImage(user.profilePicture),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    user.name,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Gratitude Garden',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ], //row children 2
              ),
            ], //row children1
          ),
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MyAccountSettings())).then((value) => setState(() {}));
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PrivacySettings()));
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
                    debugPrint('sign out');
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
        body: Container(
          width: 400,
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(alignment: Alignment.topCenter),
                Container(
                  height: 200,
                  width: 200,
                  child: Image(image: AssetImage('images/plant01.png')),
                ),
              ], //children-inner
            ), //row1
            SizedBox(height: 40),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
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
                              Navigator.pushNamed(context, '/feed_gratitude');
                            })),
                    Container(
                        width: 190,
                        height: 40,
                        color: Colors.lightBlueAccent,
                        child: TextButton(
                            child: Text('View Gratitude', style: TextStyle(fontSize: 16, color: Colors.white)),
                            onPressed: () {
                              Navigator.pushNamed(context, '/view_gratitude');
                            })),
                    Container(
                        width: 190,
                        height: 40,
                        color: Colors.lightBlueAccent,
                        child: TextButton(
                            child: Text('Send a Plant', style: TextStyle(fontSize: 16, color: Colors.white)),
                            onPressed: () {
                              //Navigator.pushNamed(context, '/send_a_plant');
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
            ])
          ]),
        ), //children-outer
      ),
    );
  }

  void signOutUser() async {
    await FirebaseAuth.instance.signOut();
  }
}