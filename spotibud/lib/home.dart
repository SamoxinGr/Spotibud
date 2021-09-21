import 'package:flutter/material.dart';


class HomeScreen extends StatelessWidget{
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
                    color: Colors.green,
                    fontFamily: 'Merriweather'
                ),
              ),
            ),
            Container(
              height: 30.0,
            ),

            Container(
              padding: EdgeInsets.all(5.0),
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green[600])
                ),
                child: Text('History',
                  style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.5,
                      color: Colors.white,
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
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green[600])
                ),
                child: Text('New',
                  style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.5,
                      color: Colors.white,
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
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green[600])
                ),
                child: Text('Forgotten but loved',
                  style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.5,
                      color: Colors.white,
                      fontFamily: 'Merriweather'
                  ),
                ),
              ),
            ),
          ],
        ),),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.green[600],
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.login),
              label: "Login",
              backgroundColor: Colors.green[600]),
          BottomNavigationBarItem(
              icon: Icon(Icons.bug_report),
              label: "Help",
              backgroundColor: Colors.green[600]),
        ],
        onTap: (index){
          print("Ok");
        },
      ),
    );
  }
}