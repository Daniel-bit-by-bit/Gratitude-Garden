import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/rendering.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

// dart
import 'package:gratitude_garden/GGUser.dart';
import 'package:gratitude_garden/Plant.dart';
import 'package:gratitude_garden/AddGratitude.dart';
import 'package:gratitude_garden/PlantPressed.dart';
import 'package:gratitude_garden/SignIn.dart';
import 'package:gratitude_garden/StartUp.dart';
import 'package:gratitude_garden/ViewGratitude.dart';
import 'package:gratitude_garden/createAccount.dart';
import 'package:gratitude_garden/HomePage.dart';
import 'package:gratitude_garden/MyAccountSettings.dart';
import 'package:gratitude_garden/PrivacySettings.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class AddFriends extends StatefulWidget {
  const AddFriends({Key key}) : super(key: key);

  @override
  _AddFriendsState createState() => _AddFriendsState();
}

class _AddFriendsState extends State<AddFriends> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Center(
            child: Column(
              children: [
                Text(
                  'Add Friends',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20, color: Colors.blue),
                ),
              ],
            ),
          ),
        ),
      body: buildFloatingSearchBar(context),
      );
  }
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    resizeToAvoidBottomInset: false,
    body: Stack(
      fit: StackFit.expand,
      children: [
        buildFloatingSearchBar(context),
      ],

    ),
  );
}


Widget buildFloatingSearchBar(BuildContext context) {
  final dbref = FirebaseDatabase(
      databaseURL: 'https://gratitude-garden-83e02-default-rtdb.firebaseio.com/'
  ).reference().child("Users");
  List<Map<dynamic, dynamic>> lists = [];

  final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

  return FloatingSearchBar(
    hint: 'Search...',
    scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
    transitionDuration: const Duration(milliseconds: 800),
    transitionCurve: Curves.easeInOut,
    physics: const BouncingScrollPhysics(),
    axisAlignment: isPortrait ? 0.0 : -1.0,
    openAxisAlignment: 0.0,
    width: isPortrait ? 600 : 500,
    debounceDelay: const Duration(milliseconds: 500),
    onQueryChanged: (query) {
      // Call your model, bloc, controller here.
    },
    // Specify a custom transition to be used for
    // animating between opened and closed stated.
    transition: CircularFloatingSearchBarTransition(),
    actions: [
      FloatingSearchBarAction(
        showIfOpened: false,
        child: CircularButton(
          icon: const Icon(Icons.person_search_outlined),
          onPressed: () {},
        ),
      ),
      FloatingSearchBarAction.searchToClear(
        showIfClosed: false,
      ),
    ],
    builder: (context, transition) {
      return StreamBuilder(
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
              return ClipRRect(
                  borderRadius: BorderRadius.circular(8),
            child: Material(
            color: Colors.white,
            elevation: 4.0,
            child: ListView.builder(
            itemCount: lists.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0)),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Name: " + lists[index]["name"]),
                          Text("Email: " + lists[index]["email"]),
                          Text("Friends: " +
                              lists[index]["plants"].toString()),
                          Text("Friends: " +
                              lists[index]["friends"].toString()),
                          Text("Privacy: " +
                              PrivacyValues.values[(lists[index]["privacy"])]
                                  .toString()),
                        ],
                      ),
                    ),
                  );
                }
            ),
            ),
            );
            } else {
              debugPrint("no data");
            }
            return LinearProgressIndicator();
          }
      );
    },
  );
}
