
import 'package:flutter/material.dart';
import 'package:wallpaperapp/models/wallpaper_model.dart';

class WallpaperTile extends StatelessWidget {
  final Wallpaper wallpaper;
  final VoidCallback onTap;

  const WallpaperTile({super.key, required this.wallpaper, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(8.0),
        child:ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: Image.asset(
              wallpaper.imageUrl,
              fit: BoxFit.cover,width:
          double.maxFinite,height: double.maxFinite,
              // placeholder: (context, url) => Container(color: Colors.grey,),
              // errorWidget: (context, url, error) => Container(color: Colors.grey,),
          ),
        ),
      ),
    );
  }
}
