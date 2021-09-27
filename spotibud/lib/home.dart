import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget{
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 150.0,
              height: 150.0,
              child: Image(
                image: AssetImage('assets/images/image.jpeg',),
                fit: BoxFit.fill,
              ),
            ),
            Container(
              height: 15.0,
            ),
            Container(
              child: Text(
                'SpotiBud',
                style: TextStyle(
                    fontSize: 35.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.5,
                    color: Colors.white,
                    fontFamily: 'Merriweather'
                ),
              ),
            ),
            Container(
              height: 30.0,
            ),

            Container(
              padding: EdgeInsets.all(5.0),
              child: FloatingActionButton.extended(
                onPressed: () {
                  print("History");
                },
                backgroundColor: Colors.green,
                label: Text('History',
                  style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.5,
                      color: Colors.black,
                      fontFamily: 'Merriweather'
                  ),
                ),
              ),

            ),
            Container(
              height: 15.0,
            ),
            Container(
              padding: EdgeInsets.all(5.0),
              child: FloatingActionButton.extended(
                onPressed: () {
                  print("New");
                },
                backgroundColor: Colors.green,
                label: Text('New',
                  style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.5,
                      color: Colors.black,
                      fontFamily: 'Merriweather'
                  ),
                ),
              ),
            ),
            Container(
              height: 15.0,
            ),
            Container(
              padding: EdgeInsets.all(5.0),
              child: FloatingActionButton.extended(
                onPressed: () {
                  print("Forgotten");
                },
                backgroundColor: Colors.green,
                label: Text('Forgotten',
                  style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.5,
                      color: Colors.black,
                      fontFamily: 'Merriweather'
                  ),
                ),
              ),
            ),
          ],
        ),),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.white,
        backgroundColor: Colors.green,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.login),
              label: "Login"),
          BottomNavigationBarItem(
              icon: Icon(Icons.bug_report),
              label: "Help"),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
