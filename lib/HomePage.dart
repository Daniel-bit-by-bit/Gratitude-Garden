import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart';

// dart
import 'package:gratitude_garden/PlantPressed.dart';
import 'package:gratitude_garden/MyAccountSettings.dart';
import 'package:gratitude_garden/PrivacySettings.dart';
import 'package:gratitude_garden/FriendsList.dart';
import 'package:gratitude_garden/AddFriends.dart';
import 'package:gratitude_garden/main.dart';

class HomePage extends StatefulWidget {
  HomePage({this.uid});
  final String uid;
  @override
  _HomePageState createState() => _HomePageState(uid: uid);

}

class _HomePageState extends State<HomePage> {
  _HomePageState({this.uid});
  final String uid;

  List<Map<dynamic, dynamic>> lists = [];
  int navIndex = 0;

  @override
  Widget build(BuildContext context) {
    DatabaseReference userref = FirebaseDatabase(
        databaseURL: 'https://gratitude-garden-83e02-default-rtdb.firebaseio.com/'
    ).reference().child('Users').child(uid);
    List<Widget> pages = <Widget>[GardenPage(context, uid), FriendsPage(context, uid)];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Garden',
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
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.blue,
          unselectedItemColor: Colors.blue[900],
          fixedColor: Colors.white,
          currentIndex: navIndex,
          onTap: (_index) {
            setState(() {
              navIndex = _index;
            });
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.apps),
              label: 'Garden',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.supervised_user_circle),
              label: 'Friends',
            ),
          ],
        ),
        body: pages[navIndex],
      ),
    );
  }

  void signOutUser() async {
    await FirebaseAuth.instance.signOut();
  }
}

Widget GardenPage(BuildContext context, String uid) {
  user.plants = plants;
  DatabaseReference plantsref = FirebaseDatabase(
      databaseURL: 'https://gratitude-garden-83e02-default-rtdb.firebaseio.com/')
      .reference()
      .child('Users')
      .child(uid)
      .child('plants');

  // Builder widgets
  Widget _BuildPlantButton(Map<dynamic, dynamic> plant, int index) {
    String path = 'images/' +'${plant['type']}' + '-' + '${plant['level']}' + '.png';
    if (path == '' || path == 'images/none-0.png') {
      return SizedBox(
        width: 100,
        height: 250,
      );
    } else {
      return RawMaterialButton(
        child: Container(
          width: 100,
          height: 250,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            image: DecorationImage(
              image: AssetImage(path),
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => PlantPressed(index: index, plant: plant, uid: uid)));
        },
      );
    }
  }

  Column _BuildPlantColumn(String label, Map<dynamic, dynamic> plant1,
      Map<dynamic, dynamic> plant2, Map<dynamic, dynamic> plant3, int index) {
    return
      Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(5),
            child: Text(
              label,
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            color: Colors.grey[300],
            height: 28,
          ),
          Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _BuildPlantButton(plant1, index),
                _BuildPlantButton(plant2, index + 1),
                _BuildPlantButton(plant3, index + 2),
              ],
            ),
            height: 88,
          ),
          Container(
            height: 15,
            color: Color.fromRGBO(239, 213, 126, 1),
          ),
          Container(
            height: 5,
            color: Color.fromRGBO(227, 181, 87, 1),
          ),
        ],
      );
  }

  return StreamBuilder(
      stream: plantsref.onValue,
      builder: (_context, AsyncSnapshot<Event> snapshot) {
        if (snapshot.hasData) {
          DataSnapshot dataValues = snapshot.data.snapshot;
          Map<dynamic, dynamic> values = dataValues.value;
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _BuildPlantColumn('Plants 1-3', values['plant1'], values['plant2'], values['plant3'], 1),
              _BuildPlantColumn('Plants 4-6', values['plant4'], values['plant5'], values['plant6'], 4),
              _BuildPlantColumn('Plants 7-9', values['plant7'], values['plant8'], values['plant9'], 7),
              _BuildPlantColumn('El Big Boi\'s', values['plant10'], values['plant11'], values['plant12'], 10),
            ],
          );
        }
        return LinearProgressIndicator();
      }
  );
}

Widget FriendsPage(BuildContext context, String uid) {
  // Builder widgets
  return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      backgroundColor: Colors.white,
      title: Text(
        'Friends',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.blue),
      ),
    ),
    body: Column(
      children: [
        TextButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => AddFriends()));
              },
          child: Container(
            padding: EdgeInsets.only(left: 10, top: 12, right: 10, bottom: 12),
            child: Row(
              children: [
                Icon(Icons.group_add_outlined),
                SizedBox(width: 16,),
                Text('Add Friends'),
                Icon(Icons.arrow_forward_ios_rounded),
                SizedBox(width: 5,)
              ],
             ),
            ),
           ),

        TextButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => FriendsList()));
          },
          child: Container(
            padding: EdgeInsets.only(left: 10, top: 12, right: 10, bottom: 12),
            child: Row(
              children: [
                Icon(Icons.group_rounded),
                SizedBox(width: 16,),
                Text('My Friends'),
                Icon(Icons.arrow_forward_ios_rounded),
                SizedBox(width: 5,)
           ],
          ),
         ),
        ),
       ],
      ),
    );
}