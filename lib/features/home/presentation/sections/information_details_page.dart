// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:waste_food_management/features/auth/presentation/sections/dynamic_screen_wrapper.dart';
// import 'package:waste_food_management/features/auth/presentation/sections/show_aleart.dart';
// import 'package:waste_food_management/features/auth/provider/generic_auth_provider.dart';
// import '../screens/donor/presentation/screens/donor_home_screen.dart';
// import '../screens/receiver/presentation/screens/receiver_home_screen.dart';
// import '../screens/volunteer/presentation/screens/volunteer_home_screen.dart';
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
//   late GenericAuthProvider auth;
//
//   /// ===============================
//   /// USER TYPE
//   /// ===============================
//   int selectedIndex = 0;
//
//   String get userType {
//     switch (selectedIndex) {
//       case 0:
//         return "Restaurant";
//       case 1:
//         return "Bakery";
//       case 2:
//         return "Individual";
//       default:
//         return "Unknown";
//     }
//   }
//
//   /// ===============================
//   /// FORM KEY
//   /// ===============================
//   final _formKey = GlobalKey<FormState>();
//
//   /// ===============================
//   /// CONTROLLERS
//   /// ===============================
//   final c1 = TextEditingController();
//   final c2 = TextEditingController();
//   final c3 = TextEditingController();
//   final emailC = TextEditingController();
//   final addressC = TextEditingController();
//   final postCodeC = TextEditingController();
//   final cityC = TextEditingController();
//
//   /// ===============================
//   /// OPTIONS
//   /// ===============================
//   final List<Map<String, dynamic>> option = [
//     {"title": "Restaurant", "icon": Icons.store},
//     {"title": "Bakery", "icon": Icons.cake},
//     {"title": "Individual", "icon": Icons.person},
//   ];
//
//   /// ===============================
//   /// LABEL MAP
//   /// ===============================
//   final Map<String, String> nameLabelMap = {
//     "Restaurant": "Company Name",
//     "Bakery": "Business Name",
//     "Individual": "Full Name",
//   };
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     auth = Provider.of<GenericAuthProvider>(context, listen: false);
//
//     // 🔹 email set from firebase user (read-only)
//     emailC.text = auth.user?.email ?? '';
//   }
//
//   /// ===============================
//   /// FORM DATA
//   /// ===============================
//   Map<String, dynamic> buildFormData() {
//     return {
//       "userType": userType,
//       "businessOrFullName": c1.text.trim(),
//       "contactPerson": c2.text.trim(),
//       "phone": c3.text.trim(),
//       "email": emailC.text.trim(),
//       "address": addressC.text.trim(),
//       "postCode": postCodeC.text.trim(),
//       "city": cityC.text.trim(),
//     };
//   }
//
//   /// ===============================
//   /// SUBMIT FORM
//   /// ===============================
//   void submitForm() async {
//     if (!_formKey.currentState!.validate()) return;
//
//     final data = buildFormData();
//
//     try {
//       await auth.saveUserProfile(data);
//
//       if (!mounted) return;
//
//       final role = auth.selectedRole ?? '';
//
//       debugPrint("USER ROLE 👉 $role");
//       debugPrint("PROFILE DATA 👉 $data");
//
//       // 🔹 Show success alert
//       ShowAlertMessage(
//         context: context,
//         title: 'Success',
//         boldText: 'Profile saved!',
//         message: 'Your information has been successfully updated.',
//         isSuccess: true
//       );
//
//       // 🔹 Navigate based on role
//       if (role == "Donor") {
//         Navigator.pushReplacementNamed(context, DonorHomeScreen.routeName);
//       } else if (role.toLowerCase() == "Receiver") {
//         Navigator.pushReplacementNamed(context, ReceiverHomeScreen.routeName);
//       } else if (role.toLowerCase() == "Volunteer") {
//         Navigator.pushReplacementNamed(context, VolunteerHomeScreen.routeName);
//       }
//     } catch (e) {
//       debugPrint("Error saving profile: $e");
//       ShowAlertMessage(
//         context: context,
//         title: 'Error',
//         boldText: 'Profile not saved!',
//         message: 'Something went wrong. Please try again.',
//         isSuccess: false
//       );
//     }
//   }
//
//   /// ===============================
//   /// UI
//   /// ===============================
//   @override
//   Widget build(BuildContext context) {
//     return DynamicScreenWrapper(
//       child: Column(
//         children: [
//           /// 🔹 TOP OPTIONS
//           Row(
//             children: List.generate(option.length, (index) {
//               final isSelected = selectedIndex == index;
//
//               return Expanded(
//                 child: Padding(
//                   padding: const EdgeInsets.only(right: 12),
//                   child: GestureDetector(
//                     onTap: () => setState(() => selectedIndex = index),
//                     child: Container(
//                       height: 100,
//                       decoration: BoxDecoration(
//                         color: isSelected ? Colors.green.shade200 : Colors.green,
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(option[index]["icon"], color: Colors.white),
//                           const SizedBox(height: 8),
//                           Text(
//                             option[index]["title"],
//                             style: const TextStyle(color: Colors.white),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             }),
//           ),
//
//           const SizedBox(height: 20),
//
//           /// 🔹 FORM
//           Form(
//             key: _formKey,
//             child: GetInformationForm(
//               consumerNameLabel: nameLabelMap[userType]!,
//               contactNameLabel: "Contact Person",
//               phoneNumberLabel: "Phone Number",
//               emailLabel: "Email ID",
//               addressLabel: "Address",
//               postCodeLabel: "Post Code",
//               cityLabel: "City",
//
//               consumerNameController: c1,
//               contactNameController: c2,
//               phoneNumberController: c3,
//               emailController: emailC,
//               addressController: addressC,
//               postCodeController: postCodeC,
//               cityController: cityC,
//
//               consumerKeyboard: TextInputType.text,
//               contactKeyboard: TextInputType.text,
//               phoneKeyboard: TextInputType.phone,
//               emailKeyboard: TextInputType.emailAddress,
//               addressKeyboard: TextInputType.streetAddress,
//               postCodeKeyboard: TextInputType.number,
//               cityKeyboard: TextInputType.text,
//
//               onPinLocation: () {},
//               onSubmit: submitForm,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   /// ===============================
//   /// DISPOSE CONTROLLERS
//   /// ===============================
//   @override
//   void dispose() {
//     c1.dispose();
//     c2.dispose();
//     c3.dispose();
//     emailC.dispose();
//     addressC.dispose();
//     postCodeC.dispose();
//     cityC.dispose();
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
import '../screens/donor/presentation/screens/donor_home_screen.dart';
import '../screens/receiver/presentation/screens/receiver_home_screen.dart';
import '../screens/volunteer/presentation/screens/volunteer_home_screen.dart';
import '../widgets/get_information_form.dart';

class EasyInformationForm extends StatefulWidget {
  const EasyInformationForm({super.key});

  @override
  State<EasyInformationForm> createState() => _EasyInformationFormState();
}

class _EasyInformationFormState extends State<EasyInformationForm> {
  late GenericAuthProvider auth;

  /// ===============================
  /// USER TYPE
  /// ===============================
  int selectedIndex = 0;

  String get userType {
    switch (selectedIndex) {
      case 0:
        return "Restaurant";
      case 1:
        return "Bakery";
      case 2:
        return "Individual";
      default:
        return "Unknown";
    }
  }

  /// ===============================
  /// FORM KEY
  /// ===============================
  final _formKey = GlobalKey<FormState>();

  /// ===============================
  /// CONTROLLERS
  /// ===============================
  final c1 = TextEditingController();
  final c2 = TextEditingController();
  final c3 = TextEditingController();
  final emailC = TextEditingController();
  final addressC = TextEditingController();
  final postCodeC = TextEditingController();
  final cityC = TextEditingController();

  /// ===============================
  /// OPTIONS
  /// ===============================
  final List<Map<String, dynamic>> option = [
    {"title": "Restaurant", "icon": Icons.store},
    {"title": "Bakery", "icon": Icons.cake},
    {"title": "Individual", "icon": Icons.person},
  ];

  /// ===============================
  /// LABEL MAP
  /// ===============================
  final Map<String, String> nameLabelMap = {
    "Restaurant": "Company Name",
    "Bakery": "Business Name",
    "Individual": "Full Name",
  };

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    auth = Provider.of<GenericAuthProvider>(context, listen: false);

    // 🔹 email set from firebase user (read-only)
    emailC.text = auth.user?.email ?? '';
  }

  /// ===============================
  /// FORM DATA
  /// ===============================
  Map<String, dynamic> buildFormData() {
    return {
      "userType": userType,
      "businessOrFullName": c1.text.trim(),
      "contactPerson": c2.text.trim(),
      "phone": c3.text.trim(),
      "email": emailC.text.trim(),
      "address": addressC.text.trim(),
      "postCode": postCodeC.text.trim(),
      "city": cityC.text.trim(),
    };
  }

  /// ===============================
  /// SUBMIT FORM
  /// ===============================
  // void submitForm() async{
  //   // Navigator.push(context, MaterialPageRoute(builder: (context)=> DonorScreen()));
  //   if (!_formKey.currentState!.validate()) return;
  //   final data = buildFormData();
  //   try{
  //     await auth.saveUserProfile(data);
  //     await auth.loadUserRole();
  //     if(!mounted)return;
  //     final String role = auth.selectedRole.toString().toLowerCase();
  //     debugPrint(auth.selectedRole.toString());
  //     ShowAlertMessage(context: context,
  //       title: 'Success',
  //       boldText: 'Profile saved!',
  //       message: 'Your information has been successfully updated.',
  //       isSuccess: true,);
  //     if(role == "donor"){
  //       Navigator.pushReplacementNamed(context, DonorScreen.routeName);
  //     }else if(role == "receiver"){
  //       Navigator.pushReplacementNamed(context, ReceiverScreen.routeName);
  //     }else if(role == "volunteer"){
  //       Navigator.pushReplacementNamed(context, VolunteerScreen.routeName);
  //     }
  //
  //   }catch (e){
  //     ShowAlertMessage(
  //       context: context,
  //       title: 'Error',
  //       boldText: 'Profile not saved!',
  //       message: 'Something went wrong. Please try again.',
  //       isSuccess: false,
  //     );
  //     debugPrint(e.toString());
  //   }
  //
  // }


  void submitForm() async {
    if (!_formKey.currentState!.validate()) return;
    final data = buildFormData();

    try {
      await auth.saveUserProfile(data);
      await auth.loadUserRole();
      if (!mounted) return;

      final String role = auth.selectedRole.toString().toLowerCase();

      // ১. ডায়ালগটি দেখান।
      // যদি আপনার ShowAlertMessage একটি showDialog রিটার্ন করে,
      // তবে এখানে 'await' ব্যবহার করুন যাতে ডায়ালগ বন্ধ না হওয়া পর্যন্ত নিচের কোড না চলে।
       ShowAlertMessage(
        context: context,
        title: 'Success',
        boldText: 'Profile saved!',
        message: 'Your information has been successfully updated.',
        isSuccess: true,
      );

      // ২. ডায়ালগ বন্ধ হওয়ার পর নেভিগেশন হবে
      if (!mounted) return;

      if (role == "donor") {
        Navigator.pushNamedAndRemoveUntil(context, DonorScreen.routeName, (route) => false);
      } else if (role == "receiver") {
        Navigator.pushNamedAndRemoveUntil(context, ReceiverScreen.routeName, (route) => false);
      } else if (role == "volunteer") {
        Navigator.pushNamedAndRemoveUntil(context, VolunteerScreen.routeName, (route) => false);
      }

    } catch (e) {
      // এরর এলার্ট
      ShowAlertMessage(
        context: context,
        title: 'Error',
        boldText: 'Profile not saved!',
        message: 'Something went wrong. Please try again.',
        isSuccess: false,
      );
      debugPrint(e.toString());
    }
  }





  /// ===============================
  /// UI
  /// ===============================
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            /// 🔹 TOP OPTIONS
            Row(
              children: List.generate(option.length, (index) {
                final isSelected = selectedIndex == index;

                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: GestureDetector(
                      onTap: () => setState(() => selectedIndex = index),
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          color:
                          isSelected ? AppColor.green : AppColor.lightGreen,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(option[index]["icon"], color: AppColor.white),
                            const SizedBox(height: 8),
                            Text(
                              option[index]["title"],
                              style:  TextStyle(color: AppColor.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),

            const SizedBox(height: 20),

            /// 🔹 FORM FIELDS
            GetInformationForm(
              consumerNameLabel: nameLabelMap[userType]!,
              contactNameLabel: "Contact Person",
              phoneNumberLabel: "Phone Number",
              emailLabel: "Email ID",
              addressLabel: "Address",
              postCodeLabel: "Post Code",
              cityLabel: "City",

              consumerNameController: c1,
              contactNameController: c2,
              phoneNumberController: c3,
              emailController: emailC,
              addressController: addressC,
              postCodeController: postCodeC,
              cityController: cityC,

              consumerKeyboard: TextInputType.text,
              contactKeyboard: TextInputType.text,
              phoneKeyboard: TextInputType.phone,
              emailKeyboard: TextInputType.emailAddress,
              addressKeyboard: TextInputType.streetAddress,
              postCodeKeyboard: TextInputType.number,
              cityKeyboard: TextInputType.text,

              onPinLocation: () {},
              onSubmit: submitForm,

              // 🔹 VALIDATORS
              consumerValidator: (value) =>
              value == null || value.isEmpty ? 'Required' : null,
              contactValidator: (value) =>
              value == null || value.isEmpty ? 'Required' : null,
              phoneValidator: (value) =>
              value == null || value.isEmpty ? 'Required' : null,
              addressValidator: (value) =>
              value == null || value.isEmpty ? 'Required' : null,
              postCodeValidator: (value) =>
              value == null || value.isEmpty ? 'Required' : null,
              cityValidator: (value) =>
              value == null || value.isEmpty ? 'Required' : null,
              emailValidator: (value) =>
              value == null || value.isEmpty ? 'Required' : null,
            ),
          ],
        ),
      ),
    );
  }

  /// ===============================
  /// DISPOSE CONTROLLERS
  /// ===============================
  @override
  void dispose() {
    c1.dispose();
    c2.dispose();
    c3.dispose();
    emailC.dispose();
    addressC.dispose();
    postCodeC.dispose();
    cityC.dispose();
    super.dispose();
  }
}
