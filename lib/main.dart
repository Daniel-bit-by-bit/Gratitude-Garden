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
      },
    ),
  );
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
