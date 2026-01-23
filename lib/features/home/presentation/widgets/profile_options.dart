import 'package:flutter/material.dart';
import '../../../auth/data/model/profile_option_model.dart';

class ProfileOptions extends StatelessWidget {
  final List<ProfileOptionItem> options;

  const ProfileOptions({super.key, required this.options});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: List.generate(options.length, (index) {
          final option = options[index];

          return Column(
            children: [
              ListTile(
                leading: Icon(
                  option.icon,
                  color: Colors.green,
                ),
                title: Text(
                  option.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: option.onTap,
              ),
              if (index != options.length - 1)
                const Divider(height: 1),
            ],
          );
        }),
      ),
    );
  }
}
