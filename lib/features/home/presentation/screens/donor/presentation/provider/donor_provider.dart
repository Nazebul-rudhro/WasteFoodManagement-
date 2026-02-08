import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../../../../services/cloudinary_service.dart';

class DonorProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final ImagePicker _picker = ImagePicker();

  bool isLoading = false;
  List<XFile> selectedImages = [];

  // ================= PICK IMAGES =================
  Future<void> pickImages() async {
    try {
      if (kIsWeb) {
        final result = await FilePicker.platform.pickFiles(
          allowMultiple: true,
          type: FileType.image,
          withData: true,
        );

        if (result != null) {
          selectedImages.addAll(
            result.files.map(
                  (f) => XFile.fromData(f.bytes!, name: f.name),
            ),
          );
        }
      } else {
        final images = await _picker.pickMultiImage(imageQuality: 70);
        if (images != null) {
          selectedImages.addAll(images);
        }
      }
      notifyListeners();
    } catch (e) {
      throw Exception("Image pick failed");
    }
  }

  // ================= SUBMIT POST =================
  Future<void> submitPost({
    required String foodName,
    required String quantity,
    required String pickupTime,
    required String pickupAddress,
    required String description,
  }) async {
    if (selectedImages.isEmpty) {
      throw Exception("Please add at least one image");
    }

    isLoading = true;
    notifyListeners();

    try {
      final user = _auth.currentUser!;

      // 1️⃣ Upload images
      final imageUrls =
      await CloudinaryService.uploadImages(selectedImages);

      if (imageUrls.isEmpty) {
        throw Exception("Image upload failed");
      }

      // 2️⃣ Save post
      final postRef = _db.collection('posts').doc();
      await postRef.set({
        "postId": postRef.id,
        "donorId": user.uid,
        "foodName": foodName,
        "quantity": quantity,
        "pickupTime": pickupTime,
        "pickupAddress": pickupAddress,
        "description": description,
        "status": "available",
        "imageUrls": imageUrls,
        "createdAt": FieldValue.serverTimestamp(),
      });

      selectedImages.clear();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
