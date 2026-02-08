// // import 'dart:convert';
// // import 'dart:io';
// // import 'package:http/http.dart' as http;
// //
// // class CloudinaryService {
// //   static const String cloudName = 'dptl6uwlz';       // Cloudinary Dashboard থেকে
// //   static const String uploadPreset = 'waste-food-management'; // Unsigned preset
// //
// //   static Future<String?> uploadImage(File imageFile) async {
// //     try {
// //       final uri = Uri.parse(
// //         'https://api.cloudinary.com/v1_1/$cloudName/image/upload',
// //       );
// //
// //       final request = http.MultipartRequest('POST', uri)
// //         ..fields['upload_preset'] = uploadPreset
// //         ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));
// //
// //       final response = await request.send();
// //       final resBody = await response.stream.bytesToString();
// //       final jsonData = json.decode(resBody);
// //
// //       if (response.statusCode == 200) {
// //         return jsonData['secure_url'];
// //       } else {
// //         print('Cloudinary Error: ${jsonData['error']['message']}');
// //         return null;
// //       }
// //     } catch (e) {
// //       print('Cloudinary Exception: $e');
// //       return null;
// //     }
// //   }
// // }
//
//
// import 'dart:convert';
// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'package:flutter/foundation.dart' show kIsWeb;
// import 'dart:typed_data';
//
// import 'package:http/http.dart' as http_parser;
//
// class CloudinaryService {
//   static const String cloudName = 'dptl6uwlz';       // Cloudinary dashboard থেকে
//   static const String uploadPreset = 'waste-food-management'; // Unsigned preset
//
//   /// Upload single image
//   static Future<String?> uploadImage(dynamic image) async {
//     try {
//       final uri = Uri.parse(
//         'https://api.cloudinary.com/v1_1/$cloudName/image/upload',
//       );
//
//       final request = http.MultipartRequest('POST', uri)
//         ..fields['upload_preset'] = uploadPreset;
//
//       if (kIsWeb) {
//         // Web: Uint8List
//         request.files.add(
//           http.MultipartFile.fromBytes(
//             'file',
//             image.bytes, // XFile.bytes
//             filename: image.name,
//             contentType: http_parser.MediaType('image', 'jpeg'),
//           ),
//         );
//       } else {
//         // Mobile: File
//         request.files.add(await http.MultipartFile.fromPath('file', image.path));
//       }
//
//       final response = await request.send();
//       final resBody = await response.stream.bytesToString();
//       final jsonData = json.decode(resBody);
//
//       if (response.statusCode == 200) {
//         return jsonData['secure_url'];
//       } else {
//         print('Cloudinary Error: ${jsonData['error']['message']}');
//         return null;
//       }
//     } catch (e) {
//       print('Cloudinary Exception: $e');
//       return null;
//     }
//   }
//
//   /// Upload multiple images
//   static Future<List<String>> uploadImages(List<dynamic> images) async {
//     List<String> urls = [];
//     for (var img in images) {
//       final url = await uploadImage(img);
//       if (url != null) urls.add(url);
//     }
//     return urls;
//   }
// }
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class CloudinaryService {
  static const String cloudName = 'dptl6uwlz';
  static const String uploadPreset = 'waste-food-management';

  static Future<String?> uploadImage(XFile image) async {
    try {
      final uri = Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/upload');
      var request = http.MultipartRequest('POST', uri);

      request.fields['upload_preset'] = uploadPreset;

      if (kIsWeb) {
        final bytes = await image.readAsBytes();
        request.files.add(http.MultipartFile.fromBytes(
          'file',
          bytes,
          filename: image.name,
          contentType: MediaType('image', 'jpeg'),
        ));
      } else {
        request.files.add(await http.MultipartFile.fromPath('file', image.path));
      }

      var response = await request.send();
      var responseData = await response.stream.bytesToString();
      var decodedData = json.decode(responseData);

      if (response.statusCode == 200) {
        return decodedData['secure_url'];
      } else {
        print("Cloudinary Error: ${decodedData['error']['message']}");
        return null;
      }
    } catch (e) {
      print("Exception: $e");
      return null;
    }
  }

  static Future<List<String>> uploadImages(List<XFile> images) async {
    List<String> urls = [];
    for (var img in images) {
      final url = await uploadImage(img);
      if (url != null) urls.add(url);
    }
    return urls;
  }
}