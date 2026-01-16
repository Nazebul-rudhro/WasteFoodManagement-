import 'package:flutter/material.dart';
import '../../../../../../auth/presentation/sections/dynamic_screen_wrapper.dart';
import '../../../../sections/information_details_page.dart';

class GetInformationDetails extends StatefulWidget {
  const GetInformationDetails({super.key});
  static String routeName = "DonerDetails";

  @override
  State<GetInformationDetails> createState() => GetInformationDetailsState();
}

class GetInformationDetailsState extends State<GetInformationDetails> {
  // Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  @override
  void dispose() {
    // Dispose controllers
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    addressController.dispose();
    postalCodeController.dispose();
    cityController.dispose();
    super.dispose();
  }

  void handleSubmit() {
    print("Name / Company: ${nameController.text}");
    print("Phone: ${phoneController.text}");
    print("Email: ${emailController.text}");
    print("Address: ${addressController.text}");
    print("Postal Code: ${postalCodeController.text}");
    print("City: ${cityController.text}");
    // এখানে তুমি next screen navigate করতে পারো
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DynamicScreenWrapper(
        child: EasyInformationForm(),
      ),
    );
  }
}
