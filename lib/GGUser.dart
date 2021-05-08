import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:firebase_database/firebase_database.dart';

// dart
import 'package:gratitude_garden/Plant.dart';
import 'package:gratitude_garden/PrivacySettings.dart';
import 'package:gratitude_garden/main.dart';

class GGUser {
  String uid;
  String name;
  String email;
  String password;
  List<Plant> plants;
  List<String> friends;
  String profilePicture;
  PrivacyValues privacy;

  GGUser(String _name, String _email, String _password) {
    name = _name;
    email = _email;
    password = _password;
    plants = [];
    friends = [];
    profilePicture = '';
    privacy = PrivacyValues.OnlyFriends;
  }

  GGUser.fromSnapshot(DataSnapshot snapshot) :
    uid = snapshot.key.toString(),
    name = snapshot.value['name'],
    email = snapshot.value['email'],
    plants = snapshot.value['plants'],
    friends = snapshot.value['friends'],
    privacy = snapshot.value['privacy'];

  toJson() {
    return {
      'uid': uid.toString(),
      'name': name,
      'email': email,
      'plants': PlantsAsStringList(),
      'friends': friends,
      'privacy': privacy.index
    };
  }

  List<String> PlantsAsStringList() {
    List<String> plantIDs = [];
    plants.forEach((element) {
      plantIDs.add(element.id);
    });
    return plantIDs;
  }

  void AddPlant(Plant _plant) {
    plants.add(_plant);
  }

  void AddFriend(GGUser _user) {
    if(!friends.contains(_user) && this != _user && user != null) {
      friends.add(_user.uid);
    }
  }

  void SetProfilePicture(String _profilePicture) {
    profilePicture = _profilePicture;
  }

  CircleAvatar GetProfilePicture() {
    if(profilePicture == '') {
      return CircleAvatar(child: Text(name[0]),);
    }
    else {
      return CircleAvatar(backgroundImage: AssetImage(profilePicture),);
    }
  }

  void SetPrivacy(PrivacyValues _privacy) {
    privacy = _privacy;
  }

  @override
  String toString() {
    return 'name: $name, email: $email, friends: ${friends.toString()}';
  }
}