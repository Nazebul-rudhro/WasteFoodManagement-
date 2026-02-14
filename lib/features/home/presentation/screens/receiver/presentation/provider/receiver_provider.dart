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
//   /// 🔹 Fetch All Posts and My Previous Requests
//   Future<void> fetchAllPosts() async {
//     final uid = _auth.currentUser?.uid;
//     if (uid == null) return;
//
//     isLoading = true;
//     notifyListeners();
//
//     try {
//       // ১. সব পোস্ট গেট করা
//       final snapshot = await _db
//           .collection('posts')
//           .orderBy('createdAt', descending: true)
//           .get();
//
//       allPosts = snapshot.docs.map((doc) => PostModel.fromSnapshot(doc)).toList();
//
//       // ২. ইউজারের নিজের করা রিকোয়েস্টগুলো গেট করা
//       final reqSnapshot = await _db
//           .collection('requests')
//           .where('receiverId', isEqualTo: uid)
//           .get();
//
//       myRequests = reqSnapshot.docs
//           .map((d) => (d.data() as Map<String, dynamic>)['postId'] as String)
//           .toList();
//
//     } catch (e) {
//       debugPrint("❌ Provider Fetch Error: $e");
//     } finally {
//       isLoading = false;
//       notifyListeners();
//     }
//   }
//
//   /// 🔹 Send Request & Update 'requestedBy' in Posts Collection
//   Future<void> sendRequest(String postId, String donorId) async {
//     final uid = _auth.currentUser?.uid;
//
//     // ইউজার লগইন না থাকলে বা অলরেডি রিকোয়েস্ট করা থাকলে রিটার্ন করবে
//     if (uid == null || myRequests.contains(postId)) return;
//
//     setRequesting(postId, true);
//
//     try {
//       // WriteBatch ব্যবহার করা হয়েছে যেন দুটি অপারেশনই সফল হয় অথবা একটিও না হয়
//       WriteBatch batch = _db.batch();
//
//       // ১. 'requests' কালেকশনে নতুন রিকোয়েস্ট অ্যাড করা
//       DocumentReference requestRef = _db.collection('requests').doc();
//       batch.set(requestRef, {
//         "postId": postId,
//         "donorId": donorId,
//         "receiverId": uid,
//         "status": "pending",
//         "createdAt": FieldValue.serverTimestamp(),
//       });
//
//       // ২. 'posts' কালেকশনের ঐ নির্দিষ্ট ডকুমেন্টের 'requestedBy' ফিল্ডে ইউজার আইডি অ্যাড করা
//       DocumentReference postRef = _db.collection('posts').doc(postId);
//       batch.update(postRef, {
//         "requestedBy": FieldValue.arrayUnion([uid]) // এটি লিস্টে আইডি অ্যাড করবে (ডুপ্লিকেট হবে না)
//       });
//
//       // ৩. আপনার ২ সেকেন্ডের ফিক্সড টাইমার এবং ব্যাচ কমিট একসাথে রান করা
//       await Future.wait([
//         batch.commit(),
//         Future.delayed(const Duration(seconds: 2)),
//       ]);
//
//       // লোকাল স্টেট আপডেট করা যেন ইউআই সাথে সাথে পরিবর্তন হয়
//       myRequests.add(postId);
//
//     } catch (e) {
//       debugPrint("❌ Request Submission Error: $e");
//       rethrow;
//     } finally {
//       setRequesting(postId, false);
//     }
//   }
//
//   /// 🔹 Per-Post Loading State Handler
//   void setRequesting(String postId, bool value) {
//     isRequesting[postId] = value;
//     notifyListeners();
//   }
//
//   // ======================== FILTERS ========================
//
//   /// ১. পেন্ডিং পোস্ট (যেগুলো রিকোয়েস্ট করা হয়েছে কিন্তু স্ট্যাটাস এখনও এভেইলএবল)
//   List<PostModel> get pendingPosts {
//     return allPosts.where((p) =>
//     myRequests.contains(p.postId) && p.status == 'available'
//     ).toList();
//   }
//
//   /// ২. এপ্রুভড পোস্ট (যেগুলো ডোনার একসেপ্ট করেছে)
//   List<PostModel> get approvedPosts {
//     return allPosts.where((p) =>
//     myRequests.contains(p.postId) && p.status == 'approved'
//     ).toList();
//   }
//
//   /// ৩. রিজেক্টেড পোস্ট (যেগুলো ডোনার ডিক্লাইন করেছে)
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

  /// ১. মেইন লিস্ট (যেগুলোতে আমি রিকোয়েস্ট দেইনি এবং স্ট্যাটাস এভেইলএবল)
  List<PostModel> get availablePostsForMe {
    return allPosts.where((post) =>
    post.status == 'available' && !myRequests.contains(post.postId)
    ).toList();
  }

  /// ২. পেন্ডিং পোস্ট (আমি রিকোয়েস্ট করেছি কিন্তু ডোনার এখনো এপ্রুভ করেনি)
  List<PostModel> get pendingPosts {
    return allPosts.where((p) =>
    myRequests.contains(p.postId) && p.status == 'available'
    ).toList();
  }

  /// ৩. এপ্রুভড পোস্ট (ডোনার আমার রিকোয়েস্ট একসেপ্ট করেছে)
  List<PostModel> get approvedPosts {
    return allPosts.where((p) =>
    myRequests.contains(p.postId) && p.status == 'approved'
    ).toList();
  }

  /// ৪. রিজেক্টেড পোস্ট (ডোনার আমার রিকোয়েস্ট রিজেক্ট করেছে)
  List<PostModel> get rejectedPosts {
    return allPosts.where((p) =>
    myRequests.contains(p.postId) && p.status == 'rejected'
    ).toList();
  }

  /// 🔹 ডাটা ফেচ করা
  Future<void> fetchAllPosts() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    isLoading = true;
    notifyListeners();

    try {
      // সব পোস্ট গেট করা
      final snapshot = await _db
          .collection('posts')
          .orderBy('createdAt', descending: true)
          .get();

      allPosts = snapshot.docs.map((doc) => PostModel.fromSnapshot(doc)).toList();

      // ইউজারের নিজের করা রিকোয়েস্টগুলো গেট করা
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

  /// 🔹 রিকোয়েস্ট পাঠানো
  Future<void> sendRequest(String postId, String donorId) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null || myRequests.contains(postId)) return;

    setRequesting(postId, true);

    try {
      WriteBatch batch = _db.batch();

      // 'requests' কালেকশনে ডাটা অ্যাড
      DocumentReference requestRef = _db.collection('requests').doc();
      batch.set(requestRef, {
        "postId": postId,
        "donorId": donorId,
        "receiverId": uid,
        "status": "pending",
        "deliveryType" : "",
        "createdAt": FieldValue.serverTimestamp(),
      });

      // 'posts' কালেকশনে requestedBy আপডেট
      DocumentReference postRef = _db.collection('posts').doc(postId);
      batch.update(postRef, {
        "requestedBy": FieldValue.arrayUnion([uid])
      });

      await batch.commit();

      // লোকাল স্টেট আপডেট
      myRequests.add(postId);
      notifyListeners();

    } catch (e) {
      debugPrint("❌ Request Submission Error: $e");
    } finally {
      setRequesting(postId, false);
    }
  }

  void setRequesting(String postId, bool value) {
    isRequesting[postId] = value;
    notifyListeners();
  }
}