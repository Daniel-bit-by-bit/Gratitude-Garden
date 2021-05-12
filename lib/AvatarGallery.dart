import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class AvatarGallery extends StatefulWidget {
  String uid;
  AvatarGallery({this.uid});
  @override
  _AvatarGalleryState createState() => _AvatarGalleryState(uid: uid);
}

class _AvatarGalleryState extends State<AvatarGallery> {
  String uid;
  _AvatarGalleryState({this.uid});

  List<String> avatars = ['Panda', 'Gorilla', 'Zebra', 'Lion', 'Sloth', 'Viper', 'Eagle',
    'Giraffe', 'Cat', 'Dog', 'Mouse', 'Chicken', 'Skunk', 'Dolphin', 'Shark', 'Octopus',
    'Dragon', 'Fox', 'Otter', 'Ferret', 'Deer', 'Rhino', 'Elephant', 'Cheetah', 'Leopard',
    'Tiger', 'Moose', 'Goose', 'Whale', 'Crab', 'Lobster', 'Falcon', 'Hedgehog', 'Robot'
    'Penguin', 'Polar Bear'];

  List<Widget> buildList(List<String> avatars) {
    DatabaseReference userref = FirebaseDatabase(
        databaseURL: 'https://gratitude-garden-83e02-default-rtdb.firebaseio.com/'
    ).reference().child('Users').child(uid);
    Widget listWidget (String label) {
      return RawMaterialButton(
        child: Container(
          alignment: Alignment.center,
          width: 100,
          height: 100,
          color: Colors.grey,
          child: Container(
            alignment: Alignment.center,
              width: 92,
              height: 92,
            padding: EdgeInsets.all(0),
            color: Colors.white,
            child: Text(label)
          ),
        ),
        onPressed: () {
          userref.child('avatar').set(label);
          Navigator.pop(context);
        }
      );
    }
    List<Widget> list = [];

    list.add(RawMaterialButton(
        child: Container(
          alignment: Alignment.center,
          width: 100,
          height: 100,
          child: Container(
              child: Text('none')
          ),
        ),
        onPressed: () {
          userref.child('avatar').set('none');
          Navigator.pop(context);
        }
    ));
    for(int i = 0; i < avatars.length; i++) {
      list.add(listWidget(avatars[i]));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {

    List<Widget> list = buildList(avatars);

    return Scaffold(
      appBar: AppBar(title: Text('Choose Avatar'),),
      body: GridView.count(
        scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(5),
          crossAxisCount: 4,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          children: List.generate(list.length, (index) {
            return Center(
              child: list[index],
            );
          })
        ),
    );
  }
}
