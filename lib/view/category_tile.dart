
import 'package:flutter/material.dart';
import 'package:wallpaperapp/models/category_model.dart';

class CategoryTile extends StatelessWidget {
  final Category category;
  final VoidCallback onTap;

  const CategoryTile({super.key, required this.category, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Container(

              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.asset(

                  category.imageUrl,
                  fit: BoxFit.cover,width:
                double.maxFinite,height: double.maxFinite,


                ),

              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              alignment: Alignment.center,

              child: Text(
                category.name,
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
