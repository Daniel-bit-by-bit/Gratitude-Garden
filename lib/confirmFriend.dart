import 'package:flutter/material.dart';




class confirmFriend extends StatefulWidget {
  const confirmFriend({Key key}) : super(key: key);

  @override
  _confirmFriendState createState() => _confirmFriendState();
}

class _confirmFriendState extends State<confirmFriend> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
