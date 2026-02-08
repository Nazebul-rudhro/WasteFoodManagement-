
//
// import 'dart:io';
// import 'package:flutter/foundation.dart' show kIsWeb, Uint8List;
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
//
// class MultiImageUploader extends StatefulWidget {
//   const MultiImageUploader({super.key});
//
//   @override
//   State<MultiImageUploader> createState() => _MultiImageUploaderState();
// }
//
// class _MultiImageUploaderState extends State<MultiImageUploader> {
//   List<XFile> selectedImages = [];
//   final ImagePicker _picker = ImagePicker();
//
//   /// Pick multiple images (Web + Mobile)
//   Future<void> pickImages() async {
//     if (kIsWeb) {
//       FilePickerResult? result = await FilePicker.platform.pickFiles(
//         allowMultiple: true,
//         type: FileType.custom,
//         allowedExtensions: ['jpg', 'jpeg', 'png'],
//         withData: true, // important for web
//       );
//
//       if (result != null && result.files.isNotEmpty) {
//         setState(() {
//           selectedImages.addAll(result.files.map((f) {
//             if (f.bytes == null) {
//               throw Exception("File bytes is null. Cannot upload.");
//             }
//             return XFile.fromData(f.bytes!, name: f.name);
//           }));
//         });
//       }
//     } else {
//       final images = await _picker.pickMultiImage(imageQuality: 70);
//       if (images != null && images.isNotEmpty) {
//         setState(() {
//           selectedImages.addAll(images);
//         });
//       }
//     }
//   }
//
//   /// Upload images to Firebase Storage
//   Future<List<String>> uploadImages() async {
//     List<String> urls = [];
//
//     for (var img in selectedImages) {
//       final fileName = '${DateTime.now().millisecondsSinceEpoch}_${img.name}';
//       final ref = FirebaseStorage.instance.ref().child('donation_images/$fileName');
//
//       late UploadTask uploadTask;
//
//       if (kIsWeb) {
//         final bytes = await img.readAsBytes();
//         uploadTask = ref.putData(bytes, SettableMetadata(contentType: 'image/jpeg'));
//       } else {
//         final file = File(img.path);
//         uploadTask = ref.putFile(file);
//       }
//
//       final snapshot = await uploadTask;
//       final url = await snapshot.ref.getDownloadURL();
//       urls.add(url);
//     }
//
//     return urls;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         ElevatedButton(
//           onPressed: pickImages,
//           child: Text(selectedImages.isEmpty
//               ? "Pick Images"
//               : "${selectedImages.length} image(s) selected"),
//         ),
//         const SizedBox(height: 8),
//         if (selectedImages.isNotEmpty)
//           SizedBox(
//             height: 120,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: selectedImages.length,
//               itemBuilder: (_, index) {
//                 final img = selectedImages[index];
//
//                 return Stack(
//                   children: [
//                     Container(
//                       margin: const EdgeInsets.all(4),
//                       width: 100,
//                       height: 100,
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.green),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: kIsWeb
//                           ? FutureBuilder<Uint8List>(
//                         future: img.readAsBytes(),
//                         builder: (_, snapshot) {
//                           if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
//                             return Image.memory(snapshot.data!, fit: BoxFit.cover);
//                           }
//                           return const Center(child: CircularProgressIndicator());
//                         },
//                       )
//                           : Image.file(File(img.path), fit: BoxFit.cover),
//                     ),
//                     Positioned(
//                       top: 0,
//                       right: 0,
//                       child: InkWell(
//                         onTap: () => setState(() => selectedImages.removeAt(index)),
//                         child: const CircleAvatar(
//                           radius: 12,
//                           backgroundColor: Colors.red,
//                           child: Icon(Icons.close, size: 14, color: Colors.white),
//                         ),
//                       ),
//                     ),
//                   ],
//                 );
//               },
//             ),
//           ),
//       ],
//     );
//   }
// }



import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class MultiImageUploader extends StatefulWidget {
  const MultiImageUploader({super.key});

  @override
  State<MultiImageUploader> createState() => _MultiImageUploaderState();
}

class _MultiImageUploaderState extends State<MultiImageUploader> {
  List<XFile> selectedImages = [];
  final ImagePicker _picker = ImagePicker();

  /// Pick multiple images
  Future<void> pickImages() async {
    if (kIsWeb) {
      try {
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          allowMultiple: true,
          type: FileType.custom,
          allowedExtensions: ['jpg', 'jpeg', 'png'],
          withData: true,
        );

        if (result != null && result.files.isNotEmpty) {
          setState(() {
            selectedImages.addAll(result.files.map((f) {
              if (f.bytes == null) {
                throw Exception("File bytes is null. Cannot upload.");
              }
              return XFile.fromData(f.bytes!, name: f.name);
            }));
          });
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error picking images: $e")),
        );
      }
    } else {
      try {
        final images = await _picker.pickMultiImage(imageQuality: 70);
        if (images != null && images.isNotEmpty) {
          setState(() {
            selectedImages.addAll(images);
          });
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error picking images: $e")),
        );
      }
    }
  }

  /// Upload images to Firebase Storage
  Future<List<String>> uploadImages() async {
    List<String> urls = [];

    for (var img in selectedImages) {
      final fileName = '${DateTime.now().millisecondsSinceEpoch}_${img.name}';
      final ref = FirebaseStorage.instance.ref().child('donation_images/$fileName');

      late UploadTask uploadTask;

      if (kIsWeb) {
        final bytes = await img.readAsBytes();
        uploadTask = ref.putData(bytes, SettableMetadata(contentType: 'image/jpeg'));
      } else {
        final file = File(img.path);
        uploadTask = ref.putFile(file);
      }

      final snapshot = await uploadTask;
      final url = await snapshot.ref.getDownloadURL();
      urls.add(url);
    }

    return urls;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton.icon(
          onPressed: pickImages,
          icon: const Icon(Icons.image),
          label: Text(selectedImages.isEmpty
              ? "Add Images"
              : "${selectedImages.length} image(s) selected"),
        ),
        const SizedBox(height: 8),
        if (selectedImages.isNotEmpty)
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: selectedImages.length,
              itemBuilder: (_, index) {
                final img = selectedImages[index];

                Widget imageWidget;
                if (kIsWeb) {
                  imageWidget = FutureBuilder<Uint8List>(
                    future: img.readAsBytes(),
                    builder: (_, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                        return Image.memory(snapshot.data!, fit: BoxFit.cover);
                      }
                      return const Center(child: CircularProgressIndicator());
                    },
                  );
                } else {
                  imageWidget = Image.file(File(img.path), fit: BoxFit.cover);
                }

                return Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(4),
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: imageWidget,
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: InkWell(
                        onTap: () => setState(() => selectedImages.removeAt(index)),
                        child: const CircleAvatar(
                          radius: 12,
                          backgroundColor: Colors.red,
                          child: Icon(Icons.close, size: 14, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
      ],
    );
  }
}
