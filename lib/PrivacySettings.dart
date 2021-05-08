import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// dart
import 'package:gratitude_garden/main.dart';

enum PrivacyValues { OnlyFriends, Everyone }

class PrivacySettings extends StatefulWidget {
  @override
  _PrivacySettingsState createState() => _PrivacySettingsState();
}

class _PrivacySettingsState extends State<PrivacySettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Account',
          style: TextStyle(fontSize: 16),
        ),
      ),
      body: Container(
        alignment: Alignment.topLeft,
        padding: EdgeInsets.only(left: 30, right: 20, top: 20, bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Receive Plants', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500, fontSize: 20)),
            Container(
              padding: EdgeInsets.only(left: 24, top: 12),
              child: Text(
                'Let other users send me plants',
                style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500, fontSize: 16),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 24, top: 16, right: 24),
              child: Column(
                children: [
                  Container(
                    height: 36,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Only Friends', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500, fontSize: 16)),
                        Radio<PrivacyValues>(
                          activeColor: Colors.blue,
                          groupValue: user.privacy,
                          value: PrivacyValues.OnlyFriends,
                          onChanged: (PrivacyValues _value) {
                            setState(() {
                              user.privacy = _value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 1,
                    height: 1,
                    color: Colors.blue[100],
                    endIndent: 10,
                  ),
                  Container(
                    height: 36,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Everyone', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500, fontSize: 16)),
                        Radio<PrivacyValues>(
                          groupValue: user.privacy,
                          value: PrivacyValues.Everyone,
                          onChanged: (PrivacyValues _value) {
                            setState(() {
                              user.privacy = _value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 1,
                    height: 1,
                    color: Colors.blue[100],
                    endIndent: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}