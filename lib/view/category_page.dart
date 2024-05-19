import 'package:flutter/material.dart';
import 'package:wallpaperapp/models/category_model.dart';
import 'package:wallpaperapp/view/category_tile.dart';
import 'package:wallpaperapp/view/wallpaper_page.dart';

class CategoryPage extends StatelessWidget {
  final List<Category> categories = [
    Category(name: 'Nature', imageUrl: 'https://picsum.photos/seed/picsum/200/300'),
    Category(name: 'Cars', imageUrl: 'https://picsum.photos/seed/picsum/200/300'),
    // Add more categories
  ];

   CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Categories')),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.0,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return CategoryTile(
            category: categories[index],
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WallpaperPage(category: categories[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
