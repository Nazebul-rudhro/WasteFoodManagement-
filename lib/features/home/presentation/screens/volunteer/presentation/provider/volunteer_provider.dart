// // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // import 'package:flutter/material.dart';
// // //
// // // class VolunteerProvider extends ChangeNotifier {
// // //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// // //
// // //   // ১. এভেইলেবল রিকোয়েস্ট (যেগুলো ডোনার এপ্রুভ করেছে কিন্তু কেউ পিকআপ করেনি)
// // //   Stream<QuerySnapshot> getAvailableRequests() {
// // //     return _firestore
// // //         .collection('requests')
// // //         .where('status', isEqualTo: 'approved')
// // //         .where('deliveryType', isEqualTo: '')
// // //         .snapshots();
// // //   }
// // //
// // //   // ২. অনগোয়িং ডেলিভারি (On the Way)
// // //   Stream<QuerySnapshot> getMyDeliveries(String volunteerUid, String status) {
// // //     return _firestore
// // //         .collection('requests')
// // //         .where('volunteerId', isEqualTo: volunteerUid)
// // //         .where('status', isEqualTo: status)
// // //         .snapshots();
// // //   }
// // //
// // //   // ৩. কমপ্লিটেড ডেলিভারি
// // //   Stream<QuerySnapshot> getCompletedDeliveries(String volunteerUid) {
// // //     return _firestore
// // //         .collection('requests')
// // //         .where('volunteerId', isEqualTo: volunteerUid)
// // //         .where('status', isEqualTo: 'completed')
// // //         .snapshots();
// // //   }
// // //
// // //   // ৪. একসেপ্ট লজিক
// // //   Future<void> acceptDelivery(String requestId, String volunteerUid) async {
// // //     await _firestore.collection('requests').doc(requestId).update({
// // //       'volunteerId': volunteerUid,
// // //       'deliveryType': 'pickup',
// // //       'deliverystatus': 'ongoing',
// // //       'pickupTime': FieldValue.serverTimestamp(),
// // //       'status': 'on_the_way', // স্ট্যাটাস চেঞ্জ করলে এটি 'Available' ট্যাব থেকে চলে যাবে
// // //     });
// // //     notifyListeners();
// // //   }
// // //
// // //   // ৫. কমপ্লিট লজিক (সংশোধিত)
// // //   Future<void> completeDelivery(String requestId) async {
// // //     try {
// // //       await _firestore.collection('requests').doc(requestId).update({
// // //         'status': 'completed',          // এটি খুবই জরুরি ট্যাব পরিবর্তনের জন্য
// // //         'deliverystatus': 'completed',
// // //         'completedAt': FieldValue.serverTimestamp(),
// // //       });
// // //       notifyListeners();
// // //     } catch (e) {
// // //       debugPrint("Error completing delivery: $e");
// // //       rethrow;
// // //     }
// // //   }
// // // }
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:flutter/material.dart';
// //
// // class VolunteerProvider extends ChangeNotifier {
// //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// //
// //   // ১. এভেইলএবল রিকোয়েস্ট: যেগুলোর স্ট্যাটাস 'approved' কিন্তু এখনো কোনো ভলান্টিয়ার নেই
// //   Stream<QuerySnapshot> getAvailableRequests() {
// //     return _firestore
// //         .collection('requests')
// //         .where('status', isEqualTo: 'approved')
// //         .snapshots(); // এখানে volunteerId চেক করার দরকার নেই যদি লজিক্যালি approved মানেই open হয়
// //   }
// //
// //   // ২. অনগোয়িং ডেলিভারি: ভলান্টিয়ার একসেপ্ট করেছে (on_the_way)
// //   Stream<QuerySnapshot> getMyDeliveries(String volunteerUid) {
// //     return _firestore
// //         .collection('requests')
// //         .where('volunteerId', isEqualTo: volunteerUid)
// //         .where('status', isEqualTo: 'on_the_way')
// //         .snapshots();
// //   }
// //
// //   // ৩. কমপ্লিটেড ডেলিভারি: যেগুলোর স্ট্যাটাস 'delivered' অথবা 'completed'
// //   Stream<QuerySnapshot> getCompletedDeliveries(String volunteerUid) {
// //     return _firestore
// //         .collection('requests')
// //         .where('volunteerId', isEqualTo: volunteerUid)
// //         .where('status', isEqualTo: 'delivered') // আপনার ডাটাবেসে 'delivered' আছে তাই এটি দিলাম
// //         .snapshots();
// //   }
// //
// //   // ৪. একসেপ্ট লজিক
// //   Future<void> acceptDelivery(String requestId, String volunteerUid) async {
// //     try {
// //       await _firestore.collection('requests').doc(requestId).update({
// //         'volunteerId': volunteerUid,
// //         'deliveryType': 'pickup',
// //         'deliverystatus': 'ongoing',
// //         'status': 'on_the_way',
// //         'acceptedAt': FieldValue.serverTimestamp(),
// //       });
// //     } catch (e) {
// //       debugPrint("Accept Error: $e");
// //       rethrow;
// //     }
// //   }
// //
// //   // ৫. কমপ্লিট লজিক
// //   Future<void> completeDelivery(String requestId) async {
// //     try {
// //       await _firestore.collection('requests').doc(requestId).update({
// //         'status': 'delivered', // ডাটাবেস কনসিস্টেন্সি বজায় রাখতে
// //         'deliverystatus': 'completed',
// //         'deliveredAt': FieldValue.serverTimestamp(),
// //       });
// //     } catch (e) {
// //       debugPrint("Complete Error: $e");
// //       rethrow;
// //     }
// //   }
// // }
//
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
// class VolunteerProvider extends ChangeNotifier {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   // ১. এভেইলএবল রিকোয়েস্ট: আপনার লজিক অনুযায়ী status "delivered" কিন্তু deliverystatus "pending"
//   Stream<QuerySnapshot> getAvailableRequests() {
//     return _firestore
//         .collection('requests')
//         .where('status', isEqualTo: 'delivered') // ডোনর এপ্রুভ করলে আপনার এখানে delivered হচ্ছে
//         .where('deliverystatus', isEqualTo: 'pending') // এখনো কেউ পিকআপ করেনি
//         .snapshots();
//   }
//
//   // ২. অনগোয়িং ডেলিভারি (যখন ভলান্টিয়ার Accept করবে)
//   Stream<QuerySnapshot> getMyDeliveries(String volunteerUid) {
//     return _firestore
//         .collection('requests')
//         .where('volunteerId', isEqualTo: volunteerUid)
//         .where('deliverystatus', isEqualTo: 'ongoing')
//         .snapshots();
//   }
//
//   // ৩. কমপ্লিটেড ডেলিভারি
//   Stream<QuerySnapshot> getCompletedDeliveries(String volunteerUid) {
//     return _firestore
//         .collection('requests')
//         .where('volunteerId', isEqualTo: volunteerUid)
//         .where('deliverystatus', isEqualTo: 'completed')
//         .snapshots();
//   }
//
//   // ৪. একসেপ্ট লজিক
//   Future<void> acceptDelivery(String requestId, String volunteerUid) async {
//     try {
//       await _firestore.collection('requests').doc(requestId).update({
//         'volunteerId': volunteerUid,
//         'deliverystatus': 'ongoing', // pending থেকে ongoing হয়ে গেল
//         'acceptedAt': FieldValue.serverTimestamp(),
//       });
//     } catch (e) {
//       debugPrint("Accept Error: $e");
//       rethrow;
//     }
//   }
//
//   // ৫. কমপ্লিট লজিক
//   Future<void> completeDelivery(String requestId) async {
//     try {
//       await _firestore.collection('requests').doc(requestId).update({
//         'deliverystatus': 'completed', // ডেলিভারি শেষ
//         'completedAt': FieldValue.serverTimestamp(),
//       });
//     } catch (e) {
//       debugPrint("Complete Error: $e");
//       rethrow;
//     }
//   }
// }


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VolunteerProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // এভেইলএবল: status "delivered" & deliverystatus "pending"
  Stream<QuerySnapshot> getAvailableRequests() {
    return _firestore
        .collection('requests')
        .where('status', isEqualTo: 'delivered')
        .where('deliverystatus', isEqualTo: 'pending')
        .snapshots();
  }

  // অনগোয়িং
  Stream<QuerySnapshot> getMyDeliveries(String volunteerUid) {
    return _firestore
        .collection('requests')
        .where('volunteerId', isEqualTo: volunteerUid)
        .where('deliverystatus', isEqualTo: 'ongoing')
        .snapshots();
  }

  // কমপ্লিটেড
  Stream<QuerySnapshot> getCompletedDeliveries(String volunteerUid) {
    return _firestore
        .collection('requests')
        .where('volunteerId', isEqualTo: volunteerUid)
        .where('deliverystatus', isEqualTo: 'completed')
        .snapshots();
  }

  Future<void> acceptDelivery(String requestId, String volunteerUid) async {
    await _firestore.collection('requests').doc(requestId).update({
      'volunteerId': volunteerUid,
      'deliverystatus': 'ongoing',
      'acceptedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> completeDelivery(String requestId) async {
    await _firestore.collection('requests').doc(requestId).update({
      'deliverystatus': 'completed',
      'completedAt': FieldValue.serverTimestamp(),
    });
  }
}