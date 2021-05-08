import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

// dart
import 'package:gratitude_garden/Plant.dart';
import 'package:gratitude_garden/PlantPressed.dart';
import 'package:gratitude_garden/MyAccountSettings.dart';
import 'package:gratitude_garden/PrivacySettings.dart';
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
    List<Widget> pages = <Widget>[GardenPage(context, uid), FriendsPage()];

    return MaterialApp(
      title: 'My Garden',
      home: Scaffold(
        appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StreamBuilder(
                    stream: userref.onValue,
                    builder: (_context, AsyncSnapshot<Event> snapshot) {
                      if (snapshot.hasData) {
                        debugPrint('has data2');
                        DataSnapshot dataValues = snapshot.data.snapshot;
                        Map<dynamic, dynamic> values = dataValues.value;
                        debugPrint(values.toString());
                        return Row(
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
                            Text(values['name'],
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        );
                      }
                      return LinearProgressIndicator();
                    }
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
  DatabaseReference userref = FirebaseDatabase(
      databaseURL: 'https://gratitude-garden-83e02-default-rtdb.firebaseio.com/')
      .reference()
      .child('Users')
      .child(uid)
      .child('plants');

  // Builder widgets
  Widget _BuildPlantButton(List<Plant> plants, int index) {
    if (index >= plants.length) {
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
              image: plants[index].GetImage(),
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => PlantPressed()));
        },
      );
    }
  }

  Column _BuildPlantColumn(String label, Map<dynamic, dynamic> plant1,
      Map<dynamic, dynamic> plant2, Map<dynamic, dynamic> plant3) {
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
                //_BuildPlantButton(user.plants, plant1),
                //_BuildPlantButton(user.plants, plant2),
                //_BuildPlantButton(user.plants, plant3),
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
      stream: userref.onValue,
      builder: (_context, AsyncSnapshot<Event> snapshot) {
        if (snapshot.hasData) {
          debugPrint('has data2');
          DataSnapshot dataValues = snapshot.data.snapshot;
          Map<dynamic, dynamic> values = dataValues.value;
          debugPrint(values.toString());
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //_BuildPlantColumn('Plants 1-3', 0, 1, 2),
              //_BuildPlantColumn('Plants 4-6', 3, 4, 5),
              //_BuildPlantColumn('Plants 7-9', 6, 7, 8),
              //_BuildPlantColumn('El Big Boi\'s', 9, 10, 11),
            ],
          );
        }
        return LinearProgressIndicator();
      }
  );
}

Widget FriendsPage() {
  // Builder widgets
  return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      backgroundColor: Colors.white,
      title: Text(
        'Friends List',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.blue),
      ),
    ),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '     Online',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.blue),
        ),
        Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('images/GwenStacy.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Gwen Stacy',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blue),
            ),
          ],
        ),
        Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('images/HarryOsborn.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Harry Osborn',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blue),
            ),
          ],
        ),
        Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('images/MaryJane.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Mary Jane',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blue),
            ),
          ],
        ),
        Text(
          '     Offline',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.blue),
        ),
        Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('images/TonyStarks.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Tony Starks',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blue),
            ),
          ],
        ),
      ],
    ),
  );
}