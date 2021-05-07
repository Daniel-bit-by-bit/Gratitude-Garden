import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class Plant {
  String id;
  String image;
  List<String> gratitude;

  Plant(String _image) {
    image = _image;
    gratitude = [];
  }

  Plant.fromSnapshot(DataSnapshot snapshot) :
        id = '<this is a plant>';

  toJson() {
    return {
      'id': id,
    };
  }

  AssetImage GetImage() {
    return AssetImage(image);
  }

  void AddGratitude(String message) {
    gratitude.add(message);
  }

  String PrintGratitude() {
    String message = "";
    for(int i = 0; i < gratitude.length; i++) {
        message += gratitude[i] + '\n\n';
      }
    return message;
  }
}