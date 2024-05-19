import 'dart:developer';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:wallpaperapp/generated/assets.dart';
import 'package:wallpaperapp/models/category_model.dart';
import 'package:wallpaperapp/models/wallpaper_model.dart';

import 'package:wallpaperapp/view/wallpaper_tile.dart';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

class WallpaperPage extends StatelessWidget {
  final Category category;
  final List<Wallpaper> wallpapers = [
    Wallpaper(imageUrl: Assets.wallpapersW1),
    Wallpaper(imageUrl:  Assets.wallpapersW2),
    Wallpaper(imageUrl:  Assets.wallpapersW3),
    Wallpaper(imageUrl:  Assets.wallpapersW4),
    Wallpaper(imageUrl:  Assets.wallpapersW5),
    Wallpaper(imageUrl:  Assets.wallpapersW6),
    Wallpaper(imageUrl:  Assets.wallpapersW7),
    Wallpaper(imageUrl:  Assets.wallpapersW8),

    // Add more wallpapers
  ];

  WallpaperPage({super.key, required this.category});


  Future<void> saveAssetToLocalStorage(String assetPath, String filename,BuildContext context) async {


    if (Platform.isAndroid) {
      if (await _requestPermission()) {
        // Load the asset
        final ByteData data = await rootBundle.load(assetPath);
        final buffer = data.buffer;

        // Get the external storage directory
        final directory = await getExternalStorageDirectory();
        final path = directory!.path;

        // Create the file
        final file = File('$path/$filename');

        // Write the asset data to the file
        await file.writeAsBytes(buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
        final result =
        await ImageGallerySaver.saveFile(file.path, isReturnPathOfIOS: true);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Wallpaper Downloaded!')));
        print('File saved to $path/$filename');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Storage permission is required to download wallpapers.')));
      }
    }


  }
  Future<bool> _requestPermission() async {
    var androidInfo = await DeviceInfoPlugin().androidInfo;

    var sdkInt = androidInfo.version.sdkInt;
    log(sdkInt.toString());
    if (Platform.isAndroid) {

      if (sdkInt >= 33) {
        // Request Media permissions for Android 13 and above
        return await _requestMediaPermission();
      } else {
        // Request Storage permissions for Android 10 to 12
        return await _requestStoragePermission();
      }
    }
    return false;
  }

  Future<int> _getAndroidVersion() async {
    final versionString = await MethodChannel('getAndroidVersion').invokeMethod<String>('getAndroidVersion');
    final version = int.parse(versionString!.split('.').first);
    return version;
  }

  Future<bool> _requestStoragePermission() async {
    final status = await Permission.storage.request();

    return status.isGranted;
  }

  Future<bool> _requestMediaPermission() async {
    final statusImages = await Permission.manageExternalStorage.request();
    return statusImages.isGranted;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(category.name)),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.0,
        ),
        itemCount: wallpapers.length,
        itemBuilder: (context, index) {
          return WallpaperTile(
            wallpaper: wallpapers[index],
            onTap: () => saveAssetToLocalStorage(wallpapers[index].imageUrl,"wallpaper${index}.png",context),
          );
        },
      ),
    );
  }
}
