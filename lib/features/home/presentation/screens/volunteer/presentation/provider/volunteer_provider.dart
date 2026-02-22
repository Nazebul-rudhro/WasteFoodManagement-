// // // // // // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // // // // // import 'package:flutter/material.dart';
// // // // // // //
// // // // // // // class VolunteerProvider extends ChangeNotifier {
// // // // // // //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// // // // // // //
// // // // // // //   // ১. এভেইলেবল রিকোয়েস্ট (যেগুলো ডোনার এপ্রুভ করেছে কিন্তু কেউ পিকআপ করেনি)
// // // // // // //   Stream<QuerySnapshot> getAvailableRequests() {
// // // // // // //     return _firestore
// // // // // // //         .collection('requests')
// // // // // // //         .where('status', isEqualTo: 'approved')
// // // // // // //         .where('deliveryType', isEqualTo: '')
// // // // // // //         .snapshots();
// // // // // // //   }
// // // // // // //
// // // // // // //   // ২. অনগোয়িং ডেলিভারি (On the Way)
// // // // // // //   Stream<QuerySnapshot> getMyDeliveries(String volunteerUid, String status) {
// // // // // // //     return _firestore
// // // // // // //         .collection('requests')
// // // // // // //         .where('volunteerId', isEqualTo: volunteerUid)
// // // // // // //         .where('status', isEqualTo: status)
// // // // // // //         .snapshots();
// // // // // // //   }
// // // // // // //
// // // // // // //   // ৩. কমপ্লিটেড ডেলিভারি
// // // // // // //   Stream<QuerySnapshot> getCompletedDeliveries(String volunteerUid) {
// // // // // // //     return _firestore
// // // // // // //         .collection('requests')
// // // // // // //         .where('volunteerId', isEqualTo: volunteerUid)
// // // // // // //         .where('status', isEqualTo: 'completed')
// // // // // // //         .snapshots();
// // // // // // //   }
// // // // // // //
// // // // // // //   // ৪. একসেপ্ট লজিক
// // // // // // //   Future<void> acceptDelivery(String requestId, String volunteerUid) async {
// // // // // // //     await _firestore.collection('requests').doc(requestId).update({
// // // // // // //       'volunteerId': volunteerUid,
// // // // // // //       'deliveryType': 'pickup',
// // // // // // //       'deliverystatus': 'ongoing',
// // // // // // //       'pickupTime': FieldValue.serverTimestamp(),
// // // // // // //       'status': 'on_the_way', // স্ট্যাটাস চেঞ্জ করলে এটি 'Available' ট্যাব থেকে চলে যাবে
// // // // // // //     });
// // // // // // //     notifyListeners();
// // // // // // //   }
// // // // // // //
// // // // // // //   // ৫. কমপ্লিট লজিক (সংশোধিত)
// // // // // // //   Future<void> completeDelivery(String requestId) async {
// // // // // // //     try {
// // // // // // //       await _firestore.collection('requests').doc(requestId).update({
// // // // // // //         'status': 'completed',          // এটি খুবই জরুরি ট্যাব পরিবর্তনের জন্য
// // // // // // //         'deliverystatus': 'completed',
// // // // // // //         'completedAt': FieldValue.serverTimestamp(),
// // // // // // //       });
// // // // // // //       notifyListeners();
// // // // // // //     } catch (e) {
// // // // // // //       debugPrint("Error completing delivery: $e");
// // // // // // //       rethrow;
// // // // // // //     }
// // // // // // //   }
// // // // // // // }
// // // // // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // // // // import 'package:flutter/material.dart';
// // // // // //
// // // // // // class VolunteerProvider extends ChangeNotifier {
// // // // // //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// // // // // //
// // // // // //   // ১. এভেইলএবল রিকোয়েস্ট: যেগুলোর স্ট্যাটাস 'approved' কিন্তু এখনো কোনো ভলান্টিয়ার নেই
// // // // // //   Stream<QuerySnapshot> getAvailableRequests() {
// // // // // //     return _firestore
// // // // // //         .collection('requests')
// // // // // //         .where('status', isEqualTo: 'approved')
// // // // // //         .snapshots(); // এখানে volunteerId চেক করার দরকার নেই যদি লজিক্যালি approved মানেই open হয়
// // // // // //   }
// // // // // //
// // // // // //   // ২. অনগোয়িং ডেলিভারি: ভলান্টিয়ার একসেপ্ট করেছে (on_the_way)
// // // // // //   Stream<QuerySnapshot> getMyDeliveries(String volunteerUid) {
// // // // // //     return _firestore
// // // // // //         .collection('requests')
// // // // // //         .where('volunteerId', isEqualTo: volunteerUid)
// // // // // //         .where('status', isEqualTo: 'on_the_way')
// // // // // //         .snapshots();
// // // // // //   }
// // // // // //
// // // // // //   // ৩. কমপ্লিটেড ডেলিভারি: যেগুলোর স্ট্যাটাস 'delivered' অথবা 'completed'
// // // // // //   Stream<QuerySnapshot> getCompletedDeliveries(String volunteerUid) {
// // // // // //     return _firestore
// // // // // //         .collection('requests')
// // // // // //         .where('volunteerId', isEqualTo: volunteerUid)
// // // // // //         .where('status', isEqualTo: 'delivered') // আপনার ডাটাবেসে 'delivered' আছে তাই এটি দিলাম
// // // // // //         .snapshots();
// // // // // //   }
// // // // // //
// // // // // //   // ৪. একসেপ্ট লজিক
// // // // // //   Future<void> acceptDelivery(String requestId, String volunteerUid) async {
// // // // // //     try {
// // // // // //       await _firestore.collection('requests').doc(requestId).update({
// // // // // //         'volunteerId': volunteerUid,
// // // // // //         'deliveryType': 'pickup',
// // // // // //         'deliverystatus': 'ongoing',
// // // // // //         'status': 'on_the_way',
// // // // // //         'acceptedAt': FieldValue.serverTimestamp(),
// // // // // //       });
// // // // // //     } catch (e) {
// // // // // //       debugPrint("Accept Error: $e");
// // // // // //       rethrow;
// // // // // //     }
// // // // // //   }
// // // // // //
// // // // // //   // ৫. কমপ্লিট লজিক
// // // // // //   Future<void> completeDelivery(String requestId) async {
// // // // // //     try {
// // // // // //       await _firestore.collection('requests').doc(requestId).update({
// // // // // //         'status': 'delivered', // ডাটাবেস কনসিস্টেন্সি বজায় রাখতে
// // // // // //         'deliverystatus': 'completed',
// // // // // //         'deliveredAt': FieldValue.serverTimestamp(),
// // // // // //       });
// // // // // //     } catch (e) {
// // // // // //       debugPrint("Complete Error: $e");
// // // // // //       rethrow;
// // // // // //     }
// // // // // //   }
// // // // // // }
// // // // //
// // // // //
// // // // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // // // import 'package:flutter/material.dart';
// // // // //
// // // // // class VolunteerProvider extends ChangeNotifier {
// // // // //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// // // // //
// // // // //   // ১. এভেইলএবল রিকোয়েস্ট: আপনার লজিক অনুযায়ী status "delivered" কিন্তু deliverystatus "pending"
// // // // //   Stream<QuerySnapshot> getAvailableRequests() {
// // // // //     return _firestore
// // // // //         .collection('requests')
// // // // //         .where('status', isEqualTo: 'delivered') // ডোনর এপ্রুভ করলে আপনার এখানে delivered হচ্ছে
// // // // //         .where('deliverystatus', isEqualTo: 'pending') // এখনো কেউ পিকআপ করেনি
// // // // //         .snapshots();
// // // // //   }
// // // // //
// // // // //   // ২. অনগোয়িং ডেলিভারি (যখন ভলান্টিয়ার Accept করবে)
// // // // //   Stream<QuerySnapshot> getMyDeliveries(String volunteerUid) {
// // // // //     return _firestore
// // // // //         .collection('requests')
// // // // //         .where('volunteerId', isEqualTo: volunteerUid)
// // // // //         .where('deliverystatus', isEqualTo: 'ongoing')
// // // // //         .snapshots();
// // // // //   }
// // // // //
// // // // //   // ৩. কমপ্লিটেড ডেলিভারি
// // // // //   Stream<QuerySnapshot> getCompletedDeliveries(String volunteerUid) {
// // // // //     return _firestore
// // // // //         .collection('requests')
// // // // //         .where('volunteerId', isEqualTo: volunteerUid)
// // // // //         .where('deliverystatus', isEqualTo: 'completed')
// // // // //         .snapshots();
// // // // //   }
// // // // //
// // // // //   // ৪. একসেপ্ট লজিক
// // // // //   Future<void> acceptDelivery(String requestId, String volunteerUid) async {
// // // // //     try {
// // // // //       await _firestore.collection('requests').doc(requestId).update({
// // // // //         'volunteerId': volunteerUid,
// // // // //         'deliverystatus': 'ongoing', // pending থেকে ongoing হয়ে গেল
// // // // //         'acceptedAt': FieldValue.serverTimestamp(),
// // // // //       });
// // // // //     } catch (e) {
// // // // //       debugPrint("Accept Error: $e");
// // // // //       rethrow;
// // // // //     }
// // // // //   }
// // // // //
// // // // //   // ৫. কমপ্লিট লজিক
// // // // //   Future<void> completeDelivery(String requestId) async {
// // // // //     try {
// // // // //       await _firestore.collection('requests').doc(requestId).update({
// // // // //         'deliverystatus': 'completed', // ডেলিভারি শেষ
// // // // //         'completedAt': FieldValue.serverTimestamp(),
// // // // //       });
// // // // //     } catch (e) {
// // // // //       debugPrint("Complete Error: $e");
// // // // //       rethrow;
// // // // //     }
// // // // //   }
// // // // // }
// // // //
// // // // //
// // // // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // // // import 'package:flutter/material.dart';
// // // // //
// // // // // class VolunteerProvider extends ChangeNotifier {
// // // // //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// // // // //
// // // // //   // এভেইলএবল: status "delivered" & deliverystatus "pending"
// // // // //   Stream<QuerySnapshot> getAvailableRequests() {
// // // // //     return _firestore
// // // // //         .collection('requests')
// // // // //         .where('status', isEqualTo: 'approved')
// // // // //         .where('deliverystatus', isEqualTo: 'pending')
// // // // //         .snapshots();
// // // // //   }
// // // // //
// // // // //   // অনগোয়িং
// // // // //   Stream<QuerySnapshot> getMyDeliveries(String volunteerUid) {
// // // // //     return _firestore
// // // // //         .collection('requests')
// // // // //         .where('volunteerId', isEqualTo: volunteerUid)
// // // // //         .where('deliverystatus', isEqualTo: 'ongoing')
// // // // //         .snapshots();
// // // // //   }
// // // // //
// // // // //   // কমপ্লিটেড
// // // // //   Stream<QuerySnapshot> getCompletedDeliveries(String volunteerUid) {
// // // // //     return _firestore
// // // // //         .collection('requests')
// // // // //         .where('volunteerId', isEqualTo: volunteerUid)
// // // // //         .where('deliverystatus', isEqualTo: 'completed')
// // // // //         .snapshots();
// // // // //   }
// // // // //
// // // // //   Future<void> acceptDelivery(String requestId, String volunteerUid) async {
// // // // //     await _firestore.collection('requests').doc(requestId).update({
// // // // //       'volunteerId': volunteerUid,
// // // // //       'deliverystatus': 'ongoing',
// // // // //       'acceptedAt': FieldValue.serverTimestamp(),
// // // // //     });
// // // // //   }
// // // // //
// // // // //   Future<void> completeDelivery(String requestId) async {
// // // // //     await _firestore.collection('requests').doc(requestId).update({
// // // // //       'deliverystatus': 'completed',
// // // // //       'completedAt': FieldValue.serverTimestamp(),
// // // // //     });
// // // // //   }
// // // // // }
// // // //
// // // // //
// // // // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // // // import 'package:flutter/material.dart';
// // // // //
// // // // // class VolunteerProvider extends ChangeNotifier {
// // // // //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// // // // //
// // // // //   // Available: status "approved" & deliverystatus "pending"
// // // // //   Stream<QuerySnapshot> getAvailableRequests() {
// // // // //     return _firestore
// // // // //         .collection('requests')
// // // // //         .where('status', isEqualTo: 'approved')
// // // // //         .where('deliverystatus', isEqualTo: 'pending')
// // // // //         .snapshots();
// // // // //   }
// // // // //
// // // // //   // Ongoing: Delivery start hoyeche
// // // // //   Stream<QuerySnapshot> getMyDeliveries(String volunteerUid) {
// // // // //     return _firestore
// // // // //         .collection('requests')
// // // // //         .where('volunteerId', isEqualTo: volunteerUid)
// // // // //         .where('deliverystatus', isEqualTo: 'ongoing')
// // // // //         .snapshots();
// // // // //   }
// // // // //
// // // // //   // Completed: Delivery shesh
// // // // //   Stream<QuerySnapshot> getCompletedDeliveries(String volunteerUid) {
// // // // //     return _firestore
// // // // //         .collection('requests')
// // // // //         .where('volunteerId', isEqualTo: volunteerUid)
// // // // //         .where('deliverystatus', isEqualTo: 'completed')
// // // // //         .snapshots();
// // // // //   }
// // // // //
// // // // //   // Volunteer request pathabe pickup er jonno
// // // // //   Future<void> requestPickup(String requestId, String volunteerUid, String name) async {
// // // // //     // Request document er bhitore ekta sub-collection create hobe
// // // // //     await _firestore
// // // // //         .collection('requests')
// // // // //         .doc(requestId)
// // // // //         .collection('pickup_requests')
// // // // //         .doc(volunteerUid)
// // // // //         .set({
// // // // //       'volunteerId': volunteerUid,
// // // // //       'volunteerName': name,
// // // // //       'requestedAt': FieldValue.serverTimestamp(),
// // // // //       'status': 'pending',
// // // // //     });
// // // // //   }
// // // // //
// // // // //   // Delivery complete kora
// // // // //   Future<void> completeDelivery(String requestId) async {
// // // // //     await _firestore.collection('requests').doc(requestId).update({
// // // // //       'deliverystatus': 'completed',
// // // // //       'status': 'delivered', // Final status set to delivered
// // // // //       'completedAt': FieldValue.serverTimestamp(),
// // // // //     });
// // // // //   }
// // // // // }
// // // //
// // // //
// // // // //
// // // // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // // // import 'package:flutter/material.dart';
// // // // //
// // // // // class VolunteerProvider extends ChangeNotifier {
// // // // //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// // // // //
// // // // //   // ১. এভেইলএবল: এখানে দুই ধরণের ডাটা আসবে
// // // // //   // ক) একদম নতুন (status: approved) -> রিকোয়েস্ট পাঠানোর জন্য
// // // // //   // খ) ডোনার হ্যান্ডওভার করেছে (status: delivered & deliverystatus: pending) -> পিকআপ করার জন্য
// // // // //   Stream<QuerySnapshot> getAvailableRequests() {
// // // // //     return _firestore
// // // // //         .collection('requests')
// // // // //         .where('status', whereIn: ['approved', 'delivered'])
// // // // //         .where('deliverystatus', whereIn: ['pending', 'none'])
// // // // //         .snapshots();
// // // // //   }
// // // // //
// // // // //   // ২. অনগোয়িং: পিকআপ কনফার্ম করার পর এখানে আসবে
// // // // //   Stream<QuerySnapshot> getMyDeliveries(String volunteerUid) {
// // // // //     return _firestore
// // // // //         .collection('requests')
// // // // //         .where('volunteerId', isEqualTo: volunteerUid)
// // // // //         .where('deliverystatus', isEqualTo: 'ongoing')
// // // // //         .snapshots();
// // // // //   }
// // // // //
// // // // //   // ৩. কমপ্লিটেড
// // // // //   Stream<QuerySnapshot> getCompletedDeliveries(String volunteerUid) {
// // // // //     return _firestore
// // // // //         .collection('requests')
// // // // //         .where('volunteerId', isEqualTo: volunteerUid)
// // // // //         .where('deliverystatus', isEqualTo: 'completed')
// // // // //         .snapshots();
// // // // //   }
// // // // //
// // // // //   // ৪. ডোনারকে রিকোয়েস্ট পাঠানো (Initial Interest)
// // // // //   Future<void> requestPickup(String requestId, String volunteerUid, String name) async {
// // // // //     await _firestore
// // // // //         .collection('requests')
// // // // //         .doc(requestId)
// // // // //         .collection('pickup_requests')
// // // // //         .doc(volunteerUid)
// // // // //         .set({
// // // // //       'volunteerId': volunteerUid,
// // // // //       'volunteerName': name,
// // // // //       'requestedAt': FieldValue.serverTimestamp(),
// // // // //       'status': 'pending',
// // // // //     });
// // // // //   }
// // // // //
// // // // //   // ৫. পিকআপ কনফার্ম করা (যখন ডোনার তাকে এক্সেপ্ট করবে)
// // // // //   Future<void> confirmPickup(String requestId) async {
// // // // //     await _firestore.collection('requests').doc(requestId).update({
// // // // //       'deliverystatus': 'ongoing', // এখন অনগোয়িং হবে
// // // // //       'pickupAt': FieldValue.serverTimestamp(),
// // // // //     });
// // // // //   }
// // // // //
// // // // //   // ৬. ডেলিভারি কমপ্লিট করা
// // // // //   Future<void> completeDelivery(String requestId) async {
// // // // //     await _firestore.collection('requests').doc(requestId).update({
// // // // //       'deliverystatus': 'completed',
// // // // //       'completedAt': FieldValue.serverTimestamp(),
// // // // //     });
// // // // //   }
// // // // // }
// // // //
// // // //
// // // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // // import 'package:flutter/material.dart';
// // // //
// // // // class VolunteerProvider extends ChangeNotifier {
// // // //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// // // //
// // // //   // 🔹 Available Requests Stream
// // // //   Stream<QuerySnapshot> getAvailableRequests() {
// // // //     return _firestore
// // // //         .collection('requests')
// // // //         .where('status', whereIn: ['approved', 'delivered'])
// // // //         .where('deliverystatus', whereIn: ['pending', 'none'])
// // // //         .snapshots();
// // // //   }
// // // //
// // // //   // 🔹 Ongoing Deliveries Stream
// // // //   Stream<QuerySnapshot> getMyDeliveries(String volunteerUid) {
// // // //     return _firestore
// // // //         .collection('requests')
// // // //         .where('volunteerId', isEqualTo: volunteerUid)
// // // //         .where('deliverystatus', isEqualTo: 'ongoing')
// // // //         .snapshots();
// // // //   }
// // // //
// // // //   // 🔹 Completed Deliveries Stream
// // // //   Stream<QuerySnapshot> getCompletedDeliveries(String volunteerUid) {
// // // //     return _firestore
// // // //         .collection('requests')
// // // //         .where('volunteerId', isEqualTo: volunteerUid)
// // // //         .where('deliverystatus', isEqualTo: 'completed')
// // // //         .snapshots();
// // // //   }
// // // //
// // // //   // 🔹 Request Pickup from Donor
// // // //   Future<void> requestPickup(String requestId, String volunteerUid, String name) async {
// // // //     await _firestore
// // // //         .collection('requests')
// // // //         .doc(requestId)
// // // //         .collection('pickup_requests')
// // // //         .doc(volunteerUid)
// // // //         .set({
// // // //       'volunteerId': volunteerUid,
// // // //       'volunteerName': name,
// // // //       'requestedAt': FieldValue.serverTimestamp(),
// // // //       'status': 'pending',
// // // //     });
// // // //   }
// // // //
// // // //   // 🔹 Confirm Pickup
// // // //   Future<void> confirmPickup(String requestId) async {
// // // //     await _firestore.collection('requests').doc(requestId).update({
// // // //       'deliverystatus': 'ongoing',
// // // //       'pickupAt': FieldValue.serverTimestamp(),
// // // //     });
// // // //   }
// // // //
// // // //   // 🔹 Complete Delivery & Points Update (10/10 Logic)
// // // //   Future<void> completeDelivery({
// // // //     required String requestId,
// // // //     required String volunteerId,
// // // //     required String donorId,
// // // //     required String receiverId,
// // // //   }) async {
// // // //     final WriteBatch batch = _firestore.batch();
// // // //
// // // //     // 1. Request Status Update
// // // //     DocumentReference requestRef = _firestore.collection('requests').doc(requestId);
// // // //     batch.update(requestRef, {
// // // //       'deliverystatus': 'completed',
// // // //       'status': 'completed',
// // // //       'completedAt': FieldValue.serverTimestamp(),
// // // //     });
// // // //
// // // //     // 2. Donor Rewards (+10 Points)
// // // //     DocumentReference donorRef = _firestore.collection('accounts').doc(donorId);
// // // //     batch.update(donorRef, {
// // // //       'profile.points': FieldValue.increment(10),
// // // //       'profile.totalDonations': FieldValue.increment(1),
// // // //     });
// // // //
// // // //     // 3. Receiver Rewards (+5 Points)
// // // //     DocumentReference receiverRef = _firestore.collection('accounts').doc(receiverId);
// // // //     batch.update(receiverRef, {
// // // //       'profile.points': FieldValue.increment(5),
// // // //       'profile.totalReceives': FieldValue.increment(1),
// // // //     });
// // // //
// // // //     // 4. Volunteer Rewards (+20 Points)
// // // //     DocumentReference volunteerRef = _firestore.collection('accounts').doc(volunteerId);
// // // //     batch.update(volunteerRef, {
// // // //       'profile.points': FieldValue.increment(20),
// // // //       'profile.totalTasks': FieldValue.increment(1),
// // // //     });
// // // //
// // // //     // Commit all changes together
// // // //     await batch.commit();
// // // //     notifyListeners();
// // // //   }
// // // // }
// // //
// // //
// // //
// // //
// // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // import 'package:flutter/material.dart';
// // //
// // // class VolunteerProvider extends ChangeNotifier {
// // //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// // //
// // //   // ১. এভেইলএবল রিকোয়েস্ট
// // //   Stream<QuerySnapshot> getAvailableRequests() {
// // //     return _firestore
// // //         .collection('requests')
// // //         .where('status', whereIn: ['approved', 'delivered'])
// // //         .where('deliverystatus', whereIn: ['pending', 'none'])
// // //         .snapshots();
// // //   }
// // //
// // //   // ২. অনগোয়িং ডেলিভারি
// // //   Stream<QuerySnapshot> getMyDeliveries(String volunteerUid) {
// // //     return _firestore
// // //         .collection('requests')
// // //         .where('volunteerId', isEqualTo: volunteerUid)
// // //         .where('deliverystatus', isEqualTo: 'ongoing')
// // //         .snapshots();
// // //   }
// // //
// // //   // ৩. কমপ্লিটেড (Time অনুযায়ী সাজানো - Newest First)
// // //   Stream<QuerySnapshot> getCompletedDeliveries(String volunteerUid) {
// // //     return _firestore
// // //         .collection('requests')
// // //         .where('volunteerId', isEqualTo: volunteerUid)
// // //         .where('deliverystatus', isEqualTo: 'completed')
// // //         .orderBy('completedAt', descending: true) // 🔥 Sorting Added
// // //         .snapshots();
// // //   }
// // //
// // //   // ৪. ডোনারকে রিকোয়েস্ট পাঠানো
// // //   Future<void> requestPickup(String requestId, String volunteerUid, String name) async {
// // //     await _firestore
// // //         .collection('requests')
// // //         .doc(requestId)
// // //         .collection('pickup_requests')
// // //         .doc(volunteerUid)
// // //         .set({
// // //       'volunteerId': volunteerUid,
// // //       'volunteerName': name,
// // //       'requestedAt': FieldValue.serverTimestamp(),
// // //       'status': 'pending',
// // //     });
// // //   }
// // //
// // //   // ৫. পিকআপ কনফার্ম করা
// // //   Future<void> confirmPickup(String requestId) async {
// // //     await _firestore.collection('requests').doc(requestId).update({
// // //       'deliverystatus': 'ongoing',
// // //       'pickupAt': FieldValue.serverTimestamp(),
// // //     });
// // //   }
// // //
// // //   // ৬. ডেলিভারি সম্পন্ন ও পয়েন্ট আপডেট (Professional Batch Write)
// // //   Future<void> completeDelivery({
// // //     required String requestId,
// // //     required String volunteerId,
// // //     required String donorId,
// // //     required String receiverId,
// // //   }) async {
// // //     final WriteBatch batch = _firestore.batch();
// // //
// // //     // ক) মেইন রিকোয়েস্ট আপডেট
// // //     DocumentReference requestRef = _firestore.collection('requests').doc(requestId);
// // //     batch.update(requestRef, {
// // //       'deliverystatus': 'completed',
// // //       'status': 'completed',
// // //       'completedAt': FieldValue.serverTimestamp(), // 🔥 Sorting-এর জন্য গুরুত্বপূর্ণ
// // //     });
// // //
// // //     // খ) ডোনার রিওয়ার্ড (+10)
// // //     DocumentReference donorRef = _firestore.collection('accounts').doc(donorId);
// // //     batch.update(donorRef, {
// // //       'profile.points': FieldValue.increment(10),
// // //       'profile.totalDonations': FieldValue.increment(1),
// // //     });
// // //
// // //     // গ) রিসিভার রিওয়ার্ড (+5)
// // //     DocumentReference receiverRef = _firestore.collection('accounts').doc(receiverId);
// // //     batch.update(receiverRef, {
// // //       'profile.points': FieldValue.increment(5),
// // //       'profile.totalReceives': FieldValue.increment(1),
// // //     });
// // //
// // //     // ঘ) ভলান্টিয়ার রিওয়ার্ড (+20)
// // //     DocumentReference volunteerRef = _firestore.collection('accounts').doc(volunteerId);
// // //     batch.update(volunteerRef, {
// // //       'profile.points': FieldValue.increment(20),
// // //       'profile.totalTasks': FieldValue.increment(1),
// // //     });
// // //
// // //     await batch.commit();
// // //     notifyListeners();
// // //   }
// // // }
// //
// //
// //
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:flutter/material.dart';
// //
// // class VolunteerProvider extends ChangeNotifier {
// //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// //
// //   Stream<QuerySnapshot> getAvailableRequests() {
// //     return _firestore.collection('requests')
// //         .where('status', whereIn: ['approved', 'delivered'])
// //         .where('deliverystatus', whereIn: ['pending', 'none'])
// //         .snapshots();
// //   }
// //
// //   Stream<QuerySnapshot> getMyDeliveries(String volunteerUid) {
// //     return _firestore.collection('requests')
// //         .where('volunteerId', isEqualTo: volunteerUid)
// //         .where('deliverystatus', isEqualTo: 'ongoing')
// //         .snapshots();
// //   }
// //
// //   Stream<QuerySnapshot> getCompletedDeliveries(String volunteerUid) {
// //     // Ekhane orderBy use korle oboshoy Firestore Index active thakte hobe
// //     return _firestore.collection('requests')
// //         .where('volunteerId', isEqualTo: volunteerUid)
// //         .where('deliverystatus', isEqualTo: 'completed')
// //         .orderBy('completedAt', descending: true)
// //         .snapshots();
// //   }
// //
// //   // --- Actions ---
// //
// //   Future<void> requestPickup(String requestId, String volunteerUid, String name) async {
// //     await _firestore.collection('requests').doc(requestId)
// //         .collection('pickup_requests').doc(volunteerUid).set({
// //       'volunteerId': volunteerUid,
// //       'volunteerName': name,
// //       'requestedAt': FieldValue.serverTimestamp(),
// //       'status': 'pending',
// //     });
// //   }
// //
// //   Future<void> confirmPickup(String requestId) async {
// //     await _firestore.collection('requests').doc(requestId).update({
// //       'deliverystatus': 'ongoing',
// //       'pickupAt': FieldValue.serverTimestamp(),
// //     });
// //   }
// //
// //   Future<void> completeDelivery({
// //     required String requestId,
// //     required String volunteerId,
// //     required String donorId,
// //     required String receiverId,
// //   }) async {
// //     final WriteBatch batch = _firestore.batch();
// //
// //     // ১. রিকোয়েস্ট আপডেট
// //     batch.update(_firestore.collection('requests').doc(requestId), {
// //       'deliverystatus': 'completed',
// //       'status': 'completed',
// //       'completedAt': FieldValue.serverTimestamp(),
// //     });
// //
// //     // ২. পয়েন্ট আপডেট (খুবই সাবধানে - ডাইরেক্ট পাথ ব্যবহার করে)
// //     try {
// //       if (donorId.isNotEmpty) {
// //         batch.update(_firestore.collection('accounts').doc(donorId), {
// //           'profile.points': FieldValue.increment(10),
// //           'profile.totalDonations': FieldValue.increment(1),
// //         });
// //       }
// //       if (receiverId.isNotEmpty) {
// //         batch.update(_firestore.collection('accounts').doc(receiverId), {
// //           'profile.points': FieldValue.increment(5),
// //           'profile.totalReceives': FieldValue.increment(1),
// //         });
// //       }
// //       batch.update(_firestore.collection('accounts').doc(volunteerId), {
// //         'profile.points': FieldValue.increment(20),
// //         'profile.totalTasks': FieldValue.increment(1),
// //       });
// //
// //       await batch.commit();
// //     } catch (e) {
// //       throw "Database Reward Error: $e";
// //     }
// //     notifyListeners();
// //   }
// // }
//
//
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
// class VolunteerProvider extends ChangeNotifier {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   // 🔹 ১. Available: Latest request gulo age dekhabe
//   Stream<QuerySnapshot> getAvailableRequests() {
//     return _firestore
//         .collection('requests')
//         .where('status', whereIn: ['approved', 'delivered'])
//         .where('deliverystatus', whereIn: ['pending', 'none'])
//         .orderBy('createdAt', descending: true) // 🔥 Time Sorting
//         .snapshots();
//   }
//
//   // 🔹 ২. Ongoing: Newest pickup age dekhabe
//   Stream<QuerySnapshot> getMyDeliveries(String volunteerUid) {
//     return _firestore
//         .collection('requests')
//         .where('volunteerId', isEqualTo: volunteerUid)
//         .where('deliverystatus', isEqualTo: 'ongoing')
//         .orderBy('pickupAt', descending: true) // 🔥 Time Sorting
//         .snapshots();
//   }
//
//   // 🔹 ৩. Completed: Newest delivery age dekhabe
//   Stream<QuerySnapshot> getCompletedDeliveries(String volunteerUid) {
//     return _firestore
//         .collection('requests')
//         .where('volunteerId', isEqualTo: volunteerUid)
//         .where('deliverystatus', isEqualTo: 'completed')
//         .orderBy('completedAt', descending: true) // 🔥 Time Sorting
//         .snapshots();
//   }
//
//   // --- Actions (Confirm Pickup & Complete Delivery) ---
//
//   Future<void> confirmPickup(String requestId) async {
//     await _firestore.collection('requests').doc(requestId).update({
//       'deliverystatus': 'ongoing',
//       'pickupAt': FieldValue.serverTimestamp(), // Sorting indexer jonno
//     });
//   }
//
//   Future<void> completeDelivery({
//     required String requestId,
//     required String volunteerId,
//     required String donorId,
//     required String receiverId,
//   }) async {
//     final WriteBatch batch = _firestore.batch();
//
//     batch.update(_firestore.collection('requests').doc(requestId), {
//       'deliverystatus': 'completed',
//       'status': 'completed',
//       'completedAt': FieldValue.serverTimestamp(), // Sorting indexer jonno
//     });
//
//     // Point and profile update logic (Previous logic preserved)
//     DocumentReference donorRef = _firestore.collection('accounts').doc(donorId);
//     batch.update(donorRef, {
//       'profile.points': FieldValue.increment(10),
//       'profile.totalDonations': FieldValue.increment(1),
//     });
//
//     DocumentReference receiverRef = _firestore.collection('accounts').doc(receiverId);
//     batch.update(receiverRef, {
//       'profile.points': FieldValue.increment(5),
//       'profile.totalReceives': FieldValue.increment(1),
//     });
//
//     DocumentReference volunteerRef = _firestore.collection('accounts').doc(volunteerId);
//     batch.update(volunteerRef, {
//       'profile.points': FieldValue.increment(20),
//       'profile.totalTasks': FieldValue.increment(1),
//     });
//
//     await batch.commit();
//     notifyListeners();
//   }
//
//   Future<void> requestPickup(String requestId, String volunteerUid, String name) async {
//     await _firestore.collection('requests').doc(requestId)
//         .collection('pickup_requests').doc(volunteerUid).set({
//       'volunteerId': volunteerUid,
//       'volunteerName': name,
//       'requestedAt': FieldValue.serverTimestamp(),
//       'status': 'pending',
//     });
//   }
// }



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VolunteerProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getAvailableRequests() {
    return _firestore.collection('requests')
        .where('status', whereIn: ['approved', 'delivered'])
        .where('deliverystatus', whereIn: ['pending', 'none'])
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot> getMyDeliveries(String uid) {
    return _firestore.collection('requests')
        .where('volunteerId', isEqualTo: uid)
        .where('deliverystatus', isEqualTo: 'ongoing')
        .orderBy('pickupAt', descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot> getCompletedDeliveries(String uid) {
    return _firestore.collection('requests')
        .where('volunteerId', isEqualTo: uid)
        .where('deliverystatus', isEqualTo: 'completed')
        .orderBy('completedAt', descending: true)
        .snapshots();
  }

  Future<void> confirmPickup(String id) async {
    await _firestore.collection('requests').doc(id).update({
      'deliverystatus': 'ongoing',
      'pickupAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> completeDelivery({required String requestId, required String volunteerId, required String donorId, required String receiverId}) async {
    final WriteBatch batch = _firestore.batch();
    batch.update(_firestore.collection('requests').doc(requestId), {
      'deliverystatus': 'completed',
      'status': 'completed',
      'completedAt': FieldValue.serverTimestamp(),
    });
    batch.update(_firestore.collection('accounts').doc(donorId), {'profile.points': FieldValue.increment(10), 'profile.totalDonations': FieldValue.increment(1)});
    batch.update(_firestore.collection('accounts').doc(receiverId), {'profile.points': FieldValue.increment(5), 'profile.totalReceives': FieldValue.increment(1)});
    batch.update(_firestore.collection('accounts').doc(volunteerId), {'profile.points': FieldValue.increment(20), 'profile.totalTasks': FieldValue.increment(1)});
    await batch.commit();
    notifyListeners();
  }

  Future<void> requestPickup(String id, String uid, String name) async {
    await _firestore.collection('requests').doc(id).collection('pickup_requests').doc(uid).set({
      'volunteerId': uid, 'volunteerName': name, 'requestedAt': FieldValue.serverTimestamp(), 'status': 'pending',
    });
  }
}