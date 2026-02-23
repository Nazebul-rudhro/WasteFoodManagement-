// import 'package:flutter/material.dart';
// import '../../../auth/data/model/profile_option_model.dart';
//
// class ProfileOptions extends StatelessWidget {
//   final List<ProfileOptionItem> options;
//
//   const ProfileOptions({super.key, required this.options});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: const Offset(0, 5),
//           ),
//         ],
//       ),
//       child: Column(
//         children: List.generate(options.length, (index) {
//           final option = options[index];
//
//           return Column(
//             children: [
//               ListTile(
//                 leading: Icon(
//                   option.icon,
//                   color: Colors.green,
//                 ),
//                 title: Text(
//                   option.title,
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 trailing: const Icon(Icons.chevron_right),
//                 onTap: option.onTap,
//               ),
//               if (index != options.length - 1)
//                 const Divider(height: 1),
//             ],
//           );
//         }),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../auth/data/model/profile_option_model.dart';

class ProfileOptions extends StatelessWidget {
  final List<ProfileOptionItem> options;

  const ProfileOptions({super.key, required this.options});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        // ডার্ক মোডে হালকা গ্রে-কালো, লাইট মোডে সাদা
        color: isDark ? const Color(0xFF1E1E1E) : AppColor.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.2 : 0.05),
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
                  color: AppColor.green, // আপনার Emerald Green
                ),
                title: Text(
                  option.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    // টেক্সট কালার থিম অনুযায়ী
                    color: isDark ? AppColor.white : AppColor.black,
                  ),
                ),
                trailing: Icon(
                  Icons.chevron_right,
                  color: isDark ? AppColor.mediumtgray : AppColor.gray,
                ),
                onTap: option.onTap,
              ),
              if (index != options.length - 1)
                Divider(
                  height: 1,
                  color: isDark ? AppColor.gray.withOpacity(0.2) : AppColor.lightGray,
                ),
            ],
          );
        }),
      ),
    );
  }
}