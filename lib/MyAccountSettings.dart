import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/rendering.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

// dart
import 'package:gratitude_garden/main.dart';

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