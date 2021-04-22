import 'package:flutter/material.dart';

class Plant {
  String image;
  List<String> gratitude;

  Plant(String _image) {
    image = _image;
    gratitude = [];
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