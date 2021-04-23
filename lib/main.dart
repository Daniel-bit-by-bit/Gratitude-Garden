import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/rendering.dart';
//import 'package:search_widget/search_widget.dart';
import 'package:gratitude_garden/User.dart';
import 'package:gratitude_garden/Plant.dart';

void main() {
  runApp(MaterialApp(
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
  ));
}

class StartUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(child: Text('Gratitude Garden')),
      ),
      body: Center(
          child: Column(children: <Widget>[
            Image(image: AssetImage('images/GG.jpg')),
            Container(
              height: 100,
              width: 400,
              color: Colors.green[400],
              child: Center(
                child: Text('Planting Gratitude with the Right Attitude',
                    style: TextStyle(fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold,),),
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

//Image(image: AssetImage('images/GG.jpg'))

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppBar(
                title: Center(child: Text('Gratitude Garden')),
              ),
              Container(
                  width: width,
                  height: height * 0.25,
                  child: Image(image: AssetImage('images/GG.jpg'))),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Sign In',
                      style: TextStyle(
                          fontSize: 25.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30.0,),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Email',
                  suffixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
               ),
              SizedBox(height: 30.0,),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                  suffixIcon: Icon(Icons.visibility_off),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                 ),
                ),
              SizedBox(height: 30.0,),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Forget Password?', style: TextStyle(fontSize: 12.0),),
                    ElevatedButton(
                      child: Text('Login'),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Garden()));
                        },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Second()));
                },
                child: Text.rich(
                  TextSpan(
                    text: 'Don\'t have an account? ',
                    children: [
                      TextSpan(
                        text: 'Sign Up'
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Second extends StatefulWidget {
  @override
  _SecondState createState() => _SecondState();
}

class _SecondState extends State<Second> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppBar(
                title: Center(child: Text('Gratitude Garden')),
              ),
              Container(
                  width: width,
                  height: height * 0.45,
                  child: Image(image: AssetImage('images/GG.jpg'))),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Sign Up',
                      style: TextStyle(
                          fontSize: 25.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30.0,),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Email',
                  suffixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              SizedBox(height: 30.0,),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                  suffixIcon: Icon(Icons.visibility_off),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              SizedBox(height: 30.0,),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Forget Password?', style: TextStyle(fontSize: 12.0),),
                    ElevatedButton(
                      child: Text('Sign Up'),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn()));
                },
                child: Text.rich(
                  TextSpan(
                    text: 'Already have an account',
                    children: [
                      TextSpan(text: 'Sign In'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class PlantPressed extends StatefulWidget {
  @override
  _PlantPressedState createState() => _PlantPressedState();
}

class _PlantPressedState extends State<PlantPressed> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 45,
                    height: 45,
                    child: user.GetProfilePicture(),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    user.name,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Gratitude Garden',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    splashRadius: 24,
                    icon: Icon(Icons.menu),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Settings()));
                    },
                  )
                ], //row children 2
              ),
            ], //row children1
          ),
        ),

        body: Container(
          width: 400,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(alignment: Alignment.topCenter),
                    Container(height: 200, width: 200, child: Image(image: AssetImage('images/plant01.png')),),
                  ],//children-inner
                ),//row1
                SizedBox(height: 40),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                      Container(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                          height: 180,
                          width: 220,
                          color: Colors.blue,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children:[
                                Container(width: 190, height: 40, color: Colors.lightBlueAccent, child: TextButton(child: Text('Feed Gratitude', style: TextStyle(fontSize: 16, color: Colors.white)), onPressed:() {Navigator.pushNamed(context, '/feed_gratitude');} )),
                                Container(width: 190, height: 40, color: Colors.lightBlueAccent, child: TextButton(child: Text('View Gratitude', style: TextStyle(fontSize: 16, color: Colors.white)), onPressed:() {Navigator.pushNamed(context, '/view_gratitude');} )),
                                Container(width: 190, height: 40, color: Colors.lightBlueAccent, child: TextButton(child: Text('Send a Plant',  style: TextStyle(fontSize: 16, color: Colors.white)), onPressed:() {Navigator.pushNamed(context, '/send_a_plant');} )),
                              ]) //children
                      ),
                    ]
                )
              ]),
        ),//children-outer
      ),
    );
  }
}


class createAccount extends StatefulWidget {
  @override
  _createAccountState createState() => _createAccountState();
}

class _createAccountState extends State<createAccount> {
  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              AppBar(
                title: Center(child: Text('Gratitude Garden')),
              ),
              Container(
                  width: width,
                  height: height*0.30,
                  child: Image(image: AssetImage('images/GG.jpg'))
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Create Account', style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
              SizedBox(height: 30.0,),
              TextField(
                onChanged: (value) {
                  user.name = value;
                },
                decoration: InputDecoration(
                  hintText: 'Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              SizedBox(height: 30.0,),
              TextField(
                onChanged: (value) {
                  user.email = value;
                },
                decoration: InputDecoration(
                  hintText: 'Email',
                  suffixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              SizedBox(height: 30.0,),
              TextField(
                onChanged: (value) {
                  user.password = value;
                },
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                  suffixIcon: Icon(Icons.visibility_off),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              SizedBox(height: 30.0,),
              Padding(
                padding: const EdgeInsets.all (5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      child: Text('Create Account'),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Garden()));
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn()));
                },
                child: Text.rich(
                  TextSpan(
                    text: 'Already have an account? ',
                    children: [
                      TextSpan(
                          text: 'Sign In'
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<Plant> plants = [new Plant('images/plant1-2.png'), new Plant('images/plant1-0.png'), new Plant('images/plant1-3.png'), new Plant('images/plant1-2.png')];
User user = new User('Peter Parker', 'peterparker@marvelmail.com', 'iamspiderman123', plants, [], '', PrivacyValues.OnlyFriends);

class Garden extends StatefulWidget {
  @override
  _GardenState createState() => _GardenState();
}
class _GardenState extends State<Garden> {

  int navIndex = 0;
  @override
  Widget build (BuildContext context) {
    List<Widget> pages = <Widget> [GardenPage(context), FriendsPage()];
    return MaterialApp(
      title: 'My Garden',
      home: Scaffold(
        appBar: AppBar(
            title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 45,
                  height: 45,
                  child: user.GetProfilePicture(),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  user.name,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'Gratitude Garden',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  width: 10,
                ),
                IconButton(
                  visualDensity: VisualDensity.compact,
                  splashRadius: 24,
                  icon: Icon(Icons.menu),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Settings())).then((value) => setState(() {}));
                  },
                ),
              ],
            ),
          ],
        )
            //Center(child: Text('Gratitude Garden')),
            ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.blue,
          unselectedItemColor: Colors.blue[900],
          fixedColor: Colors.white,
          currentIndex: navIndex,
          onTap: (_index) {
            setState(() {
              navIndex = _index;
            });
          },
          items: const <BottomNavigationBarItem> [
            BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'Garden',),
            BottomNavigationBarItem(icon: Icon(Icons.supervised_user_circle), label: 'Friends',),
          ],
        ),
        body: pages[navIndex],
      ),
    );
  }
}

Widget GardenPage(BuildContext context) {
  // Builder widgets
  Widget _BuildPlantButton(List<Plant> plants, int index) {
    if(index >= plants.length) {
        return SizedBox(width: 100, height: 250,);
    }
    else {
      return RawMaterialButton(
        child: Container(
          width: 100, height: 250,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            image: DecorationImage(image: plants[index].GetImage(), fit: BoxFit.fitHeight,
            ),
          ),
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      PlantPressed()));
        } ,
      );
    }
  }
  Column _BuildPlantColumn(String label, int index1, int index2, int index3) {
    return Column (
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.all(5),
          child: Text(label, style: TextStyle(fontSize: 16, color: Colors.grey[600]),),
          color: Colors.grey[300],
          height: 28,
        ),
        Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _BuildPlantButton(user.plants, index1),
              _BuildPlantButton(user.plants, index2),
              _BuildPlantButton(user.plants, index3),
            ],
          ),
          height: 88,
        ),
        Container(
          height: 15,
          color: Color.fromRGBO(239, 213, 126, 1),
        ),
        Container(
          height: 5,
          color: Color.fromRGBO(227, 181, 87, 1),
        ),
      ],
    );
  }
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      _BuildPlantColumn('Plants 1-3', 0, 1, 2),
      _BuildPlantColumn('Plants 4-6', 3, 4, 5),
      _BuildPlantColumn('Plants 7-9', 6, 7, 8),
      _BuildPlantColumn('El Big Boi\'s', 9, 10, 11),
    ],
  );
}
Widget FriendsPage() {
  // Builder widgets
  return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      backgroundColor: Colors.white,
      title: Text('Friends List', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.blue),),
    ),
    body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('     Online', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.blue),),
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(image: AssetImage('images/GwenStacy.jpg'), fit: BoxFit.cover,),
                  ),
                ),
                SizedBox(width: 10,),
                Text('Gwen Stacy', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blue),),
              ],
            ),
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(image: AssetImage('images/HarryOsborn.jpg'), fit: BoxFit.cover,),
                  ),
                ),
                SizedBox(width: 10,),
                Text('Harry Osborn', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blue),),
              ],
            ),
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(image: AssetImage('images/MaryJane.jpg'), fit: BoxFit.cover,),
                  ),
                ),
                SizedBox(width: 10,),
                Text('Mary Jane', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blue),),
              ],
            ),
            Text('     Offline', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.blue),),
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(image: AssetImage('images/TonyStarks.jpg'), fit: BoxFit.cover,),
                  ),
                ),
                SizedBox(width: 10,),
                Text('Tony Starks', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blue),),
              ],
            ),
      ],
    ),
  );
}

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}
class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings', style: TextStyle(fontSize: 16),),
      ),
      body: Column(
        children: [
          TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MyAccountSettings())).then((value) => setState(() {}));
            },
            child: Container (
              padding: EdgeInsets.only(left: 10, top: 12, right: 10, bottom: 12),
              child: Row(
                  children: [
                    Icon(Icons.account_circle),
                    SizedBox(width: 16,),
                    Text('My Account')]),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => PrivacySettings()));},
            child: Container (
              padding: EdgeInsets.only(left: 10, top: 12, right: 10, bottom: 12),
              child: Row(
                  children: [
                    Icon(Icons.lock),
                    SizedBox(width: 16,),
                    Text('Privacy')]),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.popUntil(context, ModalRoute.withName('/'));
            },
            child: Container (
              padding: EdgeInsets.only(left: 10, top: 12, right: 10, bottom: 12),
              child: Row(
                  children: [
                    Icon(Icons.logout),
                    SizedBox(width: 16,),
                    Text('Log Out')]),
            ),
          ),
        ],
      ),
    );
  }
}

class MyAccountSettings extends StatefulWidget {
  @override
  _MyAccountSettingsState createState() => _MyAccountSettingsState();
}
class _MyAccountSettingsState extends State<MyAccountSettings> {
  TextStyle style = TextStyle(color: Colors.blue, fontWeight: FontWeight.w500, fontSize: 16);
  //File _image;
  final imagePicker = ImagePicker();
  Future getImage() async {
    final pickedFile = await imagePicker.getImage(source: ImageSource.gallery);

    setState(() {
      if(pickedFile != null) {
        //user.profilePicture = pickedFile;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Account', style: TextStyle(fontSize: 16),),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    child: user.GetProfilePicture(),
                  ),
                  TextButton(
                    child: Text(
                      'Change Profile Picture',
                      style: style,
                    ),
                    //onPressed: getImage,
                    onPressed: () {
                      user.profilePicture = user.profilePicture == '' ? 'images/spiderman.png' : '';
                      setState(() {
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Name', style: style),
                  Text(user.name, style: style),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Email', style: style),
                  Text(user.email, style: style),
                ],
              ),
              SizedBox(height: 20),
              Container(
                child: Text('Password', style: style),
                padding: EdgeInsets.only(bottom: 10),
                alignment: Alignment.centerLeft,
              ),
              Column(
                children: [
                  Container(
                    width: 240,
                    height: 40,
                    child: TextField(
                      style: TextStyle(fontSize: 14),
                      obscureText: true,
                      autofocus: false,
                      decoration: InputDecoration(
                        hintText: 'Current Password',
                      ),
                    ),
                  ),
                  Container(
                    width: 240,
                    height: 40,
                    child: TextField(
                      style: TextStyle(fontSize: 14),
                      obscureText: true,
                      autofocus: false,
                      decoration: InputDecoration(
                        hintText: 'New Password',
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

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
        title: Text('My Account', style: TextStyle(fontSize: 16),),
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
              child: Text('Let other users send me plants', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500, fontSize: 16),),
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
                  Divider(thickness: 1, height: 1, color: Colors.blue[100], endIndent: 10,),
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
                  Divider(thickness: 1, height: 1, color: Colors.blue[100], endIndent: 10,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ViewGratitude extends StatefulWidget {
  @override
  _ViewGratitudeState createState() => _ViewGratitudeState();
}
class _ViewGratitudeState extends State<ViewGratitude> {
  @override
  Widget build(BuildContext context) {
    user.plants[0].AddGratitude('I am grateful for pizza');
    user.plants[0].AddGratitude('I am grateful for tacos');
    user.plants[0].AddGratitude('I am grateful for soup');
    user.plants[0].AddGratitude('I am grateful for caffeine');
    user.plants[0].AddGratitude('I am grateful for sleep');
    user.plants[0].AddGratitude('I am grateful for money');
    user.plants[0].AddGratitude('I am grateful for music');
    user.plants[0].AddGratitude('I am grateful for games');
    user.plants[0].AddGratitude('I am grateful for shoes');
    user.plants[0].AddGratitude('I am grateful for sleep');
    user.plants[0].AddGratitude('I am grateful for doggos');
    user.plants[0].AddGratitude('I am grateful for memes');
    user.plants[0].AddGratitude('I am grateful for sleep');
    user.plants[0].AddGratitude('I am grateful for sleep');
    return Scaffold(
      appBar: AppBar(title: Text('View Gratitude', style: TextStyle(fontSize: 16))),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                image: DecorationImage(
                  image: AssetImage('images/plant01.png'),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(20),
                child: Container(
                  color: Colors.blue,
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text('My Gratitude', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16)),
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.white,
                          padding: EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 10),
                          child: Scrollbar(
                            isAlwaysShown: true,
                            child: SingleChildScrollView(
                              padding: EdgeInsets.only(right: 15),
                              child: Text(user.plants[0].PrintGratitude(), style:  TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
                            ),
                          )
                        )
                      ),
                    ],
                  )
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}


class AddGratitude extends StatefulWidget {
  @override
  _AddGratitudeState createState() => _AddGratitudeState();
}

class _AddGratitudeState extends State<AddGratitude> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage('images/spiderman.png'),
                            fit: BoxFit.cover,
                          )),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Peter Parker',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Gratitude Garden',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    IconButton(
                      visualDensity: VisualDensity.compact,
                      splashRadius: 24,
                      icon: Icon(Icons.menu),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Settings()));
                      },
                    ),
                  ],
                ),
              ],
            ),
        ),
      body: Column(
       children: <Widget>[
        Card(
          color: Colors.white,
           child: Padding(
             padding: EdgeInsets.all(8.0),
             child: TextField(
               maxLines: 8,
               decoration: InputDecoration.collapsed(hintText: "Enter gratitude here"),
             ),
            ),
           ),
         ElevatedButton(
           child: Text('Submit'),
           onPressed: () {
             Navigator.pushNamed(context, '/view_gratitude');
           },
          ),
         ],
       ),
      ),
    );
  }
}
