import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => StartUp(),
        '/sign_in': (context) => SignIn(),
      },
    ));
}

class StartUp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(child: Text('Gratitude Garden')),
      ),
      body: Center(
          child: Column(
          children: <Widget>[
            Image(image: AssetImage('images/GG.jpg')),
            Text('Planting Gratitude with the Right Attitude', style: TextStyle(fontSize: 20.0)),
            ElevatedButton(
              child: Text('Sign In'),
              onPressed: () {
                Navigator.pushNamed(context, '/sign_in');
              }
            ),
            ElevatedButton(
              child: Text('Create an Account'),
              onPressed: () {},
            )
          ]
      )),

    );
  }
}

//Image(image: AssetImage('images/GG.jpg'))

  class SignIn extends StatefulWidget {
    @override
    _SignInState createState() => _SignInState();
  }

class _SignInState extends State<SignIn>{
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
                height: height*0.25,
                child: Image(image: AssetImage('images/GG.jpg'))
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Sign In', style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),),
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
                padding: const EdgeInsets.all (5.0),
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
                  height: height*0.45,
                  child: Image(image: AssetImage('images/GG.jpg'))
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Sign Up', style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),),
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
                padding: const EdgeInsets.all (10.0),
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



class Garden extends StatefulWidget {
  @override
  _GardenState createState() => _GardenState();
}

class _GardenState extends State<Garden> {
  @override
  Widget build (BuildContext context) {
    return MaterialApp(
      title: 'My Garden',
      home: Scaffold(
        appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:[
                Row(
                  children: [
                    Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(image: AssetImage('images/spiderman.png'), fit: BoxFit.cover,)
                      ),
                    ),
                    SizedBox(width: 10,),
                    Text('Peter Parker', style: TextStyle(fontSize: 16),),
                  ],
                ),
                Row(
                  children: [
                    Text('Gratitude Garden', style: TextStyle(fontSize: 16),),
                    SizedBox(width: 10,),
                    IconButton(
                      visualDensity: VisualDensity.compact,
                      splashRadius: 24,
                      icon: Icon(Icons.menu),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Settings()));
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
          currentIndex: 0,
          items: const <BottomNavigationBarItem> [
            BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'Garden',),
            BottomNavigationBarItem(icon: Icon(Icons.supervised_user_circle), label: 'Friends',),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _BuildPlantColumn('Plants 1-3', 'images/plant01.png', 'images/plant02.png', ''),
            _BuildPlantColumn('Plants 4-6', '', '', ''),
            _BuildPlantColumn('Plants 7-9', '', '', ''),
            _BuildPlantColumn('El Big Boi\'s', '', '', ''),
          ],
        ),
      ) ,
    );
  }
  Column _BuildPlantColumn(String label, String plant1, String plant2, String plant3, ) {
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
              _BuildPlantButton(plant1),
              _BuildPlantButton(plant2),
              _BuildPlantButton(plant3),
            ],
          ),
          height: 88,
        ),
        Container(
          height: 15,
          color: Colors.yellow[600],
        ),
        Container(
          height: 5,
          color: Colors.orange[300],
        ),
      ],
    );
  }

  RawMaterialButton _BuildPlantButton(String plant) {
    return RawMaterialButton(
      child: Container(
        width: 100, height: 250,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          image: plant  == '' ? null : DecorationImage(image: AssetImage(plant), fit: BoxFit.fitHeight,
          ),
        ),
      ),
      onPressed: () {
        //Navigator.push(context, MaterialPageRoute(builder: (context) => Plant(int selectedIndex)));
      } ,
    );
  }
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
            onPressed: () {},
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
            onPressed: () {},
            child: Container (
              padding: EdgeInsets.only(left: 10, top: 12, right: 10, bottom: 12),
              child: Row(
                  children: [
                    Icon(Icons.lock),
                    SizedBox(width: 16,),
                    Text('Privacy')]),
            ),
          ),
        ],
      ),
    );
  }
}

