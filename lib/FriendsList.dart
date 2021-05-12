import 'package:flutter/material.dart';

class FriendsList extends StatefulWidget {
  const FriendsList({Key key}) : super(key: key);

  @override
  _FriendsListState createState() => _FriendsListState();
}

class _FriendsListState extends State<FriendsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

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