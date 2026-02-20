// import 'dart:io';
// import 'dart:typed_data';
// import 'package:intl/intl.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:waste_food_management/core/constants/app_colors.dart';
// import 'package:waste_food_management/features/auth/presentation/sections/show_aleart.dart';
// import '../../provider/donor_provider.dart';
//
// class CreateDonationDialog extends StatefulWidget {
//   const CreateDonationDialog({super.key});
//
//   @override
//   State<CreateDonationDialog> createState() => _CreateDonationDialogState();
// }
//
// class _CreateDonationDialogState extends State<CreateDonationDialog> {
//   final _formKey = GlobalKey<FormState>();
//   final foodCtrl = TextEditingController();
//   final qtyCtrl = TextEditingController();
//   final pickupTimeCtrl = TextEditingController();
//   final addressCtrl = TextEditingController();
//   final descCtrl = TextEditingController();
//   DateTime? selectedExpiryDateTime;
//
//   Future<void> _selectDateTime(BuildContext context) async {
//     final now = DateTime.now();
//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: now,
//       firstDate: now,
//       lastDate: now.add(const Duration(days: 2)),
//     );
//
//     if (pickedDate != null) {
//       if (!mounted) return;
//       final TimeOfDay? pickedTime = await showTimePicker(
//         context: context,
//         initialTime: TimeOfDay.now(),
//       );
//
//       if (pickedTime != null) {
//         setState(() {
//           selectedExpiryDateTime = DateTime(
//             pickedDate.year, pickedDate.month, pickedDate.day,
//             pickedTime.hour, pickedTime.minute,
//           );
//           // Today/Tomorrow ছাড়াই ফরম্যাট
//           pickupTimeCtrl.text = DateFormat('MMM d, h:mm a').format(selectedExpiryDateTime!);
//         });
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final donorProvider = context.watch<DonorProvider>();
//
//     return Stack(
//       children: [
//         Dialog(
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//           child: Padding(
//             padding: const EdgeInsets.all(16),
//             child: Form(
//               key: _formKey,
//               child: SingleChildScrollView(
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     const Center(child: Text("Create Donation", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColor.green))),
//                     const Divider(),
//                     _buildField("Food Name", foodCtrl),
//                     _buildField("Quantity", qtyCtrl),
//
//                     _buildLabel("Pickup Date & Time"),
//                     TextFormField(
//                       controller: pickupTimeCtrl,
//                       readOnly: true,
//                       onTap: () => _selectDateTime(context),
//                       decoration: _inputStyle("Select time").copyWith(suffixIcon: const Icon(Icons.access_time, color: AppColor.green)),
//                       validator: (v) => v!.isEmpty ? "Required" : null,
//                     ),
//
//                     _buildField("Address", addressCtrl),
//                     _buildField("Description", descCtrl, maxLines: 2),
//
//                     const SizedBox(height: 15),
//                     TextButton.icon(
//                       onPressed: donorProvider.pickImages,
//                       icon: const Icon(Icons.add_a_photo, color: AppColor.green),
//                       label: Text("Add Images (${donorProvider.selectedImages.length})", style: const TextStyle(color: AppColor.green)),
//                     ),
//
//                     const SizedBox(height: 20),
//                     SizedBox(
//                       width: double.infinity,
//                       child: ElevatedButton(
//                         onPressed: donorProvider.isLoading ? null : _submit,
//                         style: ElevatedButton.styleFrom(backgroundColor: AppColor.green, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 14)),
//                         child: const Text("Submit Donation"),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//         if (donorProvider.isLoading)
//           Positioned.fill(child: Container(color: Colors.black45, child: const Center(child: CircularProgressIndicator(color: AppColor.green)))),
//       ],
//     );
//   }
//
//   void _submit() async {
//     if (!_formKey.currentState!.validate() || selectedExpiryDateTime == null) return;
//     try {
//       await context.read<DonorProvider>().submitPost(
//         foodName: foodCtrl.text.trim(),
//         quantity: qtyCtrl.text.trim(),
//         pickupTime: pickupTimeCtrl.text.trim(),
//         pickupAddress: addressCtrl.text.trim(),
//         description: descCtrl.text.trim(),
//         expiryDate: selectedExpiryDateTime!,
//       );
//       if (mounted) Navigator.pop(context);
//     } catch (e) { debugPrint("Submit Error: $e"); }
//   }
//
//   Widget _buildField(String label, TextEditingController ctrl, {int maxLines = 1}) {
//     return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//       _buildLabel(label),
//       TextFormField(controller: ctrl, maxLines: maxLines, decoration: _inputStyle("Enter $label"), validator: (v) => v!.isEmpty ? "Required" : null),
//     ]);
//   }
//
//   // 🔹 লেবেল বামে রাখার ফাংশন
//   Widget _buildLabel(String label) => Align(
//     alignment: Alignment.centerLeft,
//     child: Padding(
//         padding: const EdgeInsets.only(top: 10, bottom: 4),
//         child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600))
//     ),
//   );
//
//   InputDecoration _inputStyle(String hint) => InputDecoration(hintText: hint, contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10), enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: AppColor.green)), focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: AppColor.green, width: 2)));
// }


//
// import 'dart:io';
// import 'dart:typed_data';
// import 'package:intl/intl.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:waste_food_management/core/constants/app_colors.dart';
// import 'package:waste_food_management/features/auth/presentation/sections/show_aleart.dart';
// import '../../provider/donor_provider.dart';
//
// class CreateDonationDialog extends StatefulWidget {
//   const CreateDonationDialog({super.key});
//
//   @override
//   State<CreateDonationDialog> createState() => _CreateDonationDialogState();
// }
//
// class _CreateDonationDialogState extends State<CreateDonationDialog> {
//   final _formKey = GlobalKey<FormState>();
//   final foodCtrl = TextEditingController();
//   final qtyCtrl = TextEditingController();
//   final pickupTimeCtrl = TextEditingController();
//   final addressCtrl = TextEditingController();
//   final descCtrl = TextEditingController();
//
//   DateTime? selectedExpiryDateTime;
//   String? selectedFoodType; // 🔹 ফুড টাইপ স্টোর করার ভ্যারিয়েবল
//
//   // ড্রপডাউন অপশন লিস্ট
//   final List<String> foodTypes = ["Vegetarian", "Non-Vegetarian"];
//
//   Future<void> _selectDateTime(BuildContext context) async {
//     final now = DateTime.now();
//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: now,
//       firstDate: now,
//       lastDate: now.add(const Duration(days: 2)),
//     );
//
//     if (pickedDate != null) {
//       if (!mounted) return;
//       final TimeOfDay? pickedTime = await showTimePicker(
//         context: context,
//         initialTime: TimeOfDay.now(),
//       );
//
//       if (pickedTime != null) {
//         setState(() {
//           selectedExpiryDateTime = DateTime(
//             pickedDate.year, pickedDate.month, pickedDate.day,
//             pickedTime.hour, pickedTime.minute,
//           );
//           pickupTimeCtrl.text = DateFormat('MMM d, h:mm a').format(selectedExpiryDateTime!);
//         });
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final donorProvider = context.watch<DonorProvider>();
//
//     return Stack(
//       children: [
//         Dialog(
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//           child: Padding(
//             padding: const EdgeInsets.all(16),
//             child: Form(
//               key: _formKey,
//               child: SingleChildScrollView(
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     const Center(child: Text("Create Donation", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColor.green))),
//                     const Divider(),
//
//                     _buildField("Food Name", foodCtrl),
//
//                     // 🔹 Food Type Dropdown
//                     _buildLabel("Food Type"),
//                     DropdownButtonFormField<String>(
//                       value: selectedFoodType,
//                       hint: const Text("Select food type"),
//                       decoration: _inputStyle(""),
//                       icon: const Icon(Icons.keyboard_arrow_down, color: AppColor.green),
//                       items: foodTypes.map((String type) {
//                         return DropdownMenuItem(
//                           value: type,
//                           child: Text(type),
//                         );
//                       }).toList(),
//                       onChanged: (value) {
//                         setState(() {
//                           selectedFoodType = value;
//                         });
//                       },
//                       validator: (value) => value == null ? "Required" : null,
//                     ),
//
//                     _buildField("Quantity", qtyCtrl),
//
//                     _buildLabel("Pickup Date & Time"),
//                     TextFormField(
//                       controller: pickupTimeCtrl,
//                       readOnly: true,
//                       onTap: () => _selectDateTime(context),
//                       decoration: _inputStyle("Select time").copyWith(
//                           suffixIcon: const Icon(Icons.access_time, color: AppColor.green)
//                       ),
//                       validator: (v) => v!.isEmpty ? "Required" : null,
//                     ),
//
//                     _buildField("Address", addressCtrl),
//                     _buildField("Description", descCtrl, maxLines: 2),
//
//                     const SizedBox(height: 15),
//                     TextButton.icon(
//                       onPressed: donorProvider.pickImages,
//                       icon: const Icon(Icons.add_a_photo, color: AppColor.green),
//                       label: Text("Add Images (${donorProvider.selectedImages.length})", style: const TextStyle(color: AppColor.green)),
//                     ),
//
//                     const SizedBox(height: 20),
//                     SizedBox(
//                       width: double.infinity,
//                       child: ElevatedButton(
//                         onPressed: donorProvider.isLoading ? null : _submit,
//                         style: ElevatedButton.styleFrom(
//                             backgroundColor: AppColor.green,
//                             foregroundColor: Colors.white,
//                             padding: const EdgeInsets.symmetric(vertical: 14),
//                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
//                         ),
//                         child: const Text("Submit Donation", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//         if (donorProvider.isLoading)
//           Positioned.fill(
//               child: Container(
//                   decoration: BoxDecoration(
//                       color: Colors.black45,
//                       borderRadius: BorderRadius.circular(15)
//                   ),
//                   child: const Center(child: CircularProgressIndicator(color: AppColor.green))
//               )
//           ),
//       ],
//     );
//   }
//
//   void _submit() async {
//     if (!_formKey.currentState!.validate() || selectedExpiryDateTime == null) return;
//     try {
//       await context.read<DonorProvider>().submitPost(
//         foodName: foodCtrl.text.trim(),
//         foodType: selectedFoodType!, // 🔹 নতুন ফিল্ড অ্যাড করা হয়েছে
//         quantity: qtyCtrl.text.trim(),
//         pickupTime: pickupTimeCtrl.text.trim(),
//         pickupAddress: addressCtrl.text.trim(),
//         description: descCtrl.text.trim(),
//         expiryDate: selectedExpiryDateTime!,
//       );
//       if (mounted) Navigator.pop(context);
//     } catch (e) {
//       debugPrint("Submit Error: $e");
//     }
//   }
//
//   Widget _buildField(String label, TextEditingController ctrl, {int maxLines = 1}) {
//     return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//       _buildLabel(label),
//       TextFormField(
//           controller: ctrl,
//           maxLines: maxLines,
//           decoration: _inputStyle("Enter $label"),
//           validator: (v) => v!.isEmpty ? "Required" : null
//       ),
//     ]);
//   }
//
//   Widget _buildLabel(String label) => Align(
//     alignment: Alignment.centerLeft,
//     child: Padding(
//         padding: const EdgeInsets.only(top: 10, bottom: 4),
//         child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14))
//     ),
//   );
//
//   InputDecoration _inputStyle(String hint) => InputDecoration(
//     hintText: hint,
//     contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//     enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(8),
//         borderSide:  BorderSide(color: AppColor.green.withOpacity(0.5))
//     ),
//     focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(8),
//         borderSide: const BorderSide(color: AppColor.green, width: 2)
//     ),
//     errorBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(8),
//         borderSide: const BorderSide(color: Colors.red, width: 1)
//     ),
//     focusedErrorBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(8),
//         borderSide: const BorderSide(color: Colors.red, width: 2)
//     ),
//   );
// }


//
// import 'dart:io';
// import 'package:intl/intl.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:waste_food_management/core/constants/app_colors.dart';
// import '../../provider/donor_provider.dart';
//
// class CreateDonationDialog extends StatefulWidget {
//   const CreateDonationDialog({super.key});
//
//   @override
//   State<CreateDonationDialog> createState() => _CreateDonationDialogState();
// }
//
// class _CreateDonationDialogState extends State<CreateDonationDialog> {
//   final _formKey = GlobalKey<FormState>();
//
//   // কন্ট্রোলার সমূহ
//   final foodCtrl = TextEditingController();
//   final qtyCtrl = TextEditingController();
//   final personCountCtrl = TextEditingController();
//   final pickupTimeCtrl = TextEditingController();
//   final addressCtrl = TextEditingController();
//   final descCtrl = TextEditingController();
//
//   DateTime? selectedExpiryDateTime;
//   String? selectedFoodType;
//   String? selectedCondition; // 🔹 নতুন: Fresh/Leftover
//
//   final List<String> foodTypes = ["Vegetarian", "Non-Vegetarian"];
//   final List<String> conditions = ["Freshly Cooked", "Leftover Food"];
//
//   Future<void> _selectDateTime(BuildContext context) async {
//     final now = DateTime.now();
//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: now,
//       firstDate: now,
//       lastDate: now.add(const Duration(days: 2)),
//     );
//
//     if (pickedDate != null) {
//       if (!mounted) return;
//       final TimeOfDay? pickedTime = await showTimePicker(
//         context: context,
//         initialTime: TimeOfDay.now(),
//       );
//
//       if (pickedTime != null) {
//         setState(() {
//           selectedExpiryDateTime = DateTime(
//             pickedDate.year, pickedDate.month, pickedDate.day,
//             pickedTime.hour, pickedTime.minute,
//           );
//           pickupTimeCtrl.text = DateFormat('MMM d, h:mm a').format(selectedExpiryDateTime!);
//         });
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final donorProvider = context.watch<DonorProvider>();
//
//     return Dialog(
//       insetPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//       child: Stack(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: Form(
//               key: _formKey,
//               child: SingleChildScrollView(
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     // ড্র্যাগ হ্যান্ডেল বার (প্রফেশনাল লুকের জন্য)
//                     Container(height: 4, width: 40, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10))),
//                     const SizedBox(height: 15),
//                     const Text("Create Donation", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColor.green)),
//                     const SizedBox(height: 20),
//
//                     _buildField("Food Name", foodCtrl, icon: Icons.fastfood_outlined),
//
//                     Row(
//                       children: [
//                         Expanded(child: _buildDropdown("Food Type", foodTypes, selectedFoodType, (v) => setState(() => selectedFoodType = v))),
//                         const SizedBox(width: 10),
//                         Expanded(child: _buildDropdown("Condition", conditions, selectedCondition, (v) => setState(() => selectedCondition = v))),
//                       ],
//                     ),
//
//                     Row(
//                       children: [
//                         Expanded(child: _buildField("Est. Persons", personCountCtrl, icon: Icons.people_outline, keyboardType: TextInputType.number)),
//                         const SizedBox(width: 10),
//                         Expanded(child: _buildField("Quantity", qtyCtrl, icon: Icons.scale_outlined)),
//                       ],
//                     ),
//
//                     _buildLabel("Pickup Date & Time"),
//                     TextFormField(
//                       controller: pickupTimeCtrl,
//                       readOnly: true,
//                       onTap: () => _selectDateTime(context),
//                       decoration: _inputStyle("Select time").copyWith(
//                         prefixIcon: const Icon(Icons.event_available, color: AppColor.green, size: 20),
//                       ),
//                       validator: (v) => v!.isEmpty ? "Required" : null,
//                     ),
//
//                     _buildField("Pickup Address", addressCtrl, icon: Icons.location_on_outlined),
//                     _buildField("Special Note", descCtrl, maxLines: 2, icon: Icons.note_add_outlined, maxLength: 50),
//
//                     const SizedBox(height: 20),
//
//                     // ইমেজ সিলেকশন সেকশন
//                     _buildImageSection(donorProvider),
//
//                     const SizedBox(height: 25),
//
//                     SizedBox(
//                       width: double.infinity,
//                       height: 50,
//                       child: ElevatedButton(
//                         onPressed: donorProvider.isLoading ? null : _submit,
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: AppColor.green,
//                           foregroundColor: Colors.white,
//                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                           elevation: 0,
//                         ),
//                         child: const Text("Post Donation", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//
//           // লোডার ওভারলে
//           if (donorProvider.isLoading)
//             Positioned.fill(
//               child: Container(
//                 decoration: BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.circular(20)),
//                 child: const Center(child: CircularProgressIndicator(color: AppColor.green)),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
//
//   // 🔹 ইমেজ সিলেকশন গ্রিড
//   Widget _buildImageSection(DonorProvider provider) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _buildLabel("Food Images"),
//         if (provider.selectedImages.isNotEmpty)
//           SizedBox(
//             height: 80,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: provider.selectedImages.length,
//               itemBuilder: (context, index) {
//                 return Stack(
//                   children: [
//                     Container(
//                       margin: const EdgeInsets.only(right: 8),
//                       width: 80,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         image: DecorationImage(
//                           image: FileImage(File(provider.selectedImages[index].path)),
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                     Positioned(
//                       right: 12, top: 4,
//                       child: GestureDetector(
//                         onTap: () => provider.removeImage(index),
//                         child: const CircleAvatar(radius: 10, backgroundColor: Colors.red, child: Icon(Icons.close, size: 12, color: Colors.white)),
//                       ),
//                     ),
//                   ],
//                 );
//               },
//             ),
//           ),
//         const SizedBox(height: 10),
//         InkWell(
//           onTap: provider.pickImages,
//           child: Container(
//             width: double.infinity,
//             padding: const EdgeInsets.symmetric(vertical: 12),
//             decoration: BoxDecoration(
//               border: Border.all(color: AppColor.green.withOpacity(0.3)),
//               borderRadius: BorderRadius.circular(12),
//               color: AppColor.green.withOpacity(0.05),
//             ),
//             child: const Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(Icons.add_a_photo_outlined, color: AppColor.green, size: 20),
//                 SizedBox(width: 8),
//                 Text("Add Food Photos", style: TextStyle(color: AppColor.green, fontWeight: FontWeight.bold)),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   // 🔹 হেল্পার উইজেট: ড্রপডাউন
//   Widget _buildDropdown(String label, List<String> items, String? value, Function(String?) onChanged) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _buildLabel(label),
//         DropdownButtonFormField<String>(
//           value: value,
//           isExpanded: true,
//           decoration: _inputStyle("Select"),
//           items: items.map((e) => DropdownMenuItem(value: e, child: Text(e, style: const TextStyle(fontSize: 13)))).toList(),
//           onChanged: onChanged,
//           validator: (v) => v == null ? "Required" : null,
//         ),
//       ],
//     );
//   }
//
//   // 🔹 হেল্পার উইজেট: টেক্সট ফিল্ড
//   Widget _buildField(String label, TextEditingController ctrl, {int maxLines = 1, IconData? icon, TextInputType? keyboardType, int? maxLength}) {
//     return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//       _buildLabel(label),
//       TextFormField(
//         controller: ctrl,
//         maxLines: maxLines,
//         maxLength: maxLength,
//         keyboardType: keyboardType,
//         decoration: _inputStyle("Enter $label").copyWith(
//           prefixIcon: icon != null ? Icon(icon, color: AppColor.green, size: 18) : null,
//         ),
//         validator: (v) => v!.isEmpty ? "Required" : null,
//       ),
//     ]);
//   }
//
//   Widget _buildLabel(String label) => Padding(
//     padding: const EdgeInsets.only(top: 12, bottom: 5),
//     child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87)),
//   );
//
//   InputDecoration _inputStyle(String hint) => InputDecoration(
//     hintText: hint,
//     hintStyle: const TextStyle(fontSize: 13, color: Colors.grey),
//     contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//     filled: true,
//     fillColor: Colors.grey[50],
//     enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey[200]!)),
//     focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColor.green, width: 1.5)),
//     errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.redAccent)),
//     focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.redAccent, width: 1.5)),
//   );
//
//   void _submit() async {
//     if (!_formKey.currentState!.validate() || selectedExpiryDateTime == null) {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please fill all fields and select images")));
//       return;
//     }
//
//     try {
//       await context.read<DonorProvider>().submitPost(
//         foodName: foodCtrl.text.trim(),
//         foodType: selectedFoodType!,
//         foodCondition: selectedCondition!, // 🔹 নতুন
//         estimatePersons: personCountCtrl.text.trim(), // 🔹 নতুন
//         quantity: qtyCtrl.text.trim(),
//         pickupTime: pickupTimeCtrl.text.trim(),
//         pickupAddress: addressCtrl.text.trim(),
//         description: descCtrl.text.trim(),
//         expiryDate: selectedExpiryDateTime!,
//       );
//       if (mounted) Navigator.pop(context);
//     } catch (e) {
//       debugPrint("Submit Error: $e");
//     }
//   }
// }

import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // TextInputFormatter এর জন্য
import 'package:provider/provider.dart';
import 'package:waste_food_management/core/constants/app_colors.dart';
import '../../provider/donor_provider.dart';

class CreateDonationDialog extends StatefulWidget {
  const CreateDonationDialog({super.key});

  @override
  State<CreateDonationDialog> createState() => _CreateDonationDialogState();
}

class _CreateDonationDialogState extends State<CreateDonationDialog> {
  final _formKey = GlobalKey<FormState>();

  // কন্ট্রোলার সমূহ
  final foodCtrl = TextEditingController();
  final qtyCtrl = TextEditingController();
  final personCountCtrl = TextEditingController();
  final pickupTimeCtrl = TextEditingController();
  final addressCtrl = TextEditingController();
  final descCtrl = TextEditingController();

  DateTime? selectedExpiryDateTime;
  String? selectedFoodType;
  String? selectedCondition;

  final List<String> foodTypes = ["Vegetarian", "Non-Vegetarian"];
  final List<String> conditions = ["Freshly Cooked", "Leftover Food"];

  // 🔹 তারিখ ও সময় নির্বাচন
  Future<void> _selectDateTime(BuildContext context) async {
    final now = DateTime.now();
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 2)),
    );

    if (pickedDate != null) {
      if (!mounted) return;
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          selectedExpiryDateTime = DateTime(
            pickedDate.year, pickedDate.month, pickedDate.day,
            pickedTime.hour, pickedTime.minute,
          );
          pickupTimeCtrl.text = DateFormat('MMM d, h:mm a').format(selectedExpiryDateTime!);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final donorProvider = context.watch<DonorProvider>();

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(height: 4, width: 40, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10))),
                    const SizedBox(height: 15),
                    const Text("Create Donation", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColor.green)),
                    const SizedBox(height: 20),

                    // ১. ফুড নেম (মিনিমাম ৩ ক্যারেক্টার)
                    _buildField(
                      "Food Name", foodCtrl,
                      icon: Icons.fastfood_outlined,
                      validator: (v) => _v(v, "Food name", min: 3, max: 40),
                    ),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _buildDropdown("Food Type", foodTypes, selectedFoodType, (v) => setState(() => selectedFoodType = v))),
                        const SizedBox(width: 10),
                        Expanded(child: _buildDropdown("Condition", conditions, selectedCondition, (v) => setState(() => selectedCondition = v))),
                      ],
                    ),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ২. এস্টিমেটেড পারসন (শুধুমাত্র সংখ্যা)
                        Expanded(child: _buildField(
                          "Est. Persons", personCountCtrl,
                          icon: Icons.people_outline,
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          validator: (v) => _v(v, "Count", max: 4),
                        )),
                        const SizedBox(width: 10),
                        // ৩. কুয়ান্টিটি (যেমন: ২ কেজি বা ৫ প্যাকেট)
                        Expanded(child: _buildField(
                          "Quantity", qtyCtrl,
                          icon: Icons.scale_outlined,
                          validator: (v) => _v(v, "Quantity", min: 2, max: 15),
                        )),
                      ],
                    ),

                    _buildLabel("Pickup Date & Time"),
                    TextFormField(
                      controller: pickupTimeCtrl,
                      readOnly: true,
                      onTap: () => _selectDateTime(context),
                      style: const TextStyle(fontSize: 14),
                      decoration: _inputStyle("Select time").copyWith(
                        prefixIcon: const Icon(Icons.event_available, color: AppColor.green, size: 20),
                      ),
                      validator: (v) => (v == null || v.isEmpty) ? "Required" : null,
                    ),

                    // ৪. এড্রেস (মিনিমাম ১০ ক্যারেক্টার)
                    _buildField(
                      "Pickup Address", addressCtrl,
                      icon: Icons.location_on_outlined,
                      validator: (v) => _v(v, "Address", min: 10, max: 100),
                    ),

                    // ৫. স্পেশাল নোট (অপশনাল - তাই স্টার নেই)
                    _buildField(
                      "Special Note", descCtrl,
                      maxLines: 2,
                      icon: Icons.note_add_outlined,
                      maxLength: 50,
                      isRequired: false,
                    ),

                    const SizedBox(height: 20),
                    _buildImageSection(donorProvider),
                    const SizedBox(height: 25),

                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: donorProvider.isLoading ? null : _submit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.green,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text("Post Donation", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          if (donorProvider.isLoading)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.circular(20)),
                child: const Center(child: CircularProgressIndicator(color: AppColor.green)),
              ),
            ),
        ],
      ),
    );
  }

  // --- 🔹 হেল্পার মেথড সমূহ ---

  // কাস্টম ভ্যালিডেটর লজিক
  String? _v(String? value, String field, {int min = 1, int max = 100}) {
    if (value == null || value.trim().isEmpty) return "$field required";
    if (value.length < min) return "Min $min chars";
    if (value.length > max) return "Max $max chars";
    return null;
  }

  // লাল স্টার সহ লেবেল
  Widget _buildLabel(String label, {bool isRequired = true}) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 5),
      child: Row(
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87)),
          if (isRequired) const Text(" *", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  // টেক্সট ফিল্ড মেথড (আপডেটেড)
  Widget _buildField(String label, TextEditingController ctrl,
      {int maxLines = 1, IconData? icon, TextInputType? keyboardType,
        int? maxLength, String? Function(String?)? validator,
        bool isRequired = true, List<TextInputFormatter>? inputFormatters}) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _buildLabel(label, isRequired: isRequired),
      TextFormField(
        controller: ctrl,
        maxLines: maxLines,
        maxLength: maxLength,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        style: const TextStyle(fontSize: 14),
        decoration: _inputStyle("Enter $label").copyWith(
          prefixIcon: icon != null ? Icon(icon, color: AppColor.green, size: 18) : null,
          counterText: "", // ক্যারেক্টার কাউন্টার হাইড রাখা
        ),
        validator: isRequired ? (validator ?? (v) => v!.isEmpty ? "Required" : null) : null,
      ),
    ]);
  }

  Widget _buildDropdown(String label, List<String> items, String? value, Function(String?) onChanged) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _buildLabel(label),
      DropdownButtonFormField<String>(
        value: value,
        isExpanded: true,
        style: const TextStyle(fontSize: 14, color: Colors.black),
        decoration: _inputStyle("Select"),
        items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
        onChanged: onChanged,
        validator: (v) => v == null ? "Required" : null,
      ),
    ]);
  }

  InputDecoration _inputStyle(String hint) => InputDecoration(
    hintText: hint,
    hintStyle: const TextStyle(fontSize: 13, color: Colors.grey),
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    filled: true,
    fillColor: Colors.grey[50],
    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey[200]!)),
    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColor.green, width: 1.5)),
    errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.redAccent)),
    focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.redAccent, width: 1.5)),
    errorStyle: const TextStyle(fontSize: 11),
  );

  Widget _buildImageSection(DonorProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel("Food Images"),
        if (provider.selectedImages.isNotEmpty)
          SizedBox(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: provider.selectedImages.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(right: 8),
                  width: 80,
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(File(provider.selectedImages[index].path), width: 80, height: 80, fit: BoxFit.cover),
                      ),
                      Positioned(
                        right: 4, top: 4,
                        child: InkWell(
                          onTap: () => provider.removeImage(index),
                          child: const CircleAvatar(radius: 10, backgroundColor: Colors.red, child: Icon(Icons.close, size: 12, color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        const SizedBox(height: 10),
        InkWell(
          onTap: provider.pickImages,
          child: Container(
            width: double.infinity, padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: AppColor.green.withOpacity(0.3)),
              borderRadius: BorderRadius.circular(12), color: AppColor.green.withOpacity(0.05),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add_a_photo_outlined, color: AppColor.green, size: 20),
                SizedBox(width: 8),
                Text("Add Food Photos", style: TextStyle(color: AppColor.green, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _submit() async {
    final provider = context.read<DonorProvider>();

    // ১. ফর্ম ভ্যালিডেশন চেক
    if (!_formKey.currentState!.validate()) return;

    // ২. ডেট ও টাইম চেক
    if (selectedExpiryDateTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please select pickup time"), backgroundColor: Colors.red));
      return;
    }

    // ৩. ইমেজ চেক
    if (provider.selectedImages.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please upload food images"), backgroundColor: Colors.red));
      return;
    }

    try {
      await provider.submitPost(
        foodName: foodCtrl.text.trim(),
        foodType: selectedFoodType!,
        foodCondition: selectedCondition!,
        estimatePersons: personCountCtrl.text.trim(),
        quantity: qtyCtrl.text.trim(),
        pickupTime: pickupTimeCtrl.text.trim(),
        pickupAddress: addressCtrl.text.trim(),
        description: descCtrl.text.trim(),
        expiryDate: selectedExpiryDateTime!,
      );
      if (mounted) Navigator.pop(context);
    } catch (e) {
      debugPrint("Submit Error: $e");
    }
  }

  @override
  void dispose() {
    foodCtrl.dispose(); qtyCtrl.dispose(); personCountCtrl.dispose();
    pickupTimeCtrl.dispose(); addressCtrl.dispose(); descCtrl.dispose();
    super.dispose();
  }
}