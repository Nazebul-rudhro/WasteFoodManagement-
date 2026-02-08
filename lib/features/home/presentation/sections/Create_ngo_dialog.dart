// // import 'package:flutter/material.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// //
// // class CreateNgoDialog extends StatefulWidget {
// //   const CreateNgoDialog({super.key});
// //
// //   @override
// //   State<CreateNgoDialog> createState() => _CreateNgoDialogState();
// // }
// //
// // class _CreateNgoDialogState extends State<CreateNgoDialog> {
// //   final _formKey = GlobalKey<FormState>();
// //
// //   final TextEditingController _nameController = TextEditingController();
// //   final TextEditingController _phoneController = TextEditingController();
// //   final TextEditingController _addressController = TextEditingController();
// //   final TextEditingController _cityController = TextEditingController();
// //
// //   bool _isLoading = false;
// //
// //   Future<void> _createNGO() async {
// //     if (!_formKey.currentState!.validate()) return;
// //
// //     setState(() => _isLoading = true);
// //
// //     try {
// //       final user = FirebaseAuth.instance.currentUser;
// //       if (user == null) return;
// //
// //       final ngoRef = FirebaseFirestore.instance.collection('ngos').doc(); // auto-generated ID
// //       final ngoId = ngoRef.id;
// //
// //       // Save NGO data
// //       await ngoRef.set({
// //         "name": _nameController.text.trim(),
// //         "phone": _phoneController.text.trim(),
// //         "address": _addressController.text.trim(),
// //         "city": _cityController.text.trim(),
// //         "adminId": user.uid,
// //         "isApproved": false, // optional, later can approve
// //         "createdAt": FieldValue.serverTimestamp(),
// //       });
// //
// //       // Update user account with ngoId
// //       await FirebaseFirestore.instance.collection('accounts').doc(user.uid).set({
// //         "ngoId": ngoId,
// //         "role": "ngo_admin",
// //         "updatedAt": FieldValue.serverTimestamp(),
// //       }, SetOptions(merge: true));
// //
// //       if (mounted) {
// //         Navigator.of(context).pop(); // close dialog
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           const SnackBar(content: Text("NGO created successfully!")),
// //         );
// //       }
// //     } catch (e) {
// //       if (mounted) {
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           SnackBar(content: Text("Error: $e")),
// //         );
// //       }
// //     } finally {
// //       if (mounted) setState(() => _isLoading = false);
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return AlertDialog(
// //       title: const Text("Create NGO"),
// //       content: Form(
// //         key: _formKey,
// //         child: Column(
// //           mainAxisSize: MainAxisSize.min,
// //           children: [
// //             TextFormField(
// //               controller: _nameController,
// //               decoration: const InputDecoration(labelText: "NGO Name"),
// //               validator: (v) => v!.isEmpty ? "Enter NGO name" : null,
// //             ),
// //             TextFormField(
// //               controller: _phoneController,
// //               decoration: const InputDecoration(labelText: "Phone"),
// //               validator: (v) => v!.isEmpty ? "Enter phone" : null,
// //             ),
// //             TextFormField(
// //               controller: _addressController,
// //               decoration: const InputDecoration(labelText: "Address"),
// //               validator: (v) => v!.isEmpty ? "Enter address" : null,
// //             ),
// //             TextFormField(
// //               controller: _cityController,
// //               decoration: const InputDecoration(labelText: "City"),
// //               validator: (v) => v!.isEmpty ? "Enter city" : null,
// //             ),
// //           ],
// //         ),
// //       ),
// //       actions: [
// //         TextButton(
// //           onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
// //           child: const Text("Cancel"),
// //         ),
// //         ElevatedButton(
// //           onPressed: _isLoading ? null : _createNGO,
// //           child: _isLoading
// //               ? const CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
// //               : const Text("Create"),
// //         ),
// //       ],
// //     );
// //   }
// // }
//
//
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:waste_food_management/core/constants/app_colors.dart';
//
// class CreateNgoDialog extends StatefulWidget {
//   const CreateNgoDialog({super.key});
//
//   @override
//   State<CreateNgoDialog> createState() => _CreateNgoDialogState();
// }
//
// class _CreateNgoDialogState extends State<CreateNgoDialog> {
//   final _formKey = GlobalKey<FormState>();
//
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _addressController = TextEditingController();
//   final TextEditingController _cityController = TextEditingController();
//
//   bool _isLoading = false;
//
//
//
//   Future<void> _createNGO() async {
//     if (!_formKey.currentState!.validate()) return;
//
//     setState(() => _isLoading = true);
//
//     try {
//       final user = FirebaseAuth.instance.currentUser;
//       if (user == null) return;
//
//       final ngoRef = FirebaseFirestore.instance.collection('ngos').doc();
//       final ngoId = ngoRef.id;
//
//       await ngoRef.set({
//         "name": _nameController.text.trim(),
//         "phone": _phoneController.text.trim(),
//         "address": _addressController.text.trim(),
//         "city": _cityController.text.trim(),
//         "adminId": user.uid,
//         "isApproved": false,
//         "createdAt": FieldValue.serverTimestamp(),
//       });
//
//       await FirebaseFirestore.instance.collection('accounts').doc(user.uid).set({
//         "ngoId": ngoId,
//         "role": "ngo_admin",
//         "updatedAt": FieldValue.serverTimestamp(),
//       }, SetOptions(merge: true));
//
//       if (mounted) {
//         Navigator.of(context).pop();
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content:  Text("NGO created successfully!"),
//             backgroundColor: AppColor.green, // 🌿 Green
//           ),
//         );
//       }
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text("Error: $e"),
//             backgroundColor: AppColor.red, // 🔴 error in red
//           ),
//         );
//       }
//     } finally {
//       if (mounted) setState(() => _isLoading = false);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text(
//         "Create NGO",
//         style: TextStyle(color: AppColor.green),
//       ),
//       content: Form(
//         key: _formKey,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextFormField(
//               controller: _nameController,
//               decoration: InputDecoration(
//                 labelText: "NGO Name",
//                 focusedBorder: UnderlineInputBorder(
//                   borderSide: BorderSide(color: AppColor.green),
//                 ),
//                 labelStyle: TextStyle(color: Colors.grey),
//               ),
//               validator: (v) => v!.isEmpty ? "Enter NGO name" : null,
//             ),
//             TextFormField(
//               controller: _phoneController,
//               decoration: InputDecoration(
//                 labelText: "Phone",
//                 focusedBorder: UnderlineInputBorder(
//                   borderSide: BorderSide(color: AppColor.green),
//                 ),
//                 labelStyle: TextStyle(color: Colors.grey),
//                 enabledBorder: UnderlineInputBorder(
//                   borderSide: BorderSide(color: Colors.grey),
//                 ),
//               ),
//               validator: (v) => v!.isEmpty ? "Enter phone" : null,
//             ),
//             // TextFormField(
//             //   controller: _addressController,
//             //   decoration: InputDecoration(
//             //     labelText: "Address",
//             //     focusedBorder: UnderlineInputBorder(
//             //       borderSide: BorderSide(color: AppColor.green),
//             //     ),
//             //     labelStyle: TextStyle(color: Colors.grey),
//             //   ),
//             //   validator: (v) => v!.isEmpty ? "Enter address" : null,
//             // ),
//
//             TextFormField(
//               controller: _addressController,
//               decoration: InputDecoration(
//                 labelText: "Address",
//                 labelStyle: TextStyle(color: Colors.grey), // normal state
//                 floatingLabelStyle: TextStyle(
//                   color: AppColor.green, // 🌿 floating label color
//                   fontWeight: FontWeight.bold,
//                 ),
//                 focusedBorder: UnderlineInputBorder(
//                   borderSide: BorderSide(color: AppColor.green),
//                 ),
//                 enabledBorder: UnderlineInputBorder(
//                   borderSide: BorderSide(color: Colors.grey),
//                 ),
//               ),
//               validator: (v) => v!.isEmpty ? "Enter address" : null,
//             ),
//
//
//
//
//             TextFormField(
//               controller: _cityController,
//               decoration: InputDecoration(
//                 labelText: "City",
//                 focusedBorder: UnderlineInputBorder(
//                   borderSide: BorderSide(color: AppColor.green),
//                 ),
//                 labelStyle: TextStyle(color: Colors.grey),
//               ),
//               validator: (v) => v!.isEmpty ? "Enter city" : null,
//             ),
//           ],
//         ),
//       ),
//       actions: [
//         TextButton(
//           onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
//           child: Text(
//             "Cancel",
//             style: TextStyle(color: AppColor.green),
//           ),
//         ),
//         ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: AppColor.green, // 🌿 Green button
//             foregroundColor: AppColor.white,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(8)
//             )
//           ),
//           onPressed: _isLoading ? null : _createNGO,
//           child: _isLoading
//               ? const SizedBox(
//             height: 20,
//             width: 20,
//             child: CircularProgressIndicator(
//               color: Colors.white,
//               strokeWidth: 2,
//             ),
//           )
//               : const Text("Create"),
//         ),
//       ],
//     );
//   }
// }
//


//
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:waste_food_management/core/constants/app_colors.dart';
//
// class CreateNgoDialog extends StatefulWidget {
//   const CreateNgoDialog({super.key});
//
//   @override
//   State<CreateNgoDialog> createState() => _CreateNgoDialogState();
// }
//
// class _CreateNgoDialogState extends State<CreateNgoDialog> {
//   final _formKey = GlobalKey<FormState>();
//
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _addressController = TextEditingController();
//   final TextEditingController _cityController = TextEditingController();
//
//   bool _isLoading = false;
//
//   Future<void> _createNGO() async {
//     if (!_formKey.currentState!.validate()) return;
//
//     setState(() => _isLoading = true);
//
//     try {
//       final user = FirebaseAuth.instance.currentUser;
//       if (user == null) return;
//
//       final ngoRef = FirebaseFirestore.instance.collection('ngos').doc();
//       final ngoId = ngoRef.id;
//
//       await ngoRef.set({
//         "name": _nameController.text.trim(),
//         "phone": _phoneController.text.trim(),
//         "address": _addressController.text.trim(),
//         "city": _cityController.text.trim(),
//         "adminId": user.uid,
//         "isApproved": false,
//         "createdAt": FieldValue.serverTimestamp(),
//       });
//
//       await FirebaseFirestore.instance.collection('accounts').doc(user.uid).set({
//         "ngoId": ngoId,
//         "role": "ngo_admin",
//         "updatedAt": FieldValue.serverTimestamp(),
//       }, SetOptions(merge: true));
//
//       if (mounted) {
//         Navigator.of(context).pop();
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: const Text("NGO created successfully!"),
//             backgroundColor: AppColor.green,
//           ),
//         );
//       }
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text("Error: $e"),
//             backgroundColor: AppColor.red,
//           ),
//         );
//       }
//     } finally {
//       if (mounted) setState(() => _isLoading = false);
//     }
//   }
//
//   // 🔹 Helper method for fields with green floating label
//   InputDecoration _greenFieldDecoration(String label) {
//     return InputDecoration(
//       labelText: label,
//       labelStyle: const TextStyle(color: Colors.grey),
//       floatingLabelStyle: TextStyle(
//         color: AppColor.green,
//         fontWeight: FontWeight.bold,
//       ),
//       focusedBorder: UnderlineInputBorder(
//         borderSide: BorderSide(color: AppColor.green, width: 2),
//       ),
//       enabledBorder: const UnderlineInputBorder(
//         borderSide: BorderSide(color: Colors.grey),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text(
//         "Create NGO",
//         style: TextStyle(color: AppColor.green),
//       ),
//       content: Form(
//         key: _formKey,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             // NGO Name with green floating label
//             TextFormField(
//               controller: _nameController,
//               decoration: _greenFieldDecoration("NGO Name"),
//               validator: (v) => v!.isEmpty ? "Enter NGO name" : null,
//             ),
//             // Phone with green floating label
//             TextFormField(
//               controller: _phoneController,
//               decoration: _greenFieldDecoration("Phone"),
//               validator: (v) => v!.isEmpty ? "Enter phone" : null,
//             ),
//             // Address stays normal (no green floating)
//             TextFormField(
//               controller: _addressController,
//               decoration: const InputDecoration(
//                 labelText: "Address",
//                 labelStyle: TextStyle(color: Colors.grey),
//                 focusedBorder: UnderlineInputBorder(
//                   borderSide: BorderSide(color: AppColor.green),
//                 ),
//                 enabledBorder: UnderlineInputBorder(
//                   borderSide: BorderSide(color: Colors.grey),
//                 ),
//               ),
//               validator: (v) => v!.isEmpty ? "Enter address" : null,
//             ),
//             // City with green floating label
//             TextFormField(
//               controller: _cityController,
//               decoration: _greenFieldDecoration("City"),
//               validator: (v) => v!.isEmpty ? "Enter city" : null,
//             ),
//           ],
//         ),
//       ),
//       actions: [
//         TextButton(
//           onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
//           child: Text(
//             "Cancel",
//             style: TextStyle(color: AppColor.green),
//           ),
//         ),
//         ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: AppColor.green,
//             foregroundColor: AppColor.white,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(8),
//             ),
//           ),
//           onPressed: _isLoading ? null : _createNGO,
//           child: _isLoading
//               ? const SizedBox(
//             height: 20,
//             width: 20,
//             child: CircularProgressIndicator(
//               color: Colors.white,
//               strokeWidth: 2,
//             ),
//           )
//               : const Text("Create"),
//         ),
//       ],
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:waste_food_management/core/constants/app_colors.dart';
import 'package:waste_food_management/features/auth/presentation/sections/show_aleart.dart';

class CreateNgoDialog extends StatefulWidget {
  const CreateNgoDialog({super.key});

  @override
  State<CreateNgoDialog> createState() => _CreateNgoDialogState();
}

class _CreateNgoDialogState extends State<CreateNgoDialog> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  bool _isLoading = false;

  // 🔹 Create NGO function
  Future<void> _createNGO() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      final ngoRef = FirebaseFirestore.instance.collection('ngos').doc();
      final ngoId = ngoRef.id;

      await ngoRef.set({
        "name": _nameController.text.trim(),
        "phone": _phoneController.text.trim(),
        "address": _addressController.text.trim(),
        "city": _cityController.text.trim(),
        "adminId": user.uid,
        "isApproved": false,
        "createdAt": FieldValue.serverTimestamp(),
      });

      await FirebaseFirestore.instance.collection('accounts').doc(user.uid).set({
        "ngoId": ngoId,
        "role": "ngo_admin",
        "updatedAt": FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      if (mounted) {
        Navigator.of(context).pop();
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: const Text("NGO created successfully!"),
        //     backgroundColor: AppColor.green,
        //   ),
        // );
        ShowAlertMessage(
          context: context,
          isSuccess: true,
          title: 'NGO Created',
          boldText: 'Congratulations!', // এই অংশ bold দেখাবে
          message: 'Your NGO has been successfully created.',
        );


      }
    } catch (e) {
      if (mounted) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text("Error: $e"),
        //     backgroundColor: AppColor.red,
        //   ),
        // );

        ShowAlertMessage(
          context: context,
          isSuccess: false,
          title: 'NGO Created',
          boldText: 'Congratulations!', // এই অংশ bold দেখাবে
          message: 'Your NGO has been successfully created.',
        );

      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  // 🔹 Green floating label decoration
  InputDecoration _greenFieldDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.grey),
      floatingLabelStyle: TextStyle(
        color: AppColor.green,
        fontWeight: FontWeight.bold,
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColor.green, width: 2),
      ),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 🔹 Main AlertDialog
        AlertDialog(
          title: Text(
            "Create NGO",
            style: TextStyle(color: AppColor.green),
          ),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: _greenFieldDecoration("NGO Name"),
                  validator: (v) => v!.isEmpty ? "Enter NGO name" : null,
                ),
                TextFormField(
                  controller: _phoneController,
                  decoration: _greenFieldDecoration("Phone"),
                  validator: (v) => v!.isEmpty ? "Enter phone" : null,
                ),
                TextFormField(
                  controller: _addressController,
                  decoration: const InputDecoration(
                    labelText: "Address",
                    labelStyle: TextStyle(color: Colors.grey),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColor.green),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                  validator: (v) => v!.isEmpty ? "Enter address" : null,
                ),
                TextFormField(
                  controller: _cityController,
                  decoration: _greenFieldDecoration("City"),
                  validator: (v) => v!.isEmpty ? "Enter city" : null,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
              child: Text(
                "Cancel",
                style: TextStyle(color: AppColor.green),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.green,
                foregroundColor: AppColor.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: _isLoading ? null : _createNGO,
              child: const Text("Create"),
            ),
          ],
        ),

        // 🔹 Fullscreen loader overlay inside Stack
        if (_isLoading)
          Positioned.fill(
            child: AbsorbPointer(
              absorbing: true, // block touches
              child: Container(
                color: Colors.black38, // semi-transparent overlay
                child: const Center(
                  child: CircularProgressIndicator(
                    color: AppColor.green,
                    strokeWidth: 3,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}


