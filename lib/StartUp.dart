import 'package:flutter/material.dart';

class StartUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(child: Text('Gratitude Garden')),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Image(image: AssetImage('images/GG.jpg')),
            Container(
              height: 100,
              width: 400,
              color: Colors.green[400],
              child: Center(
                child: Text(
                  'Planting Gratitude with the Right Attitude',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ElevatedButton(
              child: Text('Sign In'),
              onPressed: () {
                Navigator.pushNamed(context, '/sign_in');
              },
            ),
            ElevatedButton(
              child: Text('Create an Account'),
              onPressed: () {
                Navigator.pushNamed(context, '/create_account');
              },
            ),
          ],
        ),
      ),
    );
  }
}
