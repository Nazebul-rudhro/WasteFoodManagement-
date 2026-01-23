import 'package:flutter/material.dart';
import '../../../auth/data/model/profile_option_model.dart';
import '../widgets/logout_button.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_options.dart';

class GenericProfileWidget extends StatelessWidget {
  final List<ProfileOptionItem> options;
  final VoidCallback onSignOut;

  const GenericProfileWidget({
    super.key,
    required this.options,
    required this.onSignOut,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileHeader(),
        const SizedBox(height: 20),
        ProfileOptions(options: options),
        const SizedBox(height: 30),
        LogoutButton(onSignOut: onSignOut),
      ],
    );
  }
}
