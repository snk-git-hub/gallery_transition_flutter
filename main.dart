import 'package:flutter/material.dart';
import 'app_data.dart'; // Import the consolidated file

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static final String title = 'Interests';

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(primarySwatch: Colors.deepOrange),
        home: HomePage(),
      );
}