import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../app/app_theme.dart';
import '../../../../core/constants/app_colors.dart';
class LoginButton extends StatelessWidget{
  const LoginButton({super.key, required this.buttonName, required this.buttonAction});
  final String  buttonName;
  final VoidCallback buttonAction;

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: buttonAction,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          buttonName,
          style: AppTheme.heading2.copyWith(color: Colors.white),
        ),
      ),
    );
  }

}