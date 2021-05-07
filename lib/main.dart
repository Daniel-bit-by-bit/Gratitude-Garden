import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/rendering.dart';
//import 'package:search_widget/search_widget.dart';
import 'package:gratitude_garden/Plant.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gratitude_garden/GGUser.dart';
import 'dart:async';

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

class TestDatabase extends StatefulWidget {
  const TestDatabase({Key key}) : super(key: key);
  @override
  _TestDatabaseState createState() => _TestDatabaseState();
}

class _TestDatabaseState extends State<TestDatabase> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final friendsController = TextEditingController();

  DatabaseReference dbref = FirebaseDatabase.instance.reference().child("users");
  List<String> friends = [];

  @override
  Widget build(BuildContext context) {
    FirebaseDatabase.instance.setPersistenceEnabled(true);
    return Scaffold(
        appBar: AppBar(
          title: Text('Database'),
        ),
        body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(10),
              child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                Column(children: [
                  TextFormField(
                    autofocus: false,
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'User Name',
                      hintText: 'Name',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter username';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    autofocus: false,
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'e.g. peterparker@marvelmail.com',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter email';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    autofocus: false,
                    controller: friendsController,
                    decoration: InputDecoration(
                      labelText: 'Number of Friends',
                      hintText: '0, 1, 2, ...',
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      friends.clear();
                      for (int i = 0; i < int.parse(value); i++) {
                        friends.add('user$i');
                      }
                      if (value.isEmpty) {
                        return 'Enter email';
                      }
                      return null;
                    },
                  ),
                  TextButton(
                    child: Text('Add'),
                    onPressed: () {
                      dbref = FirebaseDatabase.instance.reference().child("users");
                      debugPrint("button pressed");
                      if (_formKey.currentState.validate()) {
                        debugPrint("validated");
                        GGUser newUser = GGUser(nameController.text, emailController.text, 'password');
                        newUser.friends = friends;
                        debugPrint(newUser.toString());
                        dbref.push().set({
                          "name": nameController.text,
                          "email": emailController.text,
                          "friends": friends,
                        }).then((_) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Added \'${nameController.text}\'')));
                          nameController.clear();
                          debugPrint("then");
                        }).catchError((onError) {
                          debugPrint(onError.toString());
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(onError.toString())));
                        });
                        setState(() {
                          nameController.clear();
                          emailController.clear();
                          passwordController.clear();
                          friendsController.clear();
                        });
                      } else {}
                    },
                  ),
                  TextButton(
                    child: Text('View Data'),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DataList()));
                    },
                  ),
                  TextButton(
                    child: Text('Clear Data'),
                    onPressed: () {
                      dbref = FirebaseDatabase.instance.reference();
                      dbref.remove();
                    },
                  ),
                ]),
              ]),
            )
        )
    );
  }
}

class DataList extends StatefulWidget {
  DataList({Key key}) : super(key: key);

  @override
  _DataListState createState() => _DataListState();
}

class _DataListState extends State<DataList> {
  final dbref = FirebaseDatabase.instance.reference().child("Users");
  List<Map<dynamic, dynamic>> lists = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Data')),
      body: StreamBuilder(
        stream: dbref.onValue,
        builder: (context, AsyncSnapshot<Event> snapshot) {
          if (snapshot.hasData) {
            debugPrint('has data');
            lists.clear();
            DataSnapshot dataValues = snapshot.data.snapshot;
            Map<dynamic, dynamic> values = dataValues.value;
            debugPrint(values.toString());
            if (values != null) {
              values.forEach((key, values) {
                lists.add(values);
              });
            } else {
              return LinearProgressIndicator();
            }
            return new ListView.builder(
                itemCount: lists.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Name: " + lists[index]["name"]),
                          Text("Email: " + lists[index]["email"]),
                          Text("Friends: " + lists[index]["friends"].toString()),
                        ],
                      ),
                    ),
                  );
                }
              );
          } else {
            debugPrint("no data");
          }
          return LinearProgressIndicator();
        }
      )
    );
  }
}

class StartUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(child: Text('Gratitude Garden')),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Image(image: AssetImage('images/GG.jpg')),
            Container(
              height: 100,
              width: 400,
              color: Colors.green[400],
              child: Center(
                child: Text(
                  'Planting Gratitude with the Right Attitude',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ElevatedButton(
              child: Text('Sign In'),
              onPressed: () {
                Navigator.pushNamed(context, '/sign_in');
              },
            ),
            ElevatedButton(
              child: Text('Create an Account'),
              onPressed: () {
                Navigator.pushNamed(context, '/create_account');
              },
            ),
            RawMaterialButton(
              fillColor: Colors.red,
              padding: EdgeInsets.all(12),
              child: Text('Enter the Database'),
              onPressed: () {
                Navigator.pushNamed(context, '/database_test');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppBar(
                  title: Center(child: Text('Gratitude Garden')),
                ),
                Container(width: width, height: height * 0.25, child: Image(image: AssetImage('images/GG.jpg'))),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Sign In',
                        style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
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
                      Text(
                        'Forget Password?',
                        style: TextStyle(fontSize: 12.0),
                      ),
                      ElevatedButton(
                        child: Text('Login'),
                        onPressed: () {
                          signInUser(emailController.text, passwordController.text);
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => createAccount()));
                  },
                  child: Text.rich(
                    TextSpan(
                      text: 'Don\'t have an account? ',
                      children: [
                        TextSpan(text: 'Sign Up'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signInUser(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text).then((result) {
        debugPrint('sign in');
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
                    }
                  )
              ]);
            }
          );
        }
      );
    } on FirebaseAuthException catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(title: Text('Error'), content: Text(e.message), actions: [
            TextButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                })
          ]);
        }
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
}

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

class createAccount extends StatefulWidget {
  @override
  _createAccountState createState() => _createAccountState();
}

class _createAccountState extends State<createAccount> {
  final _formKey = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseReference dbref = FirebaseDatabase.instance.reference().child("Users");
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
                          dbref = FirebaseDatabase.instance.reference().child("Users");
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
    auth.createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text).then((result) {
      dbref.child(result.user.uid).set({
        'name': nameController.text,
        'email': emailController.text,
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
    List<Widget> pages = <Widget>[GardenPage(context), FriendsPage()];
    return MaterialApp(
      title: 'My Garden',
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
                              child: Text(''),
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

Widget GardenPage(BuildContext context) {
  user.plants = plants;

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

  Column _BuildPlantColumn(String label, int index1, int index2, int index3) {
    return Column(
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
              _BuildPlantButton(user.plants, index1),
              _BuildPlantButton(user.plants, index2),
              _BuildPlantButton(user.plants, index3),
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

  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      _BuildPlantColumn('Plants 1-3', 0, 1, 2),
      _BuildPlantColumn('Plants 4-6', 3, 4, 5),
      _BuildPlantColumn('Plants 7-9', 6, 7, 8),
      _BuildPlantColumn('El Big Boi\'s', 9, 10, 11),
    ],
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
  //File _image;
  final imagePicker = ImagePicker();
  Future getImage() async {
    final pickedFile = await imagePicker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        //user.profilePicture = pickedFile;
      }
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
                  ),
                  TextButton(
                    child: Text(
                      'Change Profile Picture',
                      style: style,
                    ),
                    //onPressed: getImage,
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

class ViewGratitude extends StatefulWidget {
  @override
  _ViewGratitudeState createState() => _ViewGratitudeState();
}

class _ViewGratitudeState extends State<ViewGratitude> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('View Gratitude', style: TextStyle(fontSize: 16))),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                image: DecorationImage(
                  image: AssetImage('images/plant01.png'),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            Expanded(
              child: Container(
                  padding: EdgeInsets.all(20),
                  child: Container(
                      color: Colors.blue,
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text('My Gratitude', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16)),
                          ),
                          Expanded(
                              child: Container(
                                  color: Colors.white,
                                  padding: EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 10),
                                  child: Scrollbar(
                                    isAlwaysShown: true,
                                    child: SingleChildScrollView(
                                      padding: EdgeInsets.only(right: 15),
                                      child: Text(user.plants[0].PrintGratitude(), style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
                                    ),
                                  ))),
                        ],
                      ))),
            )
          ],
        ),
      ),
    );
  }
}

class AddGratitude extends StatefulWidget {
  @override
  _AddGratitudeState createState() => _AddGratitudeState();
}

class _AddGratitudeState extends State<AddGratitude> {
  final gratitudeController = TextEditingController();

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
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('images/spiderman.png'),
                          fit: BoxFit.cover,
                        )),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Peter Parker',
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
                ],
              ),
            ],
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
        body: Column(
          children: <Widget>[
            Card(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  controller: gratitudeController,
                  maxLines: 8,
                  decoration: InputDecoration.collapsed(hintText: "Enter gratitude here"),
                ),
              ),
            ),
            ElevatedButton(
              child: Text('Submit'),
              onPressed: () {
                user.plants[0].AddGratitude(gratitudeController.text);
                Navigator.pushReplacementNamed(context, '/view_gratitude');
              },
            ),
          ],
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
