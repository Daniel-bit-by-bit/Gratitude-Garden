import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:firebase_database/firebase_database.dart';

// dart
import 'package:gratitude_garden/main.dart';

enum PrivacyValues { OnlyFriends, Everyone }

class PrivacySettings extends StatefulWidget {
  final String uid;
  PrivacySettings({this.uid});
  @override
  _PrivacySettingsState createState() => _PrivacySettingsState(uid: uid);
}

class _PrivacySettingsState extends State<PrivacySettings> {
  final String uid;
  _PrivacySettingsState({this.uid});
  @override
  Widget build(BuildContext context) {
    DatabaseReference userref = FirebaseDatabase(
        databaseURL: 'https://gratitude-garden-83e02-default-rtdb.firebaseio.com/'
    ).reference().child('Users').child(uid);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Account',
          style: TextStyle(fontSize: 16),
        ),
      ),
      body: StreamBuilder(
          stream: userref.onValue,
          builder: (_context, AsyncSnapshot<Event> snapshot) {
            if (snapshot.hasData) {
              DataSnapshot dataValues = snapshot.data.snapshot;
              Map<dynamic, dynamic> userValues = dataValues.value;
              return Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(left: 30, right: 20, top: 20, bottom: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Receive Plants', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500, fontSize: 20)),
                    Container(
                      padding: EdgeInsets.only(left: 24, top: 12),
                      child: Text(
                        'Let other users send me plants',
                        style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(left: 24, top: 16, right: 24),
                      child: Column(
                        children: [
                          Container(
                            height: 36,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Only Friends', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500, fontSize: 16)),
                                Radio<int>(
                                  activeColor: Colors.blue,
                                  groupValue: userValues['privacy'],
                                  value: PrivacyValues.OnlyFriends.index,
                                  onChanged: (int _value) {
                                    setState(() {
                                      userref.child('privacy').set(_value);
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            thickness: 1,
                            height: 1,
                            color: Colors.blue[100],
                            endIndent: 10,
                          ),
                          Container(
                            height: 36,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Everyone', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500, fontSize: 16)),
                                Radio<int>(
                                  groupValue: userValues['privacy'],
                                  value: PrivacyValues.Everyone.index,
                                  onChanged: (int _value) {
                                    setState(() {
                                      userref.child('privacy').set(_value);
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            thickness: 1,
                            height: 1,
                            color: Colors.blue[100],
                            endIndent: 10,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            return LinearProgressIndicator();
          }
      ),
    );
  }
}