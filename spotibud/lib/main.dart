import 'package:flutter/material.dart';
import 'package:spotibud/pages/loading_page.dart';
import 'package:spotibud/pages/root_app.dart';

/*void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    ));
*/
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Spotibud',
      theme: ThemeData(
        primarySwatch: Colors.green,
        backgroundColor: Colors.black,
      ),

    home: LoginScreen(),);
  }
}