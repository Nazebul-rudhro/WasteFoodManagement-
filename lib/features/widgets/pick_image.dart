// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import '../../services/cloudinary_service.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class PickAndUploadImage extends StatefulWidget {
//   const PickAndUploadImage({super.key});
//
//   @override
//   State<PickAndUploadImage> createState() => _PickAndUploadImageState();
// }
//
// class _PickAndUploadImageState extends State<PickAndUploadImage> {
//   File? _image;
//
//   Future pickImage() async {
//     final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (picked == null) return;
//
//     setState(() => _image = File(picked.path));
//
//     final url = await CloudinaryService.uploadImage(_image!);
//
//     if (url != null) {
//       await FirebaseFirestore.instance.collection('images').add({
//         'imageUrl': url,
//         'createdAt': DateTime.now(),
//       });
//       print('Uploaded: $url');
//     } else {
//       print('Upload failed');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         ElevatedButton(
//           onPressed: pickImage,
//           child: const Text('Pick & Upload Image'),
//         ),
//         if (_image != null) ...[
//           const SizedBox(height: 20),
//           Image.file(_image!, height: 200),
//         ],
//       ],
//     );
//   }
// }

import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../services/cloudinary_service.dart';

class PickAndUploadImage extends StatefulWidget {
  const PickAndUploadImage({super.key});

  @override
  State<PickAndUploadImage> createState() => _PickAndUploadImageState();
}

class _PickAndUploadImageState extends State<PickAndUploadImage> {
  XFile? _imageFile;
  bool _isUploading = false;

  Future<void> _pickAndUpload() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) return;

    setState(() {
      _imageFile = pickedFile;
      _isUploading = true;
    });

    final String? url = await CloudinaryService.uploadImage(pickedFile);

    if (url != null) {
      await FirebaseFirestore.instance.collection('images').add({
        'imageUrl': url,
        'createdAt': FieldValue.serverTimestamp(),
      });
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Success!")));
    } else {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Upload Failed! Check Cloudinary Unsigned Settings.")));
    }

    setState(() => _isUploading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_imageFile != null)
              SizedBox(
                  height: 200,
                  child: kIsWeb ? Image.network(_imageFile!.path) : Image.file(File(_imageFile!.path))
              ),
            const SizedBox(height: 20),
            _isUploading
                ? const CircularProgressIndicator()
                : ElevatedButton(onPressed: _pickAndUpload, child: const Text("Upload to Cloudinary")),
          ],
        ),
      ),
    );
  }
}