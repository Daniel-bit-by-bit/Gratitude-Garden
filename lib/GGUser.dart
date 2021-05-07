import 'package:flutter/material.dart';
import 'package:gratitude_garden/Plant.dart';
import 'package:gratitude_garden/main.dart';

class GGUser {
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
    privacy = PrivacyValues.OnlyFriends;;
  }

  void AddPlant(Plant _plant) {
    plants.add(_plant);
  }

  void AddFriend(GGUser _user) {
    if(!friends.contains(_user) && this != _user) {
      friends.add(_user.toString());
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