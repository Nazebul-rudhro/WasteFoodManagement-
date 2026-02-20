// // //
// // //
// // //
// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// // import 'package:waste_food_management/core/constants/app_colors.dart';
// // import 'package:waste_food_management/features/auth/presentation/sections/show_aleart.dart';
// // import 'package:waste_food_management/features/auth/provider/generic_auth_provider.dart';
// // import 'package:waste_food_management/features/home/presentation/screens/donor/presentation/screens/donor_screen.dart';
// // import 'package:waste_food_management/features/home/presentation/screens/receiver/presentation/screens/receiver_screen.dart';
// // import 'package:waste_food_management/features/home/presentation/screens/volunteer/presentation/screens/volunteer_screen.dart';
// // import 'package:waste_food_management/features/home/presentation/sections/base_screen.dart';
// // import '../widgets/get_information_form.dart';
// //
// // class EasyInformationForm extends StatefulWidget {
// //   const EasyInformationForm({super.key});
// //
// //   @override
// //   State<EasyInformationForm> createState() => _EasyInformationFormState();
// // }
// //
// // class _EasyInformationFormState extends State<EasyInformationForm> {
// //   late GenericAuthProvider auth;
// //   bool isLoading = false;
// //
// //   int selectedIndex = 0;
// //   final _formKey = GlobalKey<FormState>();
// //
// //   /// ===============================
// //   /// CONTROLLERS
// //   /// ===============================
// //   final c1 = TextEditingController();
// //   final c2 = TextEditingController();
// //   final c3 = TextEditingController();
// //   final emailC = TextEditingController();
// //   final addressC = TextEditingController();
// //   final postCodeC = TextEditingController();
// //   final cityC = TextEditingController();
// //
// //   final List<Map<String, dynamic>> option = [
// //     {"title": "Restaurant", "icon": Icons.store},
// //     {"title": "Bakery", "icon": Icons.cake},
// //     {"title": "Individual", "icon": Icons.person},
// //   ];
// //
// //   final Map<String, String> nameLabelMap = {
// //     "Restaurant": "Company Name",
// //     "Bakery": "Business Name",
// //     "Individual": "Full Name",
// //   };
// //
// //   @override
// //   void didChangeDependencies() {
// //     super.didChangeDependencies();
// //     auth = Provider.of<GenericAuthProvider>(context, listen: false);
// //     emailC.text = auth.user?.email ?? '';
// //   }
// //
// //   String get accountType {
// //     switch (selectedIndex) {
// //       case 0: return "Restaurant";
// //       case 1: return "Bakery";
// //       case 2: return "Individual";
// //       default: return "Unknown";
// //     }
// //   }
// //
// //   Map<String, dynamic> buildFormData() {
// //     return {
// //       "accountType": accountType,
// //       "businessOrFullName": c1.text.trim(),
// //       "contactPerson": c2.text.trim(),
// //       "phone": c3.text.trim(),
// //       "email": emailC.text.trim(),
// //       "address": addressC.text.trim(),
// //       "postCode": postCodeC.text.trim(),
// //       "city": cityC.text.trim(),
// //     };
// //   }
// //
// //   void submitForm() async {
// //     if (!_formKey.currentState!.validate()) return;
// //
// //     setState(() => isLoading = true);
// //
// //     try {
// //       final data = buildFormData();
// //       await auth.saveUserProfile(data);
// //       await auth.loadUserRole();
// //
// //       if (!mounted) return;
// //       final String role = auth.selectedRole.toString().toLowerCase();
// //
// //       setState(() => isLoading = false);
// //
// //       String routeName = '';
// //       if (role == "donor") routeName = DonorScreen.routeName;
// //       else if (role == "receiver") routeName = ReceiverScreen.routeName;
// //       else if (role == "volunteer") routeName = VolunteerScreen.routeName;
// //
// //       if (routeName.isNotEmpty) {
// //         Navigator.pushNamedAndRemoveUntil(context, routeName, (route) => false);
// //
// //         Future.delayed(const Duration(milliseconds: 300), () {
// //           ShowAlertMessage(
// //             context: context,
// //             title: 'Success',
// //             boldText: 'Profile saved!',
// //             message: 'Your information has been successfully updated.',
// //             isSuccess: true,
// //           );
// //         });
// //       }
// //
// //     } catch (e) {
// //       setState(() => isLoading = false);
// //       ShowAlertMessage(
// //         context: context,
// //         title: 'Error',
// //         boldText: 'Error',
// //         message: 'Something went wrong. Please try again.',
// //         isSuccess: false,
// //       );
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return BaseScreen(
// //       child: Stack(
// //         children: [
// //           Form(
// //             key: _formKey,
// //             child: SingleChildScrollView(
// //               padding: const EdgeInsets.only(bottom: 20),
// //               child: Column(
// //                 children: [
// //                   /// 🔹 TOP OPTIONS
// //                   Row(
// //                     children: List.generate(option.length, (index) {
// //                       final isSelected = selectedIndex == index;
// //                       return Expanded(
// //                         child: Padding(
// //                           padding: const EdgeInsets.only(right: 12),
// //                           child: GestureDetector(
// //                             onTap: isLoading ? null : () => setState(() => selectedIndex = index),
// //                             child: Container(
// //                               height: 100,
// //                               decoration: BoxDecoration(
// //                                 color: isSelected ? AppColor.green : AppColor.lightGreen,
// //                                 borderRadius: BorderRadius.circular(8),
// //                               ),
// //                               child: Column(
// //                                 mainAxisAlignment: MainAxisAlignment.center,
// //                                 children: [
// //                                   Icon(option[index]["icon"], color: AppColor.white),
// //                                   const SizedBox(height: 8),
// //                                   Text(
// //                                     option[index]["title"],
// //                                     style: const TextStyle(color: AppColor.white, fontWeight: FontWeight.bold),
// //                                   ),
// //                                 ],
// //                               ),
// //                             ),
// //                           ),
// //                         ),
// //                       );
// //                     }),
// //                   ),
// //
// //                   const SizedBox(height: 20),
// //
// //                   /// 🔹 FORM FIELDS
// //                   GetInformationForm(
// //                     consumerNameLabel: nameLabelMap[accountType]!,
// //                     contactNameLabel: "Contact Person",
// //                     phoneNumberLabel: "Phone Number",
// //                     emailLabel: "Email ID",
// //                     addressLabel: "Address",
// //                     postCodeLabel: "Post Code",
// //                     cityLabel: "City",
// //
// //                     consumerNameController: c1,
// //                     contactNameController: c2,
// //                     phoneNumberController: c3,
// //                     emailController: emailC,
// //                     addressController: addressC,
// //                     postCodeController: postCodeC,
// //                     cityController: cityC,
// //
// //                     consumerKeyboard: TextInputType.text,
// //                     contactKeyboard: TextInputType.text,
// //                     phoneKeyboard: TextInputType.number, // সংখ্যা কিবোর্ড
// //                     emailKeyboard: TextInputType.emailAddress,
// //                     addressKeyboard: TextInputType.streetAddress,
// //                     postCodeKeyboard: TextInputType.number, // সংখ্যা কিবোর্ড
// //                     cityKeyboard: TextInputType.text,
// //
// //                     onPinLocation: () {},
// //                     onSubmit: isLoading ? () {} : submitForm,
// //
// //                     // Validators
// //                     consumerValidator: (v) => v == null || v.isEmpty ? 'Required' : null,
// //                     contactValidator: (v) => v == null || v.isEmpty ? 'Required' : null,
// //
// //                     // ফোন ভ্যালিডেশন: শুধুমাত্র ১১টি সংখ্যা
// //                     phoneValidator: (v) {
// //                       if (v == null || v.isEmpty) return 'Required';
// //                       final numberRegex = RegExp(r'^[0-9]+$');
// //                       if (!numberRegex.hasMatch(v)) return 'Enter numbers only';
// //                       if (v.length != 11) return 'Phone must be exactly 11 digits';
// //                       return null;
// //                     },
// //
// //                     addressValidator: (v) => v == null || v.isEmpty ? 'Required' : null,
// //
// //                     // পোস্ট কোড ভ্যালিডেশন: শুধুমাত্র ৪টি সংখ্যা
// //                     postCodeValidator: (v) {
// //                       if (v == null || v.isEmpty) return 'Required';
// //                       final numberRegex = RegExp(r'^[0-9]+$');
// //                       if (!numberRegex.hasMatch(v)) return 'Enter numbers only';
// //                       if (v.length != 4) return 'Post code must be exactly 4 digits';
// //                       return null;
// //                     },
// //
// //                     cityValidator: (v) => v == null || v.isEmpty ? 'Required' : null,
// //                     emailValidator: (v) => v == null || v.isEmpty ? 'Required' : null,
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ),
// //
// //           /// 🔹 CENTERED LOADING OVERLAY
// //           if (isLoading)
// //             Positioned.fill(
// //               child: Container(
// //                 color: Colors.white.withOpacity(0.5), // ঝাপসা ব্যাকগ্রাউন্ড
// //                 child: const Center(
// //                   child: CircularProgressIndicator(
// //                     color: AppColor.green,
// //                     strokeWidth: 4,
// //                   ),
// //                 ),
// //               ),
// //             ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   @override
// //   void dispose() {
// //     c1.dispose();
// //     c2.dispose();
// //     c3.dispose();
// //     emailC.dispose();
// //     addressC.dispose();
// //     postCodeC.dispose();
// //     cityC.dispose();
// //     super.dispose();
// //   }
// // }
// //
// //
// //
//
//
//
//
//
//
//
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:waste_food_management/core/constants/app_colors.dart';
// import 'package:waste_food_management/features/auth/presentation/sections/show_aleart.dart';
// import 'package:waste_food_management/features/auth/provider/generic_auth_provider.dart';
// import 'package:waste_food_management/features/home/presentation/screens/donor/presentation/screens/donor_screen.dart';
// import 'package:waste_food_management/features/home/presentation/screens/receiver/presentation/screens/receiver_screen.dart';
// import 'package:waste_food_management/features/home/presentation/screens/volunteer/presentation/screens/volunteer_screen.dart';
// import 'package:waste_food_management/features/home/presentation/sections/base_screen.dart';
// import '../widgets/get_information_form.dart';
//
// class EasyInformationForm extends StatefulWidget {
//   const EasyInformationForm({super.key});
//
//   @override
//   State<EasyInformationForm> createState() => _EasyInformationFormState();
// }
//
// class _EasyInformationFormState extends State<EasyInformationForm> {
//   int selectedIndex = 0;
//   bool isLoading = false;
//   final _formKey = GlobalKey<FormState>();
//
//   // Controllers
//   final c1 = TextEditingController();
//   final c2 = TextEditingController();
//   final c3 = TextEditingController();
//   final emailC = TextEditingController();
//   final addressC = TextEditingController();
//   final postCodeC = TextEditingController();
//   final cityC = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final auth = Provider.of<GenericAuthProvider>(context, listen: false);
//       emailC.text = auth.user?.email ?? '';
//     });
//   }
//
//   // 🔹 রোল অনুযায়ী অপশন লিস্ট জেনারেট করা
//   List<Map<String, dynamic>> _getOptions(String? role) {
//     final r = role?.toLowerCase() ?? 'donor';
//     if (r == 'receiver') {
//       return [
//         {"title": "NGO", "icon": Icons.foundation},
//         {"title": "Orphanage", "icon": Icons.home_work},
//         {"title": "Individual", "icon": Icons.person},
//       ];
//     } else if (r == 'volunteer') {
//       return [
//         {"title": "Bicycle", "icon": Icons.directions_bike},
//         {"title": "Motorbike", "icon": Icons.motorcycle},
//         {"title": "Mini Truck", "icon": Icons.local_shipping},
//       ];
//     } else {
//       return [
//         {"title": "Restaurant", "icon": Icons.store},
//         {"title": "Bakery", "icon": Icons.cake},
//         {"title": "Individual", "icon": Icons.person},
//       ];
//     }
//   }
//
//   // 🔹 টাইটেল অনুযায়ী লেবেল সেট করা
//   String _getLabel(String title, String? role) {
//     if (role == 'volunteer') return "Vehicle Model / Plate No";
//     if (title == "Individual") return "Full Name";
//     if (title == "NGO" || title == "Orphanage") return "Organization Name";
//     return "Business / Company Name";
//   }
//
//   void submitForm(GenericAuthProvider auth, List<Map<String, dynamic>> options) async {
//     if (!_formKey.currentState!.validate()) return;
//     setState(() => isLoading = true);
//
//     try {
//       final data = {
//         "accountType": options[selectedIndex]["title"],
//         "businessOrFullName": c1.text.trim(),
//         "contactPerson": c2.text.trim(),
//         "phone": c3.text.trim(),
//         "email": emailC.text.trim(),
//         "address": addressC.text.trim(),
//         "postCode": postCodeC.text.trim(),
//         "city": cityC.text.trim(),
//         "role": auth.selectedRole,
//       };
//
//       await auth.saveUserProfile(data);
//       if (!mounted) return;
//
//       final role = auth.selectedRole?.toLowerCase() ?? 'donor';
//       String routeName = '';
//       if (role == "donor") routeName = DonorScreen.routeName;
//       else if (role == "receiver") routeName = ReceiverScreen.routeName;
//       else if (role == "volunteer") routeName = VolunteerScreen.routeName;
//
//       setState(() => isLoading = false);
//
//       Navigator.pushNamedAndRemoveUntil(context, routeName, (route) => false);
//       ShowAlertMessage(
//         context: context,
//         title: 'Success',
//         boldText: 'Profile saved!',
//         message: 'Information updated successfully.',
//         isSuccess: true,
//       );
//     } catch (e) {
//       setState(() => isLoading = false);
//       ShowAlertMessage(context: context, title: 'Error', message: 'Failed to update profile.', isSuccess: false, boldText: '');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<GenericAuthProvider>(
//       builder: (context, auth, child) {
//         final options = _getOptions(auth.selectedRole);
//         final currentTitle = options[selectedIndex]["title"];
//
//         return BaseScreen(
//           child: Stack(
//             children: [
//               Form(
//                 key: _formKey,
//                 child: SingleChildScrollView(
//                   padding: const EdgeInsets.all(16),
//                   child: Column(
//                     children: [
//                       // 🔹 Horizontal Option Cards
//                       Row(
//                         children: List.generate(options.length, (index) {
//                           final isSelected = selectedIndex == index;
//                           return Expanded(
//                             child: Padding(
//                               padding: const EdgeInsets.symmetric(horizontal: 4),
//                               child: GestureDetector(
//                                 onTap: () => setState(() => selectedIndex = index),
//                                 child: Container(
//                                   height: 90,
//                                   decoration: BoxDecoration(
//                                     color: isSelected ? AppColor.green : AppColor.lightGreen.withOpacity(0.3),
//                                     borderRadius: BorderRadius.circular(10),
//                                     border: Border.all(color: isSelected ? AppColor.green : Colors.transparent),
//                                   ),
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Icon(options[index]["icon"], color: isSelected ? Colors.white : AppColor.green),
//                                       const SizedBox(height: 5),
//                                       Text(
//                                         options[index]["title"],
//                                         style: TextStyle(
//                                           color: isSelected ? Colors.white : AppColor.green,
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 12,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           );
//                         }),
//                       ),
//                       const SizedBox(height: 25),
//
//                       // 🔹 Dynamic Form
//                       GetInformationForm(
//                         consumerNameLabel: _getLabel(currentTitle, auth.selectedRole),
//                         contactNameLabel: "Contact Person",
//                         phoneNumberLabel: "Phone Number",
//                         emailLabel: "Email Address",
//                         addressLabel: "Full Address",
//                         postCodeLabel: "Post Code",
//                         cityLabel: "City",
//                         consumerNameController: c1,
//                         contactNameController: c2,
//                         phoneNumberController: c3,
//                         emailController: emailC,
//                         addressController: addressC,
//                         postCodeController: postCodeC,
//                         cityController: cityC,
//                         consumerKeyboard: TextInputType.text,
//                         contactKeyboard: TextInputType.text,
//                         phoneKeyboard: TextInputType.number,
//                         emailKeyboard: TextInputType.emailAddress,
//                         addressKeyboard: TextInputType.streetAddress,
//                         postCodeKeyboard: TextInputType.number,
//                         cityKeyboard: TextInputType.text,
//                         onPinLocation: () {},
//                         onSubmit: () => submitForm(auth, options),
//
//                         consumerValidator: (v) => v!.isEmpty ? 'Required' : null,
//                         contactValidator: (v) => v!.isEmpty ? 'Required' : null,
//                         phoneValidator: (v) => v!.length != 11 ? '11 digits required' : null,
//                         addressValidator: (v) => v!.isEmpty ? 'Required' : null,
//                         postCodeValidator: (v) => v!.length != 4 ? '4 digits required' : null,
//                         cityValidator: (v) => v!.isEmpty ? 'Required' : null,
//                         emailValidator: (v) => v!.isEmpty ? 'Required' : null,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               if (isLoading)
//                 const Center(child: CircularProgressIndicator(color: AppColor.green)),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   @override
//   void dispose() {
//     c1.dispose(); c2.dispose(); c3.dispose(); emailC.dispose();
//     addressC.dispose(); postCodeC.dispose(); cityC.dispose();
//     super.dispose();
//   }
// }

//
//
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:waste_food_management/core/constants/app_colors.dart';
// import 'package:waste_food_management/features/auth/presentation/sections/show_aleart.dart';
// import 'package:waste_food_management/features/auth/provider/generic_auth_provider.dart';
// import 'package:waste_food_management/features/home/presentation/screens/donor/presentation/screens/donor_screen.dart';
// import 'package:waste_food_management/features/home/presentation/screens/receiver/presentation/screens/receiver_screen.dart';
// import 'package:waste_food_management/features/home/presentation/screens/volunteer/presentation/screens/volunteer_screen.dart';
// import 'package:waste_food_management/features/home/presentation/sections/base_screen.dart';
// import '../widgets/get_information_form.dart';
//
// class EasyInformationForm extends StatefulWidget {
//   const EasyInformationForm({super.key});
//
//   @override
//   State<EasyInformationForm> createState() => _EasyInformationFormState();
// }
//
// class _EasyInformationFormState extends State<EasyInformationForm> {
//   int selectedIndex = 0;
//   bool isLoading = false;
//   final _formKey = GlobalKey<FormState>();
//
//   // Controllers
//   final c1 = TextEditingController();
//   final c2 = TextEditingController();
//   final c3 = TextEditingController();
//   final emailC = TextEditingController();
//   final addressC = TextEditingController();
//   final postCodeC = TextEditingController();
//   final cityC = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final auth = Provider.of<GenericAuthProvider>(context, listen: false);
//       emailC.text = auth.user?.email ?? '';
//     });
//   }
//
//   List<Map<String, dynamic>> _getOptions(String? role) {
//     final r = role?.toLowerCase() ?? 'donor';
//     if (r == 'receiver') {
//       return [
//         {"title": "NGO", "icon": Icons.foundation},
//         {"title": "Orphanage", "icon": Icons.home_work},
//         {"title": "Individual", "icon": Icons.person},
//       ];
//     } else if (r == 'volunteer') {
//       return [
//         {"title": "Bicycle", "icon": Icons.directions_bike},
//         {"title": "Motorbike", "icon": Icons.motorcycle},
//         {"title": "Mini Truck", "icon": Icons.local_shipping},
//       ];
//     } else {
//       return [
//         {"title": "Restaurant", "icon": Icons.store},
//         {"title": "Bakery", "icon": Icons.cake},
//         {"title": "Individual", "icon": Icons.person},
//       ];
//     }
//   }
//
//   String _getLabel(String title, String? role) {
//     if (role == 'volunteer') return "Vehicle Model / Plate No";
//     if (title == "Individual") return "Full Name";
//     if (title == "NGO" || title == "Orphanage") return "Organization Name";
//     return "Business / Company Name";
//   }
//
//   void submitForm(GenericAuthProvider auth, List<Map<String, dynamic>> options) async {
//     if (!_formKey.currentState!.validate()) return;
//     setState(() => isLoading = true);
//
//     try {
//       final data = {
//         "accountType": options[selectedIndex]["title"],
//         "businessOrFullName": c1.text.trim(),
//         "contactPerson": c2.text.trim(),
//         "phone": c3.text.trim(),
//         "email": emailC.text.trim(),
//         "address": addressC.text.trim(),
//         "postCode": postCodeC.text.trim(),
//         "city": cityC.text.trim(),
//         "role": auth.selectedRole,
//       };
//
//       await auth.saveUserProfile(data);
//       if (!mounted) return;
//
//       final role = auth.selectedRole?.toLowerCase() ?? 'donor';
//       String routeName = '';
//       if (role == "donor") routeName = DonorScreen.routeName;
//       else if (role == "receiver") routeName = ReceiverScreen.routeName;
//       else if (role == "volunteer") routeName = VolunteerScreen.routeName;
//
//       setState(() => isLoading = false);
//
//       Navigator.pushNamedAndRemoveUntil(context, routeName, (route) => false);
//       ShowAlertMessage(
//         context: context,
//         title: 'Success',
//         boldText: 'Profile saved!',
//         message: 'Information Upload successfully.',
//         isSuccess: true,
//       );
//     } catch (e) {
//       setState(() => isLoading = false);
//       ShowAlertMessage(context: context, title: 'Error', message: 'Failed to update profile.', isSuccess: false, boldText: 'Something went to Wrong!!');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<GenericAuthProvider>(
//       builder: (context, auth, child) {
//         final options = _getOptions(auth.selectedRole);
//         final currentTitle = options[selectedIndex]["title"];
//
//         return BaseScreen(
//           child: Stack(
//             children: [
//               Form(
//                 key: _formKey,
//                 child: SingleChildScrollView(
//                   padding: const EdgeInsets.all(5),
//                   child: Column(
//                     children: [
//                       Row(
//                         children: List.generate(options.length, (index) {
//                           final isSelected = selectedIndex == index;
//                           return Expanded(
//                             child: Padding(
//                               padding: const EdgeInsets.symmetric(horizontal: 4),
//                               child: GestureDetector(
//                                 onTap: () => setState(() => selectedIndex = index),
//                                 child: Container(
//                                   height: 90,
//                                   decoration: BoxDecoration(
//                                     color: isSelected ? AppColor.green : AppColor.lightGreen.withOpacity(0.3),
//                                     borderRadius: BorderRadius.circular(10),
//                                     border: Border.all(color: isSelected ? AppColor.green : Colors.transparent),
//                                   ),
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Icon(options[index]["icon"], color: isSelected ? Colors.white : AppColor.green),
//                                       const SizedBox(height: 5),
//                                       Text(
//                                         options[index]["title"],
//                                         style: TextStyle(
//                                           color: isSelected ? Colors.white : AppColor.green,
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 12,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           );
//                         }),
//                       ),
//                       const SizedBox(height: 25),
//
//                       GetInformationForm(
//                         consumerNameLabel: _getLabel(currentTitle, auth.selectedRole),
//                         contactNameLabel: "Contact Person",
//                         phoneNumberLabel: "Phone Number",
//                         emailLabel: "Email Address",
//                         addressLabel: "Full Address",
//                         postCodeLabel: "Post Code",
//                         cityLabel: "City",
//
//                         consumerNameController: c1,
//                         contactNameController: c2,
//                         phoneNumberController: c3,
//                         emailController: emailC,
//                         addressController: addressC,
//                         postCodeController: postCodeC,
//                         cityController: cityC,
//
//                         // 🔹 Professional Validators
//                         consumerValidator: (v) {
//                           if (v == null || v.isEmpty) return 'Required';
//                           if (v.length > 30) return 'Cannot exceed 30 characters';
//                           return null;
//                         },
//                         contactValidator: (v) {
//                           if (v == null || v.isEmpty) return 'Required';
//                           if (v.length > 30) return 'Cannot exceed 30 characters';
//                           return null;
//                         },
//                         phoneValidator: (v) {
//                           if (v == null || v.isEmpty) return 'Required';
//                           final numberRegex = RegExp(r'^[0-9]+$');
//                           if (!numberRegex.hasMatch(v)) return 'Enter numbers only';
//                           if (v.length != 11) return 'Must be 11 digits';
//
//                           // অপারেটর কোড চেক (013, 014, 015, 016, 018, 019)
//                           List<String> validCodes = ['013', '014', '015', '016', '018', '019'];
//                           if (!validCodes.contains(v.substring(0, 3))) {
//                             return 'Invalid operator code';
//                           }
//                           return null;
//                         },
//                         addressValidator: (v) => v!.isEmpty ? 'Required' : null,
//                         postCodeValidator: (v) {
//                           if (v == null || v.isEmpty) return 'Required';
//                           if (v.length != 4) return 'Must be 4 digits';
//                           return null;
//                         },
//                         cityValidator: (v) => v!.isEmpty ? 'Required' : null,
//                         emailValidator: (v) => v!.isEmpty ? 'Required' : null,
//
//                         onPinLocation: () {},
//                         onSubmit: () => submitForm(auth, options),
//
//                         consumerKeyboard: TextInputType.text,
//                         contactKeyboard: TextInputType.text,
//                         phoneKeyboard: TextInputType.number,
//                         emailKeyboard: TextInputType.emailAddress,
//                         addressKeyboard: TextInputType.streetAddress,
//                         postCodeKeyboard: TextInputType.number,
//                         cityKeyboard: TextInputType.text,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               if (isLoading)
//                 const Center(child: CircularProgressIndicator(color: AppColor.green)),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   @override
//   void dispose() {
//     c1.dispose(); c2.dispose(); c3.dispose(); emailC.dispose();
//     addressC.dispose(); postCodeC.dispose(); cityC.dispose();
//     super.dispose();
//   }
// }



import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waste_food_management/core/constants/app_colors.dart';
import 'package:waste_food_management/features/auth/presentation/sections/show_aleart.dart';
import 'package:waste_food_management/features/auth/provider/generic_auth_provider.dart';
import 'package:waste_food_management/features/home/presentation/screens/donor/presentation/screens/donor_screen.dart';
import 'package:waste_food_management/features/home/presentation/screens/receiver/presentation/screens/receiver_screen.dart';
import 'package:waste_food_management/features/home/presentation/screens/volunteer/presentation/screens/volunteer_screen.dart';
import 'package:waste_food_management/features/home/presentation/sections/base_screen.dart';
import '../widgets/get_information_form.dart';

class EasyInformationForm extends StatefulWidget {
  const EasyInformationForm({super.key});

  @override
  State<EasyInformationForm> createState() => _EasyInformationFormState();
}

class _EasyInformationFormState extends State<EasyInformationForm> {
  int selectedIndex = 0;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final c1 = TextEditingController();
  final c2 = TextEditingController();
  final c3 = TextEditingController();
  final emailC = TextEditingController();
  final addressC = TextEditingController();
  final postCodeC = TextEditingController();
  final cityC = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final auth = Provider.of<GenericAuthProvider>(context, listen: false);
      emailC.text = auth.user?.email ?? '';
    });
  }

  // 🔹 রোল অনুযায়ী ডাইনামিক অপশন জেনারেট
  List<Map<String, dynamic>> _getOptions(String? role) {
    final r = role?.toLowerCase() ?? 'donor';
    if (r == 'receiver') {
      return [
        {"title": "NGO", "icon": Icons.foundation},
        {"title": "Orphanage", "icon": Icons.home_work},
        {"title": "Individual", "icon": Icons.person},
      ];
    } else if (r == 'volunteer') {
      return [
        {"title": "Bicycle", "icon": Icons.directions_bike},
        {"title": "Motorbike", "icon": Icons.motorcycle},
        {"title": "Mini Truck", "icon": Icons.local_shipping},
      ];
    } else {
      return [
        {"title": "Restaurant", "icon": Icons.store},
        {"title": "Bakery", "icon": Icons.cake},
        {"title": "Individual", "icon": Icons.person},
      ];
    }
  }

  // 🔹 প্রফেশনাল লেবেল লজিক
  String _getLabel(String title, String? role) {
    if (role == 'volunteer') return "Vehicle Model / Plate No";
    if (title == "Individual") return "Full Name";
    if (title == "NGO" || title == "Orphanage") return "Organization Name";
    return "Business / Company Name";
  }

  // 🔹 সাবমিট ফাংশন
  void submitForm(GenericAuthProvider auth, List<Map<String, dynamic>> options) async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    try {
      final data = {
        "accountType": options[selectedIndex]["title"],
        "businessOrFullName": c1.text.trim(),
        "contactPerson": c2.text.trim(),
        "phone": c3.text.trim(),
        "email": emailC.text.trim(),
        "address": addressC.text.trim(),
        "postCode": postCodeC.text.trim(),
        "city": cityC.text.trim(),
        "role": auth.selectedRole,
      };

      await auth.saveUserProfile(data);
      if (!mounted) return;

      final role = auth.selectedRole?.toLowerCase() ?? 'donor';
      String routeName = '';
      if (role == "donor") routeName = DonorScreen.routeName;
      else if (role == "receiver") routeName = ReceiverScreen.routeName;
      else if (role == "volunteer") routeName = VolunteerScreen.routeName;

      setState(() => isLoading = false);

      Navigator.pushNamedAndRemoveUntil(context, routeName, (route) => false);

      ShowAlertMessage(
        context: context,
        title: 'Success',
        boldText: 'Profile saved!',
        message: 'Information upload successful.',
        isSuccess: true,
      );
    } catch (e) {
      setState(() => isLoading = false);
      ShowAlertMessage(
          context: context,
          title: 'Error',
          message: 'Something went wrong!',
          isSuccess: false,
          boldText: 'Error Occurred'
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GenericAuthProvider>(
      builder: (context, auth, child) {
        final options = _getOptions(auth.selectedRole);
        final currentTitle = options[selectedIndex]["title"];

        return BaseScreen(
          child: Stack(
            children: [
              Form(
                key: _formKey,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(10), // ভালো স্পেসিং এর জন্য
                  child: Column(
                    children: [
                      // --- 🔹 TOP TAB OPTIONS ---
                      Row(
                        children: List.generate(options.length, (index) {
                          final isSelected = selectedIndex == index;
                          return Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4),
                              child: GestureDetector(
                                onTap: isLoading ? null : () => setState(() => selectedIndex = index),
                                child: Container(
                                  height: 90,
                                  decoration: BoxDecoration(
                                    color: isSelected ? AppColor.green : AppColor.lightGreen.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: isSelected ? AppColor.green : Colors.transparent),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(options[index]["icon"], color: isSelected ? Colors.white : AppColor.green),
                                      const SizedBox(height: 5),
                                      Text(
                                        options[index]["title"],
                                        style: TextStyle(
                                          color: isSelected ? Colors.white : AppColor.green,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 25),

                      // --- 🔹 FORM FIELDS ---
                      GetInformationForm(
                        consumerNameLabel: _getLabel(currentTitle, auth.selectedRole),
                        contactNameLabel: "Contact Person",
                        phoneNumberLabel: "Phone Number",
                        emailLabel: "Email Address",
                        addressLabel: "Full Address",
                        postCodeLabel: "Post Code",
                        cityLabel: "City",

                        consumerNameController: c1,
                        contactNameController: c2,
                        phoneNumberController: c3,
                        emailController: emailC,
                        addressController: addressC,
                        postCodeController: postCodeC,
                        cityController: cityC,

                        // --- 🔹 VALIDATION LOGIC ---
                        consumerValidator: (v) {
                          if (v == null || v.isEmpty) return 'Required';
                          if (v.length > 30) return 'Max 30 characters';
                          return null;
                        },
                        contactValidator: (v) {
                          if (v == null || v.isEmpty) return 'Required';
                          if (v.length > 30) return 'Max 30 characters';
                          return null;
                        },
                        phoneValidator: (v) {
                          if (v == null || v.isEmpty) return 'Required';
                          final numberRegex = RegExp(r'^[0-9]+$');
                          if (!numberRegex.hasMatch(v)) return 'Numbers only';
                          if (v.length != 11) return 'Must be 11 digits';

                          // অপারেটর কোড চেক (013, 014, 015, 016, 018, 019)
                          List<String> validCodes = ['013', '014', '015', '016', '018', '019'];
                          if (!validCodes.contains(v.substring(0, 3))) {
                            return 'Invalid operator code';
                          }
                          return null;
                        },
                        addressValidator: (v) => v == null || v.isEmpty ? 'Required' : null,
                        postCodeValidator: (v) {
                          if (v == null || v.isEmpty) return 'Required';
                          if (v.length != 4) return 'Must be 4 digits';
                          return null;
                        },
                        cityValidator: (v) => v == null || v.isEmpty ? 'Required' : null,
                        emailValidator: (v) => v == null || v.isEmpty ? 'Required' : null,

                        onPinLocation: () {}, // এখানে ম্যাপের ফাংশন কল হবে
                        onSubmit: () => submitForm(auth, options),

                        consumerKeyboard: TextInputType.text,
                        contactKeyboard: TextInputType.text,
                        phoneKeyboard: TextInputType.number,
                        emailKeyboard: TextInputType.emailAddress,
                        addressKeyboard: TextInputType.streetAddress,
                        postCodeKeyboard: TextInputType.number,
                        cityKeyboard: TextInputType.text,
                      ),
                    ],
                  ),
                ),
              ),

              // --- 🔹 CENTERED LOADING OVERLAY ---
              if (isLoading)
                Positioned.fill(
                  child: AbsorbPointer(
                    child: Container(
                      color: Colors.white.withOpacity(0.6),
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: AppColor.green,
                          strokeWidth: 4,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    c1.dispose(); c2.dispose(); c3.dispose(); emailC.dispose();
    addressC.dispose(); postCodeC.dispose(); cityC.dispose();
    super.dispose();
  }
}