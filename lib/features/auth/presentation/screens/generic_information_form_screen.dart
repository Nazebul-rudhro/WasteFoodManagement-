import 'package:flutter/material.dart';

import '../../../home/presentation/sections/information_details_page.dart';
import '../sections/dynamic_screen_wrapper.dart';
class GenericInformationFormScreen extends StatefulWidget {
  const GenericInformationFormScreen({super.key});
  static String routeName = "/generic-information-form";

  @override
  State<GenericInformationFormScreen> createState() => _GenericInformationFormScreenState();
}

class _GenericInformationFormScreenState extends State<GenericInformationFormScreen> {
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DynamicScreenWrapper(
        child: EasyInformationForm(),
      ),
    );
  }
}
