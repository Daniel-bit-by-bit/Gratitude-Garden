import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';



class confirmFriend extends StatefulWidget {

  confirmFriend({this.uid});
  final String uid;

  @override
  _confirmFriendState createState() => _confirmFriendState(uid: uid);
}

class _confirmFriendState extends State<confirmFriend> {
  _confirmFriendState({this.uid});
  final String uid;
  @override

  Widget build(BuildContext context) {
    DatabaseReference userref = FirebaseDatabase(
        databaseURL: 'https://gratitude-garden-83e02-default-rtdb.firebaseio.com/'
    ).reference().child('Users').child(uid);
    return MaterialApp(
      home: Scaffold(
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
      body: Container(
        child: Column(
          children: <Widget> [
            SizedBox(height: 30),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
        padding: EdgeInsets.only(top: 10, bottom: 10),
            margin: EdgeInsets.only(top: 100, bottom: 10),
        height: 180,
        width: 220,
        color: Colors.blue,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [Text('Are you sure you want to send this plant to ', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16)) ],
      )

      )
      ]
    )
    ]
    )
    )
    )


    );
  }
}
