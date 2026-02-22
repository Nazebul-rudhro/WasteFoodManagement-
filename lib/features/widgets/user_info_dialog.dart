// import 'package:flutter/material.dart';
//
// class UserInfoDialog extends StatelessWidget {
//   final Map<String, dynamic> data;
//
//   const UserInfoDialog({super.key, required this.data});
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//       titlePadding: EdgeInsets.zero,
//       title: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: const BoxDecoration(
//           color: Colors.green,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(20),
//             topRight: Radius.circular(20),
//           ),
//         ),
//         child: const Row(
//           children: [
//             Icon(Icons.person_pin, color: Colors.white, size: 28),
//             SizedBox(width: 10),
//             Text("Personal Info", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//           ],
//         ),
//       ),
//       content: SingleChildScrollView(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             _infoTile(Icons.user_Type, "User Type", data['userType']),
//             _infoTile(Icons.person, "Full Name", data['contactPerson']),
//             _infoTile(Icons.email, "Email Address", data['email']),
//             _infoTile(Icons.phone, "Phone Number", data['phone']),
//             _infoTile(Icons.location_on, "Address", data['address']),
//             _infoTile(Icons.post_code, "postCode", data['postCode']),
//             _infoTile(Icons.location_on, "Address", data['address']),
//           ],
//         ),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () => Navigator.pop(context),
//           child: const Text("CLOSE", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
//         ),
//       ],
//     );
//   }
//
//   Widget _infoTile(IconData icon, String label, dynamic value) {
//     return ListTile(
//       leading: Icon(icon, color: Colors.green),
//       contentPadding: EdgeInsets.zero,
//       title: Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
//       subtitle: Text(
//         value?.toString() ?? "Not Provided",
//         style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black87),
//       ),
//     );
//   }
// }

//
//
// import 'package:flutter/material.dart';
//
// class UserInfoDialog extends StatelessWidget {
//   final Map<String, dynamic> data;
//
//   const UserInfoDialog({super.key, required this.data});
//
//   @override
//   Widget build(BuildContext context) {
//     // Firestore structure onujayi 'profile' map-ti ber kore neya
//     final profile = data['profile'] as Map<String, dynamic>? ?? {};
//
//     return AlertDialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//       titlePadding: EdgeInsets.zero,
//       title: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: const BoxDecoration(
//           color: Colors.green,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(20),
//             topRight: Radius.circular(20),
//           ),
//         ),
//         child: const Row(
//           children: [
//             Icon(Icons.badge_outlined, color: Colors.white, size: 28),
//             SizedBox(width: 10),
//             Text("Personal Info", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//           ],
//         ),
//       ),
//       content: SizedBox(
//         width: double.maxFinite,
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               _infoTile(Icons.category_outlined, "User Type", profile['role']),
//               _infoTile(Icons.business_outlined, "Business Name", profile['businessOrFullName']),
//               _infoTile(Icons.person_outline, "Name", profile['contactPerson'].toString().toUpperCase()),
//               _infoTile(Icons.email_outlined, "Email Address", profile['email']),
//               _infoTile(Icons.phone_android_outlined, "Phone Number", profile['phone']),
//               _infoTile(Icons.location_city_outlined, "City", profile['city']),
//               _infoTile(Icons.map_outlined, "Full Address", profile['address']),
//               _infoTile(Icons.pin_drop_outlined, "Post Code", profile['postCode']),
//             ],
//           ),
//         ),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () => Navigator.pop(context),
//           child: const Text("CLOSE", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
//         ),
//       ],
//     );
//   }
//
//   Widget _infoTile(IconData icon, String label, dynamic value) {
//     return ListTile(
//       leading: CircleAvatar(
//         backgroundColor: Colors.green.withOpacity(0.1),
//         child: Icon(icon, color: Colors.green, size: 20),
//       ),
//       contentPadding: const EdgeInsets.symmetric(vertical: 4),
//       title: Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey, letterSpacing: 0.5)),
//       subtitle: Text(
//         value?.toString() ?? "Not Provided",
//         style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';

class UserInfoDialog extends StatelessWidget {
  final Map<String, dynamic> data;

  const UserInfoDialog({super.key, required this.data});

  /// 🔹 Helper function to capitalize only the first letter
  String _capitalizeFirstLetter(dynamic value) {
    String text = value?.toString() ?? "";
    if (text.isEmpty) return "Not Provided";
    return "${text[0].toUpperCase()}${text.substring(1).toLowerCase()}";
  }

  @override
  Widget build(BuildContext context) {
    // Firestore structure onujayi 'profile' map-ti ber kore neya
    final profile = data['profile'] as Map<String, dynamic>? ?? {};

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      titlePadding: EdgeInsets.zero,
      title: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: const Row(
          children: [
            Icon(Icons.badge_outlined, color: Colors.white, size: 28),
            SizedBox(width: 10),
            Text("Personal Info", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 🔹 Role: Sudu prothom letter boro hobe (e.g. Donor)
              _infoTile(Icons.category_outlined, "User Role", _capitalizeFirstLetter(profile['role'])),

              // _infoTile(Icons.business_outlined, "Business Name", profile['businessOrFullName']),

              // 🔹 Name: Puru-tai uppercase thakbe (tumi age jemon cheyecho)
              _infoTile(Icons.person_outline, "Name", profile['contactPerson']?.toString().toUpperCase()),

              _infoTile(Icons.email_outlined, "Email Address", profile['email']),
              _infoTile(Icons.phone_android_outlined, "Phone Number", profile['phone']),
              _infoTile(Icons.location_city_outlined, "City", profile['city']),
              _infoTile(Icons.map_outlined, "Full Address", profile['address']),
              _infoTile(Icons.pin_drop_outlined, "Post Code", profile['postCode']),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("CLOSE", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  Widget _infoTile(IconData icon, String label, dynamic value) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.green.withOpacity(0.1),
        child: Icon(icon, color: Colors.green, size: 20),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 4),
      title: Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey, letterSpacing: 0.5)),
      subtitle: Text(
        value?.toString() ?? "Not Provided",
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87),
      ),
    );
  }
}