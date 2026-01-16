import 'package:flutter/material.dart';
import 'package:waste_food_management/features/auth/presentation/sections/dynamic_screen_wrapper.dart';
import '../screens/donor/presentation/screens/donor_screen.dart';
import '../widgets/get_information_form.dart';
import 'location_picker_creen.dart';

class EasyInformationForm extends StatefulWidget {
  const EasyInformationForm({super.key});

  @override
  State<EasyInformationForm> createState() => _EasyInformationFormState();
}

class _EasyInformationFormState extends State<EasyInformationForm> {
  int selectedIndex = 0;

  final _formKey = GlobalKey<FormState>();

  // 🔹 Controllers
  final c1 = TextEditingController();
  final c2 = TextEditingController();
  final c3 = TextEditingController();

  final emailC = TextEditingController();
  final addressC = TextEditingController();
  final postCodeC = TextEditingController();
  final cityC = TextEditingController();

  final List<Map<String, dynamic>> option = [
    {"title": "Restaurant", "icon": Icons.store},
    {"title": "Bakery", "icon": Icons.cake},
    {"title": "Individual", "icon": Icons.person},
  ];

  /// 🔹 Location Picker
  // void openLocationPicker() {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (_) => LocationPickerScreen(
  //         onPicked: (latLng) {
  //           setState(() {
  //             addressC.text =
  //             "Lat: ${latLng.latitude}, Lng: ${latLng.longitude}";
  //           });
  //         },
  //       ),
  //     ),
  //   );
  // }

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      debugPrint("Name: ${c1.text}");
      debugPrint("Contact: ${c2.text}");
      debugPrint("Phone: ${c3.text}");
      debugPrint("Email: ${emailC.text}");
      debugPrint("Address: ${addressC.text}");
      debugPrint("Post Code: ${postCodeC.text}");
      debugPrint("City: ${cityC.text}");
      Navigator.pushNamed(context, DonorScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;

    return DynamicScreenWrapper(
      child: Column(
        children: [
          /// 🔹 Top Options
          Row(
            children: List.generate(option.length, (index) {
              final isSelected = selectedIndex == index;

              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: GestureDetector(
                  onTap: () => setState(() => selectedIndex = index),
                  child: Container(
                    height: 100,
                    width: widthScreen / 4,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.green.shade200
                          : Colors.green,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(option[index]["icon"], color: Colors.white),
                        const SizedBox(height: 8),
                        Text(
                          option[index]["title"],
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),

          const SizedBox(height: 20),

          /// 🔹 Form
          Form(
            key: _formKey,
            child: GetInformationForm(
              consumerNameLabel:
              selectedIndex == 2 ? "Full Name" : "Business Name",
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

              onSubmit: submitForm,
              onPinLocation: () {  },
              // onPinLocation: openLocationPicker,
            ),
          ),
        ],
      ),
    );
  }
}
