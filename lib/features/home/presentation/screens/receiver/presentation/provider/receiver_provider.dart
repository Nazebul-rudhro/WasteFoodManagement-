// // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:firebase_auth/firebase_auth.dart';
// // // import '../../../../../../auth/data/model/post_model.dart';
// // //
// // // class ReceiverProvider extends ChangeNotifier {
// // //   final FirebaseFirestore _db = FirebaseFirestore.instance;
// // //   final FirebaseAuth _auth = FirebaseAuth.instance;
// // //
// // //   bool isLoading = false;
// // //   List<PostModel> allPosts = [];
// // //   List<String> myRequests = [];
// // //   Map<String, bool> isRequesting = {};
// // //
// // //   /// 🔹 Fetch all posts & current user's requests
// // //   Future<void> fetchAllPosts() async {
// // //     isLoading = true;
// // //     notifyListeners();
// // //
// // //     try {
// // //       final uid = _auth.currentUser?.uid;
// // //       if (uid == null) return;
// // //
// // //       // Fetch all posts
// // //       final snapshot = await _db
// // //           .collection('posts')
// // //           .orderBy('createdAt', descending: true)
// // //           .get();
// // //
// // //       allPosts = snapshot.docs.map((doc) => PostModel.fromSnapshot(doc)).toList();
// // //
// // //       // Fetch current user's requests
// // //       final reqSnapshot = await _db
// // //           .collection('requests')
// // //           .where('receiverId', isEqualTo: uid)
// // //           .get();
// // //
// // //       myRequests = reqSnapshot.docs.map((d) => d['postId'] as String).toList();
// // //     } catch (e) {
// // //       debugPrint("ReceiverProvider fetchAllPosts error: $e");
// // //       allPosts = [];
// // //       myRequests = [];
// // //     }
// // //
// // //     isLoading = false;
// // //     notifyListeners();
// // //   }
// // //
// // //   /// 🔹 Send request for a post
// // //   // Future<void> sendRequest(String postId, String donorId) async {
// // //   //   final uid = _auth.currentUser?.uid;
// // //   //   if (uid == null) return;
// // //   //   if (myRequests.contains(postId)) return;
// // //   //
// // //   //   setRequesting(postId, true);
// // //   //
// // //   //   try {
// // //   //     await _db.collection('requests').add({
// // //   //       "postId": postId,
// // //   //       "donorId": donorId,
// // //   //       "receiverId": uid,
// // //   //       "status": "pending",
// // //   //       "createdAt": FieldValue.serverTimestamp(),
// // //   //     });
// // //   //
// // //   //     myRequests.add(postId);
// // //   //     notifyListeners();
// // //   //   } catch (e) {
// // //   //     debugPrint("ReceiverProvider sendRequest error: $e");
// // //   //   } finally {
// // //   //     setRequesting(postId, false);
// // //   //   }
// // //   // }
// // //
// // //   /// 🔹 Send request for a post with a fixed 2-second timer
// // //   Future<void> sendRequest(String postId, String donorId) async {
// // //     final uid = _auth.currentUser?.uid;
// // //     if (uid == null) return;
// // //     if (myRequests.contains(postId)) return;
// // //
// // //     setRequesting(postId, true); // লোডিং শুরু
// // //
// // //     try {
// // //       // এখানে ২ সেকেন্ডের টাইমার সেট করা হয়েছে
// // //       await Future.wait([
// // //         _db.collection('requests').add({
// // //           "postId": postId,
// // //           "donorId": donorId,
// // //           "receiverId": uid,
// // //           "status": "pending",
// // //           "createdAt": FieldValue.serverTimestamp(),
// // //         }),
// // //         Future.delayed(const Duration(seconds: 2)), // এই লাইনটি ২ সেকেন্ড অপেক্ষা করাবে
// // //       ]);
// // //
// // //       myRequests.add(postId);
// // //       notifyListeners();
// // //     } catch (e) {
// // //       debugPrint("ReceiverProvider sendRequest error: $e");
// // //     } finally {
// // //       setRequesting(postId, false); // ২ সেকেন্ড পর লোডিং শেষ
// // //     }
// // //   }
// // //   void setRequesting(String postId, bool value) {
// // //     isRequesting[postId] = value;
// // //     notifyListeners();
// // //   }
// // //
// // //   /// 🔹 Filter posts by status
// // //   List<PostModel> get availablePosts =>
// // //       allPosts.where((p) => p.status == 'available').toList();
// // //
// // //   List<PostModel> get approvedPosts =>
// // //       allPosts.where((p) => p.status == 'approved').toList();
// // //
// // //   List<PostModel> get rejectedPosts =>
// // //       allPosts.where((p) => p.status == 'rejected').toList();
// // // }
// //
// //
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:flutter/material.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import '../../../../../../auth/data/model/post_model.dart';
// //
// // class ReceiverProvider extends ChangeNotifier {
// //   final FirebaseFirestore _db = FirebaseFirestore.instance;
// //   final FirebaseAuth _auth = FirebaseAuth.instance;
// //
// //   bool isLoading = false;
// //   List<PostModel> allPosts = [];
// //   List<String> myRequests = []; // এখানে রিকোয়েস্ট করা পোস্টের আইডি থাকে
// //   Map<String, bool> isRequesting = {};
// //
// //   /// 🔹 Fetch all posts & current user's requests
// //   Future<void> fetchAllPosts() async {
// //     isLoading = true;
// //     notifyListeners();
// //
// //     try {
// //       final uid = _auth.currentUser?.uid;
// //       if (uid == null) return;
// //
// //       // ১. সব পোস্ট আনা হচ্ছে
// //       final snapshot = await _db
// //           .collection('posts')
// //           .orderBy('createdAt', descending: true)
// //           .get();
// //
// //       allPosts = snapshot.docs.map((doc) => PostModel.fromSnapshot(doc)).toList();
// //
// //       // ২. বর্তমান ইউজারের পাঠানো রিকোয়েস্টগুলো আনা হচ্ছে
// //       final reqSnapshot = await _db
// //           .collection('requests')
// //           .where('receiverId', isEqualTo: uid)
// //           .get();
// //
// //       // রিকোয়েস্ট কালেকশন থেকে postId গুলো লিস্টে রাখা হচ্ছে
// //       myRequests = reqSnapshot.docs.map((d) => d['postId'] as String).toList();
// //
// //     } catch (e) {
// //       debugPrint("ReceiverProvider fetchAllPosts error: $e");
// //     }
// //
// //     isLoading = false;
// //     notifyListeners();
// //   }
// //
// //   /// 🔹 Send request with a 2-second timer
// //   Future<void> sendRequest(String postId, String donorId) async {
// //     final uid = _auth.currentUser?.uid;
// //     if (uid == null) return;
// //     if (myRequests.contains(postId)) return;
// //
// //     setRequesting(postId, true);
// //
// //     try {
// //       await Future.wait([
// //         _db.collection('requests').add({
// //           "postId": postId,
// //           "donorId": donorId,
// //           "receiverId": uid,
// //           "status": "pending",
// //           "createdAt": FieldValue.serverTimestamp(),
// //         }),
// //         Future.delayed(const Duration(seconds: 2)),
// //       ]);
// //
// //       myRequests.add(postId);
// //       notifyListeners();
// //     } catch (e) {
// //       debugPrint("ReceiverProvider sendRequest error: $e");
// //     } finally {
// //       setRequesting(postId, false);
// //     }
// //   }
// //
// //   void setRequesting(String postId, bool value) {
// //     isRequesting[postId] = value;
// //     notifyListeners();
// //   }
// //
// //   // --- FILTERS ---
// //
// //   // ১. পেন্ডিং পোস্ট ফিল্টার (যেগুলো আমি রিকোয়েস্ট করেছি)
// //   List<PostModel> get pendingPosts {
// //     // p.postId এর সাথে myRequests মিলিয়ে দেখা হচ্ছে
// //     return allPosts.where((p) => myRequests.contains(p.postId)).toList();
// //   }
// //
// //   List<PostModel> get availablePosts =>
// //       allPosts.where((p) => p.status == 'available').toList();
// //
// //   List<PostModel> get approvedPosts =>
// //       allPosts.where((p) => p.status == 'approved').toList();
// //
// //   List<PostModel> get rejectedPosts =>
// //       allPosts.where((p) => p.status == 'rejected').toList();
// // }
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import '../../../../../../auth/data/model/post_model.dart';
//
// class ReceiverProvider extends ChangeNotifier {
//   final FirebaseFirestore _db = FirebaseFirestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   bool isLoading = false;
//   List<PostModel> allPosts = [];
//   List<String> myRequests = [];
//   Map<String, bool> isRequesting = {};
//
//   Future<void> fetchAllPosts() async {
//     isLoading = true;
//     notifyListeners();
//
//     try {
//       final uid = _auth.currentUser?.uid;
//       if (uid == null) return;
//
//       // ১. সব পোস্ট আনা হচ্ছে
//       final snapshot = await _db
//           .collection('posts')
//           .orderBy('createdAt', descending: true)
//           .get();
//
//       allPosts = snapshot.docs.map((doc) => PostModel.fromSnapshot(doc)).toList();
//
//       // ২. আমার রিকোয়েস্টগুলো আনা হচ্ছে
//       final reqSnapshot = await _db
//           .collection('requests')
//           .where('receiverId', isEqualTo: uid)
//           .get();
//
//       // এখানে নিশ্চিত করছি যে requests কালেকশনের 'postId' ফিল্ডটিই নেওয়া হচ্ছে
//       myRequests = reqSnapshot.docs
//           .map((d) => (d.data() as Map<String, dynamic>)['postId'] as String)
//           .toList();
//
//     } catch (e) {
//       debugPrint("❌ Provider Error: $e");
//     }
//
//     isLoading = false;
//     notifyListeners();
//   }
//
//   Future<void> sendRequest(String postId, String donorId) async {
//     final uid = _auth.currentUser?.uid;
//     if (uid == null) return;
//     if (myRequests.contains(postId)) return;
//
//     setRequesting(postId, true);
//
//     try {
//       await Future.wait([
//         _db.collection('requests').add({
//           "postId": postId,
//           "donorId": donorId,
//           "receiverId": uid,
//           "status": "pending",
//           "createdAt": FieldValue.serverTimestamp(),
//         }),
//         Future.delayed(const Duration(seconds: 2)),
//       ]);
//
//       myRequests.add(postId);
//       notifyListeners();
//     } catch (e) {
//       debugPrint("❌ Request Error: $e");
//     } finally {
//       setRequesting(postId, false);
//     }
//   }
//
//   void setRequesting(String postId, bool value) {
//     isRequesting[postId] = value;
//     notifyListeners();
//   }
//
//   // --- FILTERS (নিশ্চিত করা হয়েছে যেন সঠিক ফিল্ড ম্যাচ করে) ---
//
//   List<PostModel> get pendingPosts {
//     return allPosts.where((p) =>
//     myRequests.contains(p.postId) && p.status == 'available'
//     ).toList();
//   }
//
//   List<PostModel> get approvedPosts {
//     return allPosts.where((p) =>
//     myRequests.contains(p.postId) && p.status == 'approved'
//     ).toList();
//   }
//
//   List<PostModel> get rejectedPosts {
//     return allPosts.where((p) =>
//     myRequests.contains(p.postId) && p.status == 'rejected'
//     ).toList();
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../../../auth/data/model/post_model.dart';

class ReceiverProvider extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool isLoading = false;
  List<PostModel> allPosts = [];
  List<String> myRequests = [];
  Map<String, bool> isRequesting = {};

  /// 🔹 Fetch All Posts and My Previous Requests
  Future<void> fetchAllPosts() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    isLoading = true;
    notifyListeners();

    try {
      // ১. সব পোস্ট গেট করা
      final snapshot = await _db
          .collection('posts')
          .orderBy('createdAt', descending: true)
          .get();

      allPosts = snapshot.docs.map((doc) => PostModel.fromSnapshot(doc)).toList();

      // ২. ইউজারের নিজের করা রিকোয়েস্টগুলো গেট করা
      final reqSnapshot = await _db
          .collection('requests')
          .where('receiverId', isEqualTo: uid)
          .get();

      myRequests = reqSnapshot.docs
          .map((d) => (d.data() as Map<String, dynamic>)['postId'] as String)
          .toList();

    } catch (e) {
      debugPrint("❌ Provider Fetch Error: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// 🔹 Send Request & Update 'requestedBy' in Posts Collection
  Future<void> sendRequest(String postId, String donorId) async {
    final uid = _auth.currentUser?.uid;

    // ইউজার লগইন না থাকলে বা অলরেডি রিকোয়েস্ট করা থাকলে রিটার্ন করবে
    if (uid == null || myRequests.contains(postId)) return;

    setRequesting(postId, true);

    try {
      // WriteBatch ব্যবহার করা হয়েছে যেন দুটি অপারেশনই সফল হয় অথবা একটিও না হয়
      WriteBatch batch = _db.batch();

      // ১. 'requests' কালেকশনে নতুন রিকোয়েস্ট অ্যাড করা
      DocumentReference requestRef = _db.collection('requests').doc();
      batch.set(requestRef, {
        "postId": postId,
        "donorId": donorId,
        "receiverId": uid,
        "status": "pending",
        "createdAt": FieldValue.serverTimestamp(),
      });

      // ২. 'posts' কালেকশনের ঐ নির্দিষ্ট ডকুমেন্টের 'requestedBy' ফিল্ডে ইউজার আইডি অ্যাড করা
      DocumentReference postRef = _db.collection('posts').doc(postId);
      batch.update(postRef, {
        "requestedBy": FieldValue.arrayUnion([uid]) // এটি লিস্টে আইডি অ্যাড করবে (ডুপ্লিকেট হবে না)
      });

      // ৩. আপনার ২ সেকেন্ডের ফিক্সড টাইমার এবং ব্যাচ কমিট একসাথে রান করা
      await Future.wait([
        batch.commit(),
        Future.delayed(const Duration(seconds: 2)),
      ]);

      // লোকাল স্টেট আপডেট করা যেন ইউআই সাথে সাথে পরিবর্তন হয়
      myRequests.add(postId);

    } catch (e) {
      debugPrint("❌ Request Submission Error: $e");
      rethrow;
    } finally {
      setRequesting(postId, false);
    }
  }

  /// 🔹 Per-Post Loading State Handler
  void setRequesting(String postId, bool value) {
    isRequesting[postId] = value;
    notifyListeners();
  }

  // ======================== FILTERS ========================

  /// ১. পেন্ডিং পোস্ট (যেগুলো রিকোয়েস্ট করা হয়েছে কিন্তু স্ট্যাটাস এখনও এভেইলএবল)
  List<PostModel> get pendingPosts {
    return allPosts.where((p) =>
    myRequests.contains(p.postId) && p.status == 'available'
    ).toList();
  }

  /// ২. এপ্রুভড পোস্ট (যেগুলো ডোনার একসেপ্ট করেছে)
  List<PostModel> get approvedPosts {
    return allPosts.where((p) =>
    myRequests.contains(p.postId) && p.status == 'approved'
    ).toList();
  }

  /// ৩. রিজেক্টেড পোস্ট (যেগুলো ডোনার ডিক্লাইন করেছে)
  List<PostModel> get rejectedPosts {
    return allPosts.where((p) =>
    myRequests.contains(p.postId) && p.status == 'rejected'
    ).toList();
  }
}