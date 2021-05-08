import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/rendering.dart';
//import 'package:search_widget/search_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

// dart
import 'package:gratitude_garden/GGUser.dart';
import 'package:gratitude_garden/Plant.dart';
import 'package:gratitude_garden/AddGratitude.dart';
import 'package:gratitude_garden/DataList.dart';
import 'package:gratitude_garden/PlantPressed.dart';
import 'package:gratitude_garden/SignIn.dart';
import 'package:gratitude_garden/StartUp.dart';
import 'package:gratitude_garden/TestDatabase.dart';
import 'package:gratitude_garden/ViewGratitude.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => StartUp(),
        '/sign_in': (context) => SignIn(),
        '/create_account': (context) => createAccount(),
        '/feed_gratitude': (context) => AddGratitude(),
        '/view_gratitude': (context) => ViewGratitude(),
        //'/send_a_plant': (context) => SendAPlant(),
        '/database_test': (context) => TestDatabase(),
      },
    ),
  );
}


class createAccount extends StatefulWidget {
  @override
  _createAccountState createState() => _createAccountState();
}

class _createAccountState extends State<createAccount> {
  final _formKey = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseReference dbref = FirebaseDatabase(
      databaseURL: 'https://gratitude-garden-83e02-default-rtdb.firebaseio.com/'
  ).reference().child("Users");
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final friendsController = TextEditingController();
  List<dynamic> friends = [];

  @override
  Widget build(BuildContext context) {
    FirebaseDatabase.instance.setPersistenceEnabled(true);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Gratitude Garden')),
      ),
      body: Container(
        height: height,
        width: width,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: width,
                    height: height * 0.30,
                    child: Image(image: AssetImage('images/GG.jpg'))),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Create Account',
                        style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: 'Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter name';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 30.0,
                ),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    suffixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter email';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 30.0,
                ),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    suffixIcon: Icon(Icons.visibility_off),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter password';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 30.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        child: Text('Create Account'),
                        onPressed: () {
                          dbref = FirebaseDatabase(
                              databaseURL: 'https://gratitude-garden-83e02-default-rtdb.firebaseio.com/'
                          ).reference().child("Users");
                          if (_formKey.currentState.validate()) {
                            registerUser();
                          }
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignIn()));
                  },
                  child: Text.rich(
                    TextSpan(
                      text: 'Already have an account? ',
                      children: [
                        TextSpan(text: 'Sign In'),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 50.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void registerUser() {
    Map<dynamic, dynamic> tree = {'type': 'tree', 'level': '1', 'gratitude': []};
    Map<dynamic, dynamic> cactus = {'type': 'cactus', 'level': '3'};

    auth.createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text).then((result) {
      dbref.child(result.user.uid).set({
        'name': nameController.text,
        'email': emailController.text,
        'plants': {
          'plant1': {
            'type': 'tree',
            'level': '1',
            'gratitude': []
          },
          'plant2': {
            'type': 'none',
            'level': '0',
            'gratitude': []
          },
          'plant3': {
            'type': 'none',
            'level': '0',
            'gratitude': []
          },
          'plant4': {
            'type': 'none',
            'level': '0',
            'gratitude': []
          },
          'plant5': {
            'type': 'none',
            'level': '0',
            'gratitude': []
          },
          'plant6': {
            'type': 'none',
            'level': '0',
            'gratitude': []
          },
          'plant7': {
            'type': 'none',
            'level': '0',
            'gratitude': []
          },
          'plant8': {
            'type': 'none',
            'level': '0',
            'gratitude': []
          },
          'plant9': {
            'type': 'none',
            'level': '0',
            'gratitude': []
          },
          'plant10': {
            'type': 'none',
            'level': '0',
            'gratitude': []
          },
          'plant11': {
            'type': 'none',
            'level': '0',
            'gratitude': []
          },
          'plant12': {
            'type': 'none',
            'level': '0',
            'gratitude': []
          },
        },
        'friends': ['friend_uid'],
        'privacy': 0,
      });
      debugPrint('push');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Garden(uid: result.user.uid)),
      );
    }).catchError((onError) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(title: Text('Error'), content: Text(onError.message), actions: [
              TextButton(
                  child: Text('Ok'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  })
            ]);
          });
    });
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    friendsController.dispose();
  }
}

List<Plant> plants = [
  new Plant('images/plant1-2.png'),
  new Plant('images/plant1-0.png'),
  new Plant('images/plant1-3.png'),
  new Plant('images/plant1-2.png')
];
GGUser user = new GGUser(
    'Peter Parker',
    'peterparker@marvelmail.com',
    'iamspiderman123'
);

class Garden extends StatefulWidget {
  Garden({this.uid});
  final String uid;
  @override
  _GardenState createState() => _GardenState(uid: uid);
}

class _GardenState extends State<Garden> {
  _GardenState({this.uid});
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

class MyAccountSettings extends StatefulWidget {
  @override
  _MyAccountSettingsState createState() => _MyAccountSettingsState();
}

class _MyAccountSettingsState extends State<MyAccountSettings> {
  TextStyle style = TextStyle(color: Colors.blue, fontWeight: FontWeight.w500, fontSize: 16);
  final imagePicker = ImagePicker();
  Future getImage() async {
    final pickedFile = await imagePicker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      FirebaseAuth.instance.currentUser.updateProfile(photoURL: pickedFile.path).then((result) => setState);
    }
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Account',
          style: TextStyle(fontSize: 16),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
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
                    child: user.profilePicture == ''
                        ? CircleAvatar(
                      child: Text(user.name[0]),
                    )
                        : CircleAvatar(
                      backgroundImage: AssetImage(user.profilePicture),
                    ),
                    //Image.file(File(FirebaseAuth.instance.currentUser.photoURL)),
                  ),
                  TextButton(
                    child: Text(
                      'Change Profile Picture',
                      style: style,
                    ),
                    // onPressed: () {
                    //   getImage().then((value) =>
                    //       Navigator.push(context, MaterialPageRoute(builder: (context) => MyAccountSettings())).then((value) => setState));
                    // },
                      onPressed: () {
                        user.profilePicture = user.profilePicture == '' ? 'images/spiderman.png' : '';
                        setState(() {});
                      },
                      ),
                      ],
                      ),
                      SizedBox(height: 20),
                      Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      Text('Name', style: style),
                      Text(user.name, style: style),
                      ],
                      ),
                      SizedBox(height: 20),
                      Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      Text('Email', style: style),
                      Text(user.email, style: style),
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
        ),
      ),
    );
  }
}

enum PrivacyValues { OnlyFriends, Everyone }

class PrivacySettings extends StatefulWidget {
  @override
  _PrivacySettingsState createState() => _PrivacySettingsState();
}

class _PrivacySettingsState extends State<PrivacySettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Account',
          style: TextStyle(fontSize: 16),
        ),
      ),
      body: Container(
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
                        Radio<PrivacyValues>(
                          activeColor: Colors.blue,
                          groupValue: user.privacy,
                          value: PrivacyValues.OnlyFriends,
                          onChanged: (PrivacyValues _value) {
                            setState(() {
                              user.privacy = _value;
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
                        Radio<PrivacyValues>(
                          groupValue: user.privacy,
                          value: PrivacyValues.Everyone,
                          onChanged: (PrivacyValues _value) {
                            setState(() {
                              user.privacy = _value;
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
      ),
    );
  }
}