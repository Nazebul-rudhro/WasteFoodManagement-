import 'package:flutter/material.dart';
import 'package:waste_food_management/app/app_theme.dart';
import '../widgets/profile_option.dart';

class GenericProfileWidget extends StatelessWidget {
  final VoidCallback onSignOut;
  final Map<String, VoidCallback> options; // Dynamic options

  const GenericProfileWidget({
    super.key,
    required this.onSignOut,
    required this.options,
  });

  @override
  Widget build(BuildContext context) {
    final double spacing = MediaQuery.of(context).size.height * 0.03;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(child: Text("MY Profile", style: AppData.heading1)),
        const Divider(),
        SizedBox(height: spacing),

        // Generate buttons dynamically
        ...options.entries.map((entry) {
          return Column(
            children: [
              ProfileOption(title: entry.key, onTap: entry.value),
              SizedBox(height: spacing),
            ],
          );
        }),

        Center(
          child: TextButton(
            onPressed: onSignOut,
            child: Text("Sign Out", style: AppData.heading2),
          ),
        ),
        SizedBox(height: spacing),
      ],
    );
  }
}
