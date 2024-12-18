import 'package:bus_ticketing_system/view/home_screen_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => const HomeScreenView(),
      '/output': (context) => HomeScreenView(),
    },
    debugShowCheckedModeBanner: false,
  ));
}
