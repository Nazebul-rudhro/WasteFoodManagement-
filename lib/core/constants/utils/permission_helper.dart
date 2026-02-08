import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

Future<void> requestStoragePermission() async {
  if (!Platform.isAndroid) return;

  final status = await Permission.photos.request();

  if (!status.isGranted) {
    throw Exception("Storage permission denied");
  }


  // storage permision
  if (await Permission.storage.request().isGranted) {
    // granted
  } else {
    throw Exception("Storage permission denied");
  }
}


