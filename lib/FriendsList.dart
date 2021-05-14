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


class FriendsList extends StatefulWidget {
  const FriendsList({Key key}) : super(key: key);

  @override
  _FriendsListState createState() => _FriendsListState();
}

class _FriendsListState extends State<FriendsList> {
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
                'Friends List',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 20, color: Colors.blue),
              ),
            ],
          ),
        ),
      ),

      body: Column(

      ),

    );
  }
}

// Widget FriendsPage() {
//   // Builder widgets
//   return Scaffold(
//     backgroundColor: Colors.white,
//     appBar: AppBar(
//       backgroundColor: Colors.white,
//       title: Text(
//         'Friends List',
//         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.blue),
//       ),
//     ),
//     body: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           '     Online',
//           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.blue),
//         ),
//         Row(
//           children: [
//             Container(
//               width: 50,
//               height: 50,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 image: DecorationImage(
//                   image: AssetImage('images/GwenStacy.jpg'),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             SizedBox(
//               width: 10,
//             ),
//             Text(
//               'Gwen Stacy',
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blue),
//             ),
//           ],
//         ),
//         Row(
//           children: [
//             Container(
//               width: 50,
//               height: 50,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 image: DecorationImage(
//                   image: AssetImage('images/HarryOsborn.jpg'),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             SizedBox(
//               width: 10,
//             ),
//             Text(
//               'Harry Osborn',
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blue),
//             ),
//           ],
//         ),
//         Row(
//           children: [
//             Container(
//               width: 50,
//               height: 50,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 image: DecorationImage(
//                   image: AssetImage('images/MaryJane.jpg'),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             SizedBox(
//               width: 10,
//             ),
//             Text(
//               'Mary Jane',
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blue),
//             ),
//           ],
//         ),
//         Text(
//           '     Offline',
//           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.blue),
//         ),
//         Row(
//           children: [
//             Container(
//               width: 50,
//               height: 50,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 image: DecorationImage(
//                   image: AssetImage('images/TonyStarks.jpg'),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             SizedBox(
//               width: 10,
//             ),
//             Text(
//               'Tony Starks',
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blue),
//             ),
//           ],
//         ),
//       ],
//     ),
//   );
// }