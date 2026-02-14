// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
// class VolunteerProvider extends ChangeNotifier {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   // ১. নতুন রিকোয়েস্ট ফেচ করা (সবাই দেখবে যারা এখনো একসেপ্ট করেনি)
//   Stream<QuerySnapshot> getAvailableRequests() {
//     return _firestore
//         .collection('requests')
//         .where('status', isEqualTo: 'approved')
//         .where('deliveryType', isEqualTo: '') // ডাটাবেজে এটি অবশ্যই "" হতে হবে
//         .snapshots();
//   }
//
//   // ২. আপনার নিজের নেওয়া ডেলিভারিগুলো ফেচ করা
//   Stream<QuerySnapshot> getMyDeliveries(String volunteerUid, String status) {
//     return _firestore
//         .collection('requests')
//         .where('volunteerId', isEqualTo: volunteerUid)
//         .where('status', isEqualTo: status)
//         .snapshots();
//   }
//
//   // ৩. ডেলিভারি একসেপ্ট করার লজিক
//   Future<void> acceptDelivery(String requestId, String volunteerUid) async {
//     try {
//       await _firestore.collection('requests').doc(requestId).update({
//         'volunteerId': volunteerUid, // বর্তমান ভলান্টিয়ারের ID
//         'status': 'on_the_way',      // স্ট্যাটাস পরিবর্তন
//       });
//       notifyListeners();
//     } catch (e) {
//       debugPrint("Accept Error: $e");
//     }
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VolunteerProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ১. Shob available request fetch kora (Jekhane deliveryType khali)
  Stream<QuerySnapshot> getAvailableRequests() {
    return _firestore
        .collection('requests')
        .where('status', isEqualTo: 'approved')
        .where('deliveryType', isEqualTo: '') // Shudhu empty deliveryType show korbe
        .snapshots();
  }

  // ২. Volunteer-er nite kora ongoing ba completed delivery fetch kora
  Stream<QuerySnapshot> getMyDeliveries(String volunteerUid, String status) {
    return _firestore
        .collection('requests')
        .where('volunteerId', isEqualTo: volunteerUid)
        .where('status', isEqualTo: status)
        .snapshots();
  }

  // ৩. Professional Accept Logic
  Future<void> acceptDelivery(String requestId, String volunteerUid) async {
    try {
      await _firestore.collection('requests').doc(requestId).update({
        'volunteerId': volunteerUid,     // Volunteer assigned holo
        'deliveryType': 'pickup',        // Ekhon ar empty nai, tai vanish hoye jabe
        'deliverystatus': 'on_the_way',          // Next stage-e gelo
        'delivery-acceptedAt': FieldValue.serverTimestamp(), // Tracking-er jonno
      });
      notifyListeners();
    } catch (e) {
      debugPrint("Accept Error: $e");
      rethrow;
    }
  }
}