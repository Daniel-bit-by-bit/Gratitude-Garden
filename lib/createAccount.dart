import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';


// dart
import 'package:gratitude_garden/SignIn.dart';
import 'package:gratitude_garden/HomePage.dart';


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
    auth.createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text).then((result) {
      dbref.child(result.user.uid).set({
        'name': nameController.text,
        'email': emailController.text,
        'plants': {
          'plant1': {
            'type': 'plant1',
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
        MaterialPageRoute(builder: (context) => HomePage(uid: result.user.uid)),
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
  }
}