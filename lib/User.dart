import 'package:flutter/material.dart';
import 'package:gratitude_garden/Plant.dart';
import 'package:gratitude_garden/main.dart';

class User {
  String name;
  String email;
  String password;
  List<Plant> plants;
  List<User> friends;
  String profilePicture;
  PrivacyValues privacy;

  User(String _name, String _email, String _password, List<Plant> _plants, List<User> _friends, String _profilePicture, PrivacyValues _privacy) {
    name = _name;
    email = _email;
    password = _password;
    plants = _plants;
    friends = _friends;
    profilePicture = _profilePicture;
    privacy = _privacy;
  }

  void AddPlant(Plant _plant) {
    plants.add(_plant);
  }

  void AddFriend(User _user) {
    if(!friends.contains(_user) && this != _user) {
      friends.add(_user);
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
}