import 'package:gratitude_garden/GGUser.dart';import 'package:flutter/material.dart';
import 'package:gratitude_garden/main.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:gratitude_garden/DataList.dart';

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

  DatabaseReference dbref = FirebaseDatabase(
      databaseURL: 'https://gratitude-garden-83e02-default-rtdb.firebaseio.com/'
  ).reference().child("Users");
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
                      dbref = FirebaseDatabase(
                          databaseURL: 'https://gratitude-garden-83e02-default-rtdb.firebaseio.com/'
                      ).reference().child("Users");
                      debugPrint("button pressed");
                      if (_formKey.currentState.validate()) {
                        debugPrint("validated");
                        GGUser newUser = GGUser(nameController.text, emailController.text, 'password');
                        newUser.plants = plants;
                        newUser.friends = friends;
                        debugPrint(newUser.toString());
                        dbref.push().set(newUser.toJson()/*{
                          "name": nameController.text,
                          "email": emailController.text,
                          "friends": friends,
                        }*/).then((_) {
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
                      dbref = FirebaseDatabase(
                          databaseURL: 'https://gratitude-garden-83e02-default-rtdb.firebaseio.com/'
                      ).reference();
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
