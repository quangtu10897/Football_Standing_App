import 'package:flutter/material.dart';
import 'package:project_flutter/screens/chartScreen.dart';
import 'package:project_flutter/screens/detailsSreen.dart';
import 'package:project_flutter/screens/homeScreen.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/homeScreen',
    routes: {
      '/homeScreen': (context) => HomeScreen(),
      //'/chartScreen': (context) => ChartScreen(),
      
    },
  ));
  
}
