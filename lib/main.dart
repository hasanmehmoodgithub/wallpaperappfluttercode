import 'package:flutter/material.dart';
import 'package:wallpaperapp/models/category_model.dart';
import 'package:wallpaperapp/view/category_page.dart';
import 'package:wallpaperapp/view/wallpaper_page.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<Category> categories = [
    Category(name: 'Ai Wallpapers', imageUrl: ''),
    // Add more categories
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wallpaper App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WallpaperPage(category:categories[0],),
    );
  }
}
