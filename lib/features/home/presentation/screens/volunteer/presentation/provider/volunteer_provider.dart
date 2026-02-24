//
//
//
//
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
// class VolunteerProvider extends ChangeNotifier {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   // ১. যে রিকোয়েস্টগুলো ভলান্টিয়ারের জন্য উন্মুক্ত
//   Stream<QuerySnapshot> getAvailableRequests() {
//     return _firestore.collection('requests')
//         .where('status', whereIn: ['approved', 'delivered']) // ডোনার অ্যাপ্রুভ করলে বা ডেলিভারি মোডে থাকলে দেখা যাবে
//         .where('deliverystatus', whereIn: ['none', 'pending'])
//         .snapshots();
//   }
//
//   // ২. ভলান্টিয়ার যখন খাবারটি ডোনারের কাছ থেকে নিয়ে নেবে (Pickup)
//   Future<void> confirmPickup(String id) async {
//     await _firestore.collection('requests').doc(id).update({
//       'status': 'delivered', // স্ট্যাটাস ডেলিভারি মোডে থাকবে
//       'deliverystatus': 'ongoing', // এখন এটি চলমান
//       'pickupAt': FieldValue.serverTimestamp(),
//     });
//   }
//
//   // ৩. চলমান ডেলিভারি লিস্ট
//   Stream<QuerySnapshot> getMyDeliveries(String uid) {
//     return _firestore.collection('requests')
//         .where('volunteerId', isEqualTo: uid)
//         .where('deliverystatus', isEqualTo: 'ongoing')
//         .snapshots();
//   }
//
//   // ৪. কমপ্লিট করা ডেলিভারি লিস্ট
//   Stream<QuerySnapshot> getCompletedDeliveries(String uid) {
//     return _firestore.collection('requests')
//         .where('volunteerId', isEqualTo: uid)
//         .where('deliverystatus', isEqualTo: 'completed')
//         .snapshots();
//   }
//
//   // ৫. ডেলিভারি সম্পন্ন হলে এবং পয়েন্ট যোগ করা
//   Future<void> completeDelivery({
//     required String requestId,
//     required String volunteerId,
//     required String donorId,
//     required String receiverId
//   }) async {
//     final WriteBatch batch = _firestore.batch();
//
//     batch.update(_firestore.collection('requests').doc(requestId), {
//       'deliverystatus': 'completed',
//       'status': 'completed',
//       'completedAt': FieldValue.serverTimestamp(),
//     });
//
//     // পয়েন্ট সিস্টেম আপডেট
//     batch.update(_firestore.collection('accounts').doc(donorId), {'profile.points': FieldValue.increment(10), 'profile.totalDonations': FieldValue.increment(1)});
//     batch.update(_firestore.collection('accounts').doc(receiverId), {'profile.points': FieldValue.increment(5), 'profile.totalReceives': FieldValue.increment(1)});
//     batch.update(_firestore.collection('accounts').doc(volunteerId), {'profile.points': FieldValue.increment(20), 'profile.totalTasks': FieldValue.increment(1)});
//
//     await batch.commit();
//     notifyListeners();
//   }
//
//   // ৬. ভলান্টিয়ার যখন কোনো রিকোয়েস্টে আগ্রহ দেখাবে (Bidding)
//   Future<void> requestPickup(String id, String uid, String name) async {
//     await _firestore.collection('requests').doc(id).collection('pickup_requests').doc(uid).set({
//       'volunteerId': uid,
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

  // ১. যে রিকোয়েস্টগুলো ভলান্টিয়ারের জন্য উন্মুক্ত (Available for pickup)
  Stream<QuerySnapshot> getAvailableRequests() {
    return _firestore
        .collection('requests')
        .where('status', whereIn: ['approved', 'delivered'])
        .where('deliverystatus', whereIn: ['none', 'pending'])
        .snapshots();
  }

  // ২. ভলান্টিয়ার যখন খাবারটি ডোনারের কাছ থেকে নিয়ে নেবে (Confirm Pickup)
  Future<void> confirmPickup(String id) async {
    try {
      await _firestore.collection('requests').doc(id).update({
        'status': 'delivered',
        'deliverystatus': 'ongoing',
        'pickupAt': FieldValue.serverTimestamp(),
      });
      notifyListeners();
    } catch (e) {
      debugPrint("Error confirming pickup: $e");
      rethrow;
    }
  }

  // ৩. চলমান ডেলিভারি লিস্ট (Ongoing)
  Stream<QuerySnapshot> getMyDeliveries(String uid) {
    return _firestore
        .collection('requests')
        .where('volunteerId', isEqualTo: uid)
        .where('deliverystatus', isEqualTo: 'ongoing')
        .snapshots();
  }

  // ৪. কমপ্লিট করা ডেলিভারি লিস্ট (History)
  Stream<QuerySnapshot> getCompletedDeliveries(String uid) {
    return _firestore
        .collection('requests')
        .where('volunteerId', isEqualTo: uid)
        .where('deliverystatus', isEqualTo: 'completed')
        .snapshots();
  }

  // ৫. ডেলিভারি সম্পন্ন হলে পয়েন্ট এবং স্ট্যাটাস একসাথে আপডেট (The Core Logic)
  Future<void> completeDelivery({
    required String requestId,
    required String volunteerId,
    required String donorId,
    required String receiverId,
  }) async {
    try {
      final WriteBatch batch = _firestore.batch();

      // রিকোয়েস্ট ডকুমেন্টের স্ট্যাটাস আপডেট
      batch.update(_firestore.collection('requests').doc(requestId), {
        'deliverystatus': 'completed',
        'status': 'completed',
        'completedAt': FieldValue.serverTimestamp(),
      });

      // ডোনারের প্রোফাইলে পয়েন্ট এবং ডোনেশন কাউন্ট আপডেট
      batch.set(_firestore.collection('accounts').doc(donorId), {
        'profile': {
          'points': FieldValue.increment(10),
          'totalDonations': FieldValue.increment(1),
        }
      }, SetOptions(merge: true));

      // রিসিভারের প্রোফাইলে পয়েন্ট এবং রিসিভ কাউন্ট আপডেট
      batch.set(_firestore.collection('accounts').doc(receiverId), {
        'profile': {
          'points': FieldValue.increment(5),
          'totalReceives': FieldValue.increment(1),
        }
      }, SetOptions(merge: true));

      // ভলান্টিয়ারের প্রোফাইলে পয়েন্ট এবং টাস্ক কাউন্ট আপডেট
      batch.set(_firestore.collection('accounts').doc(volunteerId), {
        'profile': {
          'points': FieldValue.increment(20),
          'totalTasks': FieldValue.increment(1),
        }
      }, SetOptions(merge: true));

      // সবগুলো অপারেশন একসাথে ফায়ারবেসে পাঠানো
      await batch.commit();

      notifyListeners();
      debugPrint("Delivery completed and points distributed successfully!");
    } catch (e) {
      debugPrint("Error in completeDelivery batch: $e");
      rethrow;
    }
  }

  // ৬. ভলান্টিয়ার যখন কোনো রিকোয়েস্টে আগ্রহ দেখাবে (Bidding/Request)
  Future<void> requestPickup(String id, String uid, String name) async {
    try {
      await _firestore
          .collection('requests')
          .doc(id)
          .collection('pickup_requests')
          .doc(uid)
          .set({
        'volunteerId': uid,
        'volunteerName': name,
        'requestedAt': FieldValue.serverTimestamp(),
        'status': 'pending',
      });
    } catch (e) {
      debugPrint("Error requesting pickup: $e");
      rethrow;
    }
  }
}