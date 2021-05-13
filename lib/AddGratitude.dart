import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:profanity_filter/profanity_filter.dart';

// dart
import 'package:gratitude_garden/MyAccountSettings.dart';
import 'package:gratitude_garden/PrivacySettings.dart';
import 'package:gratitude_garden/ViewGratitude.dart';
import 'package:gratitude_garden/main.dart';

class AddGratitude extends StatefulWidget {
  AddGratitude({this.uid, this.index, this.plant});
  final String uid;
  final int index;
  final Map<dynamic, dynamic> plant;
  @override
  _AddGratitudeState createState() => _AddGratitudeState(uid: uid, index: index, plant: plant);
}

class _AddGratitudeState extends State<AddGratitude> {
  _AddGratitudeState({this.uid, this.index, this.plant});
  final String uid;
  final int index;
  final Map<dynamic, dynamic> plant;
  final _formKey = GlobalKey<FormState>();
  final gratitudeController = TextEditingController();
  final filter = ProfanityFilter();
  String gratitudeList = '';

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
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: true,
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
        body: Center(
          child: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus.unfocus();
            },
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 35),
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: RawMaterialButton(
                            child: Container(
                              alignment: Alignment.bottomLeft,
                              width: 60,
                                child: Icon(Icons.arrow_back),
                            ),
                            onPressed: () => Navigator.pop(context)),
                      ),
                    ],
                  ),
                  StreamBuilder(
                    stream: userref.child('plants/plant$index').onValue,
                    builder: (_context, AsyncSnapshot<Event> snapshot) {
                      if (snapshot.hasData) {
                        DataSnapshot dataValues = snapshot.data.snapshot;
                        Map<dynamic, dynamic> plantValues = dataValues.value;
                        return Column(
                          children: <Widget>[
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 50, bottom: 5),
                                  width: 90,
                                  height: 90,
                                  alignment: Alignment.centerLeft,
                                  child: Image(image: AssetImage(path)),
                                ),
                              ],
                            ),
                            Card(
                              color: Colors.blue,
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              child: Column(
                                children: [
                                  Card(
                                    margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                                    color: Colors.white,
                                    child: Padding(
                                      padding: EdgeInsets.all(16),
                                      child: Form(
                                        key: _formKey,
                                        child: TextFormField(
                                          maxLength: 100,
                                          controller: gratitudeController,
                                          maxLines: 6,
                                          decoration: InputDecoration.collapsed(hintText: "Enter gratitude here"),
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return 'Enter gratitude';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      RawMaterialButton(
                                        child: Text('Cancel', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500)),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                      SizedBox(width: 5,),
                                      RawMaterialButton(
                                        child: Text('Submit', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500)),
                                        fillColor: Colors.lightBlueAccent,
                                        onPressed: () {
                                          if(_formKey.currentState.validate()) {
                                            setState(() {
                                              gratitudeList = plantValues['gratitude'];
                                              if(gratitudeList == 'none' || gratitudeList == null) {
                                                gratitudeList = '';
                                              }
                                              int level = plantValues['level'];
                                              if(level < 3) {
                                                level++;
                                              }
                                              String cleanGratitude = filter.censor(gratitudeController.text);
                                              gratitudeList += cleanGratitude + '\n\n';
                                              userref.child('plants').child('plant$index').child('level').set(level);
                                              path = 'images/' +'${plant['type']}' + '-' + '$level' + '.png';
                                              userref.child('plants').child('plant$index').child('gratitude').set(gratitudeList).then((value)  {
                                                Navigator.pop(context);
                                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ViewGratitude(gratitude: gratitudeList, plantImage: path)))
                                                  .then((value) => setState);
                                              });
                                            });

                                          }
                                        },
                                      ),
                                      SizedBox(width: 10,),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        );
                      }
                      return LinearProgressIndicator();
                    }
                  ),
                  SizedBox(height: 200),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    gratitudeController.dispose();
  }

  void signOutUser() async {
    await FirebaseAuth.instance.signOut();
  }
}
