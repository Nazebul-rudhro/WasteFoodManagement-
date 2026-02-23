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
                          List<String> validCodes = ['013', '014', '015', '016','017', '018', '019'];
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