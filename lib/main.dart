// We need to import flutter material package
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pics/src/app.dart';

// Define the main function
void main() {
  // Create a new Text widget
  var app = GetMaterialApp(home: App());
  // Take this widget to show some text on the screen
  runApp(app);
}
