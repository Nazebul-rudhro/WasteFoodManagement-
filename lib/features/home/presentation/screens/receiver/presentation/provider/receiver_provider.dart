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
// //   List<String> myRequests = [];
// //   Map<String, bool> isRequesting = {};
// //
// //   /// 🔹 Fetch All Posts and My Previous Requests
// //   Future<void> fetchAllPosts() async {
// //     final uid = _auth.currentUser?.uid;
// //     if (uid == null) return;
// //
// //     isLoading = true;
// //     notifyListeners();
// //
// //     try {
// //       // ১. সব পোস্ট গেট করা
// //       final snapshot = await _db
// //           .collection('posts')
// //           .orderBy('createdAt', descending: true)
// //           .get();
// //
// //       allPosts = snapshot.docs.map((doc) => PostModel.fromSnapshot(doc)).toList();
// //
// //       // ২. ইউজারের নিজের করা রিকোয়েস্টগুলো গেট করা
// //       final reqSnapshot = await _db
// //           .collection('requests')
// //           .where('receiverId', isEqualTo: uid)
// //           .get();
// //
// //       myRequests = reqSnapshot.docs
// //           .map((d) => (d.data() as Map<String, dynamic>)['postId'] as String)
// //           .toList();
// //
// //     } catch (e) {
// //       debugPrint("❌ Provider Fetch Error: $e");
// //     } finally {
// //       isLoading = false;
// //       notifyListeners();
// //     }
// //   }
// //
// //   /// 🔹 Send Request & Update 'requestedBy' in Posts Collection
// //   Future<void> sendRequest(String postId, String donorId) async {
// //     final uid = _auth.currentUser?.uid;
// //
// //     // ইউজার লগইন না থাকলে বা অলরেডি রিকোয়েস্ট করা থাকলে রিটার্ন করবে
// //     if (uid == null || myRequests.contains(postId)) return;
// //
// //     setRequesting(postId, true);
// //
// //     try {
// //       // WriteBatch ব্যবহার করা হয়েছে যেন দুটি অপারেশনই সফল হয় অথবা একটিও না হয়
// //       WriteBatch batch = _db.batch();
// //
// //       // ১. 'requests' কালেকশনে নতুন রিকোয়েস্ট অ্যাড করা
// //       DocumentReference requestRef = _db.collection('requests').doc();
// //       batch.set(requestRef, {
// //         "postId": postId,
// //         "donorId": donorId,
// //         "receiverId": uid,
// //         "status": "pending",
// //         "createdAt": FieldValue.serverTimestamp(),
// //       });
// //
// //       // ২. 'posts' কালেকশনের ঐ নির্দিষ্ট ডকুমেন্টের 'requestedBy' ফিল্ডে ইউজার আইডি অ্যাড করা
// //       DocumentReference postRef = _db.collection('posts').doc(postId);
// //       batch.update(postRef, {
// //         "requestedBy": FieldValue.arrayUnion([uid]) // এটি লিস্টে আইডি অ্যাড করবে (ডুপ্লিকেট হবে না)
// //       });
// //
// //       // ৩. আপনার ২ সেকেন্ডের ফিক্সড টাইমার এবং ব্যাচ কমিট একসাথে রান করা
// //       await Future.wait([
// //         batch.commit(),
// //         Future.delayed(const Duration(seconds: 2)),
// //       ]);
// //
// //       // লোকাল স্টেট আপডেট করা যেন ইউআই সাথে সাথে পরিবর্তন হয়
// //       myRequests.add(postId);
// //
// //     } catch (e) {
// //       debugPrint("❌ Request Submission Error: $e");
// //       rethrow;
// //     } finally {
// //       setRequesting(postId, false);
// //     }
// //   }
// //
// //   /// 🔹 Per-Post Loading State Handler
// //   void setRequesting(String postId, bool value) {
// //     isRequesting[postId] = value;
// //     notifyListeners();
// //   }
// //
// //   // ======================== FILTERS ========================
// //
// //   /// ১. পেন্ডিং পোস্ট (যেগুলো রিকোয়েস্ট করা হয়েছে কিন্তু স্ট্যাটাস এখনও এভেইলএবল)
// //   List<PostModel> get pendingPosts {
// //     return allPosts.where((p) =>
// //     myRequests.contains(p.postId) && p.status == 'available'
// //     ).toList();
// //   }
// //
// //   /// ২. এপ্রুভড পোস্ট (যেগুলো ডোনার একসেপ্ট করেছে)
// //   List<PostModel> get approvedPosts {
// //     return allPosts.where((p) =>
// //     myRequests.contains(p.postId) && p.status == 'approved'
// //     ).toList();
// //   }
// //
// //   /// ৩. রিজেক্টেড পোস্ট (যেগুলো ডোনার ডিক্লাইন করেছে)
// //   List<PostModel> get rejectedPosts {
// //     return allPosts.where((p) =>
// //     myRequests.contains(p.postId) && p.status == 'rejected'
// //     ).toList();
// //   }
// // }
//
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
// //   List<String> myRequests = [];
// //   Map<String, bool> isRequesting = {};
// //
// //   /// ১. মেইন লিস্ট (যেগুলোতে আমি রিকোয়েস্ট দেইনি এবং স্ট্যাটাস এভেইলএবল)
// //   List<PostModel> get availablePostsForMe {
// //     return allPosts.where((post) =>
// //     post.status == 'available' && !myRequests.contains(post.postId)
// //     ).toList();
// //   }
// //
// //   /// ২. পেন্ডিং পোস্ট (আমি রিকোয়েস্ট করেছি কিন্তু ডোনার এখনো এপ্রুভ করেনি)
// //   List<PostModel> get pendingPosts {
// //     return allPosts.where((p) =>
// //     myRequests.contains(p.postId) && p.status == 'available'
// //     ).toList();
// //   }
// //
// //   /// ৩. এপ্রুভড পোস্ট (ডোনার আমার রিকোয়েস্ট একসেপ্ট করেছে)
// //   List<PostModel> get approvedPosts {
// //     return allPosts.where((p) =>
// //     myRequests.contains(p.postId) && p.status == 'approved'
// //     ).toList();
// //   }
// //
// //   /// ৪. রিজেক্টেড পোস্ট (ডোনার আমার রিকোয়েস্ট রিজেক্ট করেছে)
// //   List<PostModel> get rejectedPosts {
// //     return allPosts.where((p) =>
// //     myRequests.contains(p.postId) && p.status == 'rejected'
// //     ).toList();
// //   }
// //
// //   /// 🔹 ডাটা ফেচ করা
// //   Future<void> fetchAllPosts() async {
// //     final uid = _auth.currentUser?.uid;
// //     if (uid == null) return;
// //
// //     isLoading = true;
// //     notifyListeners();
// //
// //     try {
// //       // সব পোস্ট গেট করা
// //       final snapshot = await _db
// //           .collection('posts')
// //           .orderBy('createdAt', descending: true)
// //           .get();
// //
// //       allPosts = snapshot.docs.map((doc) => PostModel.fromSnapshot(doc)).toList();
// //
// //       // ইউজারের নিজের করা রিকোয়েস্টগুলো গেট করা
// //       final reqSnapshot = await _db
// //           .collection('requests')
// //           .where('receiverId', isEqualTo: uid)
// //           .get();
// //
// //       myRequests = reqSnapshot.docs
// //           .map((d) => (d.data() as Map<String, dynamic>)['postId'] as String)
// //           .toList();
// //
// //     } catch (e) {
// //       debugPrint("❌ Provider Fetch Error: $e");
// //     } finally {
// //       isLoading = false;
// //       notifyListeners();
// //     }
// //   }
// //
// //   /// 🔹 রিকোয়েস্ট পাঠানো
// //   Future<void> sendRequest(String postId, String donorId) async {
// //     final uid = _auth.currentUser?.uid;
// //     if (uid == null || myRequests.contains(postId)) return;
// //
// //     setRequesting(postId, true);
// //
// //     try {
// //       WriteBatch batch = _db.batch();
// //
// //       // 'requests' কালেকশনে ডাটা অ্যাড
// //       DocumentReference requestRef = _db.collection('requests').doc();
// //       batch.set(requestRef, {
// //         "postId": postId,
// //         "donorId": donorId,
// //         "receiverId": uid,
// //         "status": "pending",
// //         "deliveryType" : "",
// //         "createdAt": FieldValue.serverTimestamp(),
// //       });
// //
// //       // 'posts' কালেকশনে requestedBy আপডেট
// //       DocumentReference postRef = _db.collection('posts').doc(postId);
// //       batch.update(postRef, {
// //         "requestedBy": FieldValue.arrayUnion([uid])
// //       });
// //
// //       await batch.commit();
// //
// //       // লোকাল স্টেট আপডেট
// //       myRequests.add(postId);
// //       notifyListeners();
// //
// //     } catch (e) {
// //       debugPrint("❌ Request Submission Error: $e");
// //     } finally {
// //       setRequesting(postId, false);
// //     }
// //   }
// //
// //   void setRequesting(String postId, bool value) {
// //     isRequesting[postId] = value;
// //     notifyListeners();
// //   }
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
//   // --- ট্যাব ফিল্টারিং লজিক ---
//
//   /// ১. এভেইলএবল খাবার (যেখানে আমি এখনো রিকোয়েস্ট করিনি এবং খাবারটি এখনো ফাঁকা আছে)
//   List<PostModel> get availablePostsForMe => allPosts.where((p) =>
//   p.status == 'available' && !myRequests.contains(p.postId)).toList();
//
//   /// ২. পেন্ডিং রিকোয়েস্ট (আমি রিকোয়েস্ট করেছি কিন্তু ডোনার এখনো সিদ্ধান্ত নেয়নি)
//   List<PostModel> get pendingPosts => allPosts.where((p) =>
//   myRequests.contains(p.postId) && p.status == 'available').toList();
//
//   /// ৩. এপ্রুভড রিকোয়েস্ট (ডোনার আমার রিকোয়েস্ট একসেপ্ট করেছে)
//   List<PostModel> get approvedPosts => allPosts.where((p) =>
//   myRequests.contains(p.postId) && p.status == 'approved').toList();
//
//   /// ৪. রিজেক্টেড রিকোয়েস্ট (আপনার এররটি এখানে সমাধান হবে)
//   List<PostModel> get rejectedPosts => allPosts.where((p) =>
//   myRequests.contains(p.postId) && p.status == 'rejected').toList();
//
//   // --- ডাটা ফেচিং লজিক ---
//
//   Future<void> fetchAllPosts() async {
//     final uid = _auth.currentUser?.uid;
//     if (uid == null) return;
//     isLoading = true;
//     notifyListeners();
//
//     try {
//       // সব পোস্ট লোড করা
//       final snapshot = await _db.collection('posts').orderBy('createdAt', descending: true).get();
//       allPosts = snapshot.docs.map((doc) => PostModel.fromSnapshot(doc)).toList();
//
//       // ইউজারের নিজের করা সব রিকোয়েস্টের লিস্ট গেট করা
//       final reqSnapshot = await _db.collection('requests').where('receiverId', isEqualTo: uid).get();
//       myRequests = reqSnapshot.docs.map((d) => d['postId'].toString()).toList();
//     } catch (e) {
//       debugPrint("Fetch Error: $e");
//     } finally {
//       isLoading = false;
//       notifyListeners();
//     }
//   }
//
//   // --- রিকোয়েস্ট পাঠানোর লজিক ---
//
//   Future<void> sendRequest(String postId, String donorId) async {
//     final uid = _auth.currentUser?.uid;
//     if (uid == null || myRequests.contains(postId)) return;
//
//     // লোডিং শুরু
//     setRequesting(postId, true);
//
//     try {
//       WriteBatch batch = _db.batch();
//
//       // requests কালেকশনে নতুন ডকুমেন্ট
//       DocumentReference reqRef = _db.collection('requests').doc();
//       batch.set(reqRef, {
//         "requestId": reqRef.id,
//         "postId": postId,
//         "donorId": donorId,
//         "receiverId": uid,
//         "status": "pending",
//         "deliveryType": "",
//         "createdAt": FieldValue.serverTimestamp(),
//       });
//
//       // মূল পোস্ট ডকুমেন্টে রিসিভারের আইডি আপডেট
//       batch.update(_db.collection('posts').doc(postId), {
//         "requestedBy": FieldValue.arrayUnion([uid])
//       });
//
//       await batch.commit();
//
//       // লোকাল লিস্টে অ্যাড করা যাতে UI সাথে সাথে আপডেট হয়
//       if (!myRequests.contains(postId)) {
//         myRequests.add(postId);
//       }
//
//     } catch (e) {
//       debugPrint("Send Request Error: $e");
//     } finally {
//       setRequesting(postId, false);
//     }
//   }
//
//   // বাটন লোডিং কন্ট্রোল করার জন্য
//   void setRequesting(String postId, bool value) {
//     isRequesting[postId] = value;
//     notifyListeners();
//   }
// }


//
// import 'dart:async';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import '../../../../../../auth/data/model/post_model.dart';
//
// class ReceiverProvider extends ChangeNotifier {
//   final FirebaseFirestore _db = FirebaseFirestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   // --- States ---
//   bool _isLoading = false;
//   bool get isLoading => _isLoading;
//
//   List<PostModel> _allPosts = [];
//
//   /// postId কি (Key) এবং status (pending/approved/rejected) ভ্যালু হিসেবে থাকবে
//   Map<String, String> _requestStatusMap = {};
//
//   /// বাটন লোডিং কন্ট্রোল করার জন্য
//   Map<String, bool> isRequesting = {};
//
//   // --- সাবস্ক্রিপশন হ্যান্ডলার (মেমরি লিক রোধে) ---
//   StreamSubscription? _postsSub;
//   StreamSubscription? _requestsSub;
//
//   // --- ট্যাব ফিল্টারিং লজিক (Getters) ---
//
//   /// ১. এভেইলএবল খাবার: যেগুলোতে আমি এখনো রিকোয়েস্ট করিনি
//   List<PostModel> get availablePostsForMe => _allPosts
//       .where((p) => p.status == 'available' && !_requestStatusMap.containsKey(p.postId))
//       .toList();
//
//   /// ২. পেন্ডিং রিকোয়েস্ট: রিকোয়েস্ট করেছি কিন্তু ডোনার এখনো সিদ্ধান্ত নেয়নি
//   List<PostModel> get pendingPosts => _allPosts
//       .where((p) => _requestStatusMap[p.postId] == 'pending')
//       .toList();
//
//   /// ৩. এপ্রুভড রিকোয়েস্ট: ডোনার আমার রিকোয়েস্ট একসেপ্ট করেছে
//   List<PostModel> get approvedPosts => _allPosts
//       .where((p) => _requestStatusMap[p.postId] == 'approved')
//       .toList();
//
//   /// ৪. রিজেক্টেড রিকোয়েস্ট: ডোনার রিকোয়েস্ট ডিক্লাইন করেছে
//   List<PostModel> get rejectedPosts => _allPosts
//       .where((p) => _requestStatusMap[p.postId] == 'rejected')
//       .toList();
//
//
//   // --- ডাটা ফেচিং (Real-time Stream) ---
//
//   void fetchAllPosts() {
//     final uid = _auth.currentUser?.uid;
//     if (uid == null) return;
//
//     _isLoading = true;
//     notifyListeners();
//
//     // ১. আমার করা রিকোয়েস্ট এবং সেগুলোর স্ট্যাটাস রিয়েল-টাইমে লিসেন করা
//     _requestsSub?.cancel();
//     _requestsSub = _db
//         .collection('requests')
//         .where('receiverId', isEqualTo: uid)
//         .snapshots()
//         .listen((snapshot) {
//       _requestStatusMap.clear();
//       for (var doc in snapshot.docs) {
//         final data = doc.data();
//         _requestStatusMap[data['postId']] = data['status'] ?? 'pending';
//       }
//       notifyListeners();
//     }, onError: (e) => debugPrint("Requests Listener Error: $e"));
//
//     // ২. সকল পোস্ট রিয়েল-টাইমে লিসেন করা
//     _postsSub?.cancel();
//     _postsSub = _db
//         .collection('posts')
//         .orderBy('createdAt', descending: true)
//         .snapshots()
//         .listen((snapshot) {
//       _allPosts = snapshot.docs.map((doc) => PostModel.fromSnapshot(doc)).toList();
//       _isLoading = false;
//       notifyListeners();
//     }, onError: (e) {
//       _isLoading = false;
//       notifyListeners();
//       debugPrint("Posts Listener Error: $e");
//     });
//   }
//
//
//   // --- রিকোয়েস্ট অ্যাকশন লজিক ---
//
//   Future<void> sendRequest(String postId, String donorId) async {
//     final uid = _auth.currentUser?.uid;
//     if (uid == null || _requestStatusMap.containsKey(postId)) return;
//
//     setRequesting(postId, true);
//
//     try {
//       WriteBatch batch = _db.batch();
//
//       // requests কালেকশনে নতুন ডকুমেন্ট তৈরি
//       DocumentReference reqRef = _db.collection('requests').doc();
//       batch.set(reqRef, {
//         "requestId": reqRef.id,
//         "postId": postId,
//         "donorId": donorId,
//         "receiverId": uid,
//         "status": "pending",
//         "deliveryType": "",
//         "createdAt": FieldValue.serverTimestamp(),
//       });
//
//       // মূল পোস্ট ডকুমেন্টে requestedBy লিস্টে রিসিভার আইডি অ্যাড করা
//       batch.update(_db.collection('posts').doc(postId), {
//         "requestedBy": FieldValue.arrayUnion([uid])
//       });
//
//       await batch.commit();
//
//       // রিয়েল-টাইম স্ট্রিম থাকায় ম্যানুয়ালি আপডেট করার প্রয়োজন নেই
//     } catch (e) {
//       debugPrint("Send Request Error: $e");
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
//   // মেমরি লিক রোধে সাবস্ক্রিপশন ক্যানসেল করা
//   @override
//   void dispose() {
//     _postsSub?.cancel();
//     _requestsSub?.cancel();
//     super.dispose();
//   }
// }


//
// import 'dart:async';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import '../../../../../../auth/data/model/post_model.dart';
//
// class ReceiverProvider extends ChangeNotifier {
//   final FirebaseFirestore _db = FirebaseFirestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   bool _isLoading = false;
//   bool get isLoading => _isLoading;
//
//   List<PostModel> _allPosts = [];
//   Map<String, String> _requestStatusMap = {};
//   Map<String, bool> isRequesting = {};
//
//   StreamSubscription? _postsSub;
//   StreamSubscription? _requestsSub;
//
//   // 🔹 UI-এর এরর দূর করার জন্য এই Getter-টি যোগ করা হয়েছে
//   Set<String> get myRequestIds => _requestStatusMap.keys.toSet();
//
//   // --- ট্যাব ফিল্টারিং লজিক ---
//   List<PostModel> get availablePostsForMe => _allPosts
//       .where((p) => p.status == 'available' && !_requestStatusMap.containsKey(p.postId))
//       .toList();
//
//   List<PostModel> get pendingPosts => _allPosts
//       .where((p) => _requestStatusMap[p.postId] == 'pending')
//       .toList();
//
//   List<PostModel> get approvedPosts => _allPosts
//       .where((p) => _requestStatusMap[p.postId] == 'approved')
//       .toList();
//
//   List<PostModel> get rejectedPosts => _allPosts
//       .where((p) => _requestStatusMap[p.postId] == 'rejected')
//       .toList();
//
//   // --- Real-time Fetching ---
//   void fetchAllPosts() {
//     final uid = _auth.currentUser?.uid;
//     if (uid == null) return;
//
//     _isLoading = true;
//     notifyListeners();
//
//     _requestsSub?.cancel();
//     _requestsSub = _db
//         .collection('requests')
//         .where('receiverId', isEqualTo: uid)
//         .snapshots()
//         .listen((snapshot) {
//       _requestStatusMap.clear();
//       for (var doc in snapshot.docs) {
//         final data = doc.data();
//         _requestStatusMap[data['postId']] = data['status'] ?? 'pending';
//       }
//       notifyListeners();
//     });
//
//     _postsSub?.cancel();
//     _postsSub = _db
//         .collection('posts')
//         .orderBy('createdAt', descending: true)
//         .snapshots()
//         .listen((snapshot) {
//       _allPosts = snapshot.docs.map((doc) => PostModel.fromSnapshot(doc)).toList();
//       _isLoading = false;
//       notifyListeners();
//     }, onError: (e) {
//       _isLoading = false;
//       notifyListeners();
//     });
//   }
//
//   // --- Send Request ---
//   Future<void> sendRequest(String postId, String donorId) async {
//     final uid = _auth.currentUser?.uid;
//     if (uid == null || _requestStatusMap.containsKey(postId)) return;
//
//     setRequesting(postId, true);
//     try {
//       WriteBatch batch = _db.batch();
//       DocumentReference reqRef = _db.collection('requests').doc();
//       batch.set(reqRef, {
//         "requestId": reqRef.id,
//         "postId": postId,
//         "donorId": donorId,
//         "receiverId": uid,
//         "status": "pending",
//         "createdAt": FieldValue.serverTimestamp(),
//       });
//
//       batch.update(_db.collection('posts').doc(postId), {
//         "requestedBy": FieldValue.arrayUnion([uid])
//       });
//
//       await batch.commit();
//     } catch (e) {
//       debugPrint("Error: $e");
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
//   @override
//   void dispose() {
//     _postsSub?.cancel();
//     _requestsSub?.cancel();
//     super.dispose();
//   }
// }


//
// import 'dart:async';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import '../../../../../../auth/data/model/post_model.dart';
//
// class ReceiverProvider extends ChangeNotifier {
//   final FirebaseFirestore _db = FirebaseFirestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   bool _isLoading = false;
//   bool get isLoading => _isLoading;
//
//   List<PostModel> _allPosts = [];
//   Map<String, String> _requestStatusMap = {};
//   Map<String, bool> isRequesting = {};
//
//   StreamSubscription? _postsSub;
//   StreamSubscription? _requestsSub;
//
//   Set<String> get myRequestIds => _requestStatusMap.keys.toSet();
//
//   // --- ট্যাব ফিল্টারিং লজিক (Updated for Delivered Status) ---
//
//   // ১. পেন্ডিং ট্যাব
//   List<PostModel> get pendingPosts => _allPosts
//       .where((p) => _requestStatusMap[p.postId] == 'pending')
//       .toList();
//
//   // ২. এপ্রুভড ট্যাব (এখানে approved এবং delivered দুইটাই থাকবে)
//   List<PostModel> get approvedPosts => _allPosts
//       .where((p) =>
//   _requestStatusMap[p.postId] == 'approved' ||
//       _requestStatusMap[p.postId] == 'delivered')
//       .toList();
//
//   // ৩. রিজেক্টেড ট্যাব
//   List<PostModel> get rejectedPosts => _allPosts
//       .where((p) => _requestStatusMap[p.postId] == 'rejected')
//       .toList();
//
//   // ৪. হোম পেজের Recent Donation এর জন্য
//   List<PostModel> get availablePostsForMe => _allPosts
//       .where((p) => p.status == 'available' && !_requestStatusMap.containsKey(p.postId))
//       .toList();
//
//   // --- Real-time Data Sync ---
//   void fetchAllPosts() {
//     final uid = _auth.currentUser?.uid;
//     if (uid == null) return;
//
//     _isLoading = true;
//     notifyListeners();
//
//     _requestsSub?.cancel();
//     _requestsSub = _db
//         .collection('requests')
//         .where('receiverId', isEqualTo: uid)
//         .snapshots()
//         .listen((snapshot) {
//       _requestStatusMap.clear();
//       for (var doc in snapshot.docs) {
//         final data = doc.data();
//         // ডাটাবেজ থেকে status (pending/approved/delivered) ম্যাপে সেভ হচ্ছে
//         _requestStatusMap[data['postId']] = data['status'] ?? 'pending';
//       }
//       notifyListeners();
//     });
//
//     _postsSub?.cancel();
//     _postsSub = _db
//         .collection('posts')
//         .orderBy('createdAt', descending: true)
//         .snapshots()
//         .listen((snapshot) {
//       _allPosts = snapshot.docs.map((doc) => PostModel.fromSnapshot(doc)).toList();
//       _isLoading = false;
//       notifyListeners();
//     }, onError: (e) {
//       _isLoading = false;
//       notifyListeners();
//     });
//   }
//
//   Future<void> sendRequest(String postId, String donorId) async {
//     final uid = _auth.currentUser?.uid;
//     if (uid == null || _requestStatusMap.containsKey(postId)) return;
//
//     setRequesting(postId, true);
//     try {
//       WriteBatch batch = _db.batch();
//       DocumentReference reqRef = _db.collection('requests').doc();
//       batch.set(reqRef, {
//         "requestId": reqRef.id,
//         "postId": postId,
//         "donorId": donorId,
//         "receiverId": uid,
//         "status": "pending",
//         "createdAt": FieldValue.serverTimestamp(),
//       });
//
//       batch.update(_db.collection('posts').doc(postId), {
//         "requestedBy": FieldValue.arrayUnion([uid])
//       });
//
//       await batch.commit();
//     } catch (e) {
//       debugPrint("Error: $e");
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
//   @override
//   void dispose() {
//     _postsSub?.cancel();
//     _requestsSub?.cancel();
//     super.dispose();
//   }
// }

//
//
// import 'dart:async';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import '../../../../../../auth/data/model/post_model.dart'; // পাথ চেক করে নিন
//
// class ReceiverProvider extends ChangeNotifier {
//   final FirebaseFirestore _db = FirebaseFirestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   bool _isLoading = false;
//   bool get isLoading => _isLoading;
//
//   List<PostModel> _allPosts = [];
//   Map<String, Map<String, dynamic>> _requestInfoMap = {};
//   Map<String, bool> isRequesting = {};
//
//   StreamSubscription? _postsSub;
//   StreamSubscription? _requestsSub;
//
//   // ✅ আপনার UI-তে এরর দিচ্ছিল, এখন এই গেটারটি একদম ঠিক আছে
//   Set<String> get myRequestIds => _requestInfoMap.keys.toSet();
//
//   // --- ট্যাব ফিল্টারিং লজিক ---
//
//   List<PostModel> get pendingPosts => _allPosts
//       .where((p) => _requestInfoMap[p.postId]?['status'] == 'pending')
//       .map((p) => _injectRequestData(p)).toList();
//
//   List<PostModel> get approvedPosts => _allPosts
//       .where((p) {
//     final s = _requestInfoMap[p.postId]?['status'];
//     return s == 'approved' || s == 'delivered' || s == 'ongoing';
//   })
//       .map((p) => _injectRequestData(p)).toList();
//
//   List<PostModel> get rejectedPosts => _allPosts
//       .where((p) => _requestInfoMap[p.postId]?['status'] == 'rejected')
//       .map((p) => _injectRequestData(p)).toList();
//
//   // ✅ Home Page এর জন্য এরর-ফ্রি ফিল্টারিং
//   List<PostModel> get availablePostsForMe {
//     return _allPosts.where((post) {
//       final bool hasNotRequested = !_requestInfoMap.containsKey(post.postId);
//       final bool isAvailable = post.status == 'available';
//       return hasNotRequested && isAvailable;
//     }).toList();
//   }
//
//   // 🔹 requests ডাটা পোস্ট মডেলে সেট করার হেল্পার ফাংশন
//   PostModel _injectRequestData(PostModel p) {
//     final info = _requestInfoMap[p.postId];
//     if (info != null) {
//       p.status = info['status'] ?? p.status;
//       p.deliveryStatus = info['deliverystatus'] ?? 'pending';
//     }
//     return p;
//   }
//
//   void fetchAllPosts() {
//     final uid = _auth.currentUser?.uid;
//     if (uid == null) return;
//     _isLoading = true; notifyListeners();
//
//     _requestsSub?.cancel();
//     _requestsSub = _db.collection('requests').where('receiverId', isEqualTo: uid)
//         .snapshots().listen((snapshot) {
//       _requestInfoMap.clear();
//       for (var doc in snapshot.docs) {
//         final data = doc.data();
//         _requestInfoMap[data['postId']] = {
//           'requestId': doc.id,
//           'status': data['status'] ?? 'pending',
//           'deliverystatus': data['deliverystatus'] ?? 'pending',
//         };
//       }
//       notifyListeners();
//     });
//
//     _postsSub?.cancel();
//     _postsSub = _db.collection('posts').orderBy('createdAt', descending: true)
//         .snapshots().listen((snapshot) {
//       _allPosts = snapshot.docs.map((doc) => PostModel.fromSnapshot(doc)).toList();
//       _isLoading = false; notifyListeners();
//     });
//   }
//
//   Future<void> sendRequest(String postId, String donorId) async {
//     final uid = _auth.currentUser?.uid;
//     if (uid == null || _requestInfoMap.containsKey(postId)) return;
//     setRequesting(postId, true);
//     try {
//       WriteBatch batch = _db.batch();
//       DocumentReference reqRef = _db.collection('requests').doc();
//       batch.set(reqRef, {
//         "requestId": reqRef.id, "postId": postId, "donorId": donorId,
//         "receiverId": uid, "status": "pending", "deliverystatus": "pending",
//         "createdAt": FieldValue.serverTimestamp(),
//       });
//       batch.update(_db.collection('posts').doc(postId), {"requestedBy": FieldValue.arrayUnion([uid])});
//       await batch.commit();
//     } finally { setRequesting(postId, false); }
//   }
//
//   void setRequesting(String postId, bool v) { isRequesting[postId] = v; notifyListeners(); }
//
//   @override
//   void dispose() { _postsSub?.cancel(); _requestsSub?.cancel(); super.dispose(); }
// }


//
// import 'dart:async';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import '../../../../../../auth/data/model/post_model.dart';
//
// class ReceiverProvider extends ChangeNotifier {
//   final FirebaseFirestore _db = FirebaseFirestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   bool _isLoading = false;
//   bool get isLoading => _isLoading;
//
//   List<PostModel> _allPosts = [];
//   // request er createdAt rakhar jonno map update kora hoyeche
//   Map<String, Map<String, dynamic>> _requestInfoMap = {};
//   Map<String, bool> isRequesting = {};
//
//   StreamSubscription? _postsSub;
//   StreamSubscription? _requestsSub;
//
//   Set<String> get myRequestIds => _requestInfoMap.keys.toSet();
//
//   // --- ট্যাব ফিল্টারিং লজিক (Latest Request First) ---
//
//   List<PostModel> get pendingPosts {
//     final filtered = _allPosts
//         .where((p) => _requestInfoMap[p.postId]?['status'] == 'pending')
//         .map((p) => _injectRequestData(p)).toList();
//
//     // 🔥 Time Sorting: Newest request first
//     filtered.sort((a, b) => _compareDates(a.postId, b.postId));
//     return filtered;
//   }
//
//   List<PostModel> get approvedPosts {
//     final filtered = _allPosts
//         .where((p) {
//       final s = _requestInfoMap[p.postId]?['status'];
//       return s == 'approved' || s == 'delivered' || s == 'ongoing' || s == 'completed';
//     })
//         .map((p) => _injectRequestData(p)).toList();
//
//     filtered.sort((a, b) => _compareDates(a.postId, b.postId));
//     return filtered;
//   }
//
//   List<PostModel> get rejectedPosts {
//     final filtered = _allPosts
//         .where((p) => _requestInfoMap[p.postId]?['status'] == 'rejected')
//         .map((p) => _injectRequestData(p)).toList();
//
//     filtered.sort((a, b) => _compareDates(a.postId, b.postId));
//     return filtered;
//   }
//
//   // Sorting Helper: Request-er createdAt dhore sort kora
//   int _compareDates(String idA, String idB) {
//     final timeA = _requestInfoMap[idA]?['createdAt'] as Timestamp?;
//     final timeB = _requestInfoMap[idB]?['createdAt'] as Timestamp?;
//     if (timeA == null || timeB == null) return 0;
//     return timeB.compareTo(timeA); // Descending order
//   }
//
//   List<PostModel> get availablePostsForMe {
//     return _allPosts.where((post) {
//       final bool hasNotRequested = !_requestInfoMap.containsKey(post.postId);
//       final bool isAvailable = post.status == 'available';
//       return hasNotRequested && isAvailable;
//     }).toList();
//   }
//
//   PostModel _injectRequestData(PostModel p) {
//     final info = _requestInfoMap[p.postId];
//     if (info != null) {
//       p.status = info['status'] ?? p.status;
//       p.deliveryStatus = info['deliverystatus'] ?? 'pending';
//     }
//     return p;
//   }
//
//   void fetchAllPosts() {
//     final uid = _auth.currentUser?.uid;
//     if (uid == null) return;
//     _isLoading = true;
//     notifyListeners();
//
//     _requestsSub?.cancel();
//     _requestsSub = _db.collection('requests')
//         .where('receiverId', isEqualTo: uid)
//         .orderBy('createdAt', descending: true) // 🔥 Firestore sorting
//         .snapshots().listen((snapshot) {
//       _requestInfoMap.clear();
//       for (var doc in snapshot.docs) {
//         final data = doc.data();
//         _requestInfoMap[data['postId']] = {
//           'requestId': doc.id,
//           'status': data['status'] ?? 'pending',
//           'deliverystatus': data['deliverystatus'] ?? 'pending',
//           'createdAt': data['createdAt'], // Sorting-er jonno store kora
//         };
//       }
//       notifyListeners();
//     });
//
//     _postsSub?.cancel();
//     _postsSub = _db.collection('posts')
//         .orderBy('createdAt', descending: true)
//         .snapshots().listen((snapshot) {
//       _allPosts = snapshot.docs.map((doc) => PostModel.fromSnapshot(doc)).toList();
//       _isLoading = false;
//       notifyListeners();
//     });
//   }
//
//   Future<void> sendRequest(String postId, String donorId) async {
//     final uid = _auth.currentUser?.uid;
//     if (uid == null || _requestInfoMap.containsKey(postId)) return;
//     setRequesting(postId, true);
//     try {
//       WriteBatch batch = _db.batch();
//       DocumentReference reqRef = _db.collection('requests').doc();
//       batch.set(reqRef, {
//         "requestId": reqRef.id,
//         "postId": postId,
//         "donorId": donorId,
//         "receiverId": uid,
//         "status": "pending",
//         "deliverystatus": "pending",
//         "createdAt": FieldValue.serverTimestamp(),
//       });
//       batch.update(_db.collection('posts').doc(postId), {"requestedBy": FieldValue.arrayUnion([uid])});
//       await batch.commit();
//     } finally { setRequesting(postId, false); }
//   }
//
//   void setRequesting(String postId, bool v) { isRequesting[postId] = v; notifyListeners(); }
//
//   @override
//   void dispose() { _postsSub?.cancel(); _requestsSub?.cancel(); super.dispose(); }
// }



import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../../../auth/data/model/post_model.dart';

class ReceiverProvider extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<PostModel> _allPosts = [];
  // request info store korar map
  Map<String, Map<String, dynamic>> _requestInfoMap = {};
  Map<String, bool> isRequesting = {};

  StreamSubscription? _postsSub;
  StreamSubscription? _requestsSub;

  Set<String> get myRequestIds => _requestInfoMap.keys.toSet();

  // --- ট্যাব ফিল্টারিং লজিক (Latest Request First) ---

  // ১. Pending Requests
  List<PostModel> get pendingPosts {
    final filtered = _allPosts
        .where((p) => _requestInfoMap[p.postId]?['status'] == 'pending')
        .map((p) => _injectRequestData(p))
        .toList();

    filtered.sort((a, b) => _compareDates(a.postId, b.postId));
    return filtered;
  }

  // ২. Approved/Ongoing/Completed Requests
  List<PostModel> get approvedPosts {
    final filtered = _allPosts
        .where((p) {
      final s = _requestInfoMap[p.postId]?['status'];
      return s == 'approved' || s == 'delivered' || s == 'ongoing' || s == 'completed';
    })
        .map((p) => _injectRequestData(p))
        .toList();

    filtered.sort((a, b) => _compareDates(a.postId, b.postId));
    return filtered;
  }

  // ৩. Rejected Requests
  List<PostModel> get rejectedPosts {
    final filtered = _allPosts
        .where((p) => _requestInfoMap[p.postId]?['status'] == 'rejected')
        .map((p) => _injectRequestData(p))
        .toList();

    filtered.sort((a, b) => _compareDates(a.postId, b.postId));
    return filtered;
  }

  // ৪. Available for Request (Jegulo ami ekhono request korini)
  List<PostModel> get availablePostsForMe {
    return _allPosts.where((post) {
      final bool hasNotRequested = !_requestInfoMap.containsKey(post.postId);
      final bool isAvailable = post.status == 'available';
      return hasNotRequested && isAvailable;
    }).toList();
  }

  // Sorting Helper: Request-er createdAt dhore sort kora
  int _compareDates(String idA, String idB) {
    final timeA = _requestInfoMap[idA]?['createdAt'] as Timestamp?;
    final timeB = _requestInfoMap[idB]?['createdAt'] as Timestamp?;
    if (timeA == null) return 1;
    if (timeB == null) return -1;
    return timeB.compareTo(timeA); // Descending (Latest first)
  }

  // 🔥 PostModel-er copy toiri kore data inject kora jate original data change na hoy
  PostModel _injectRequestData(PostModel p) {
    final info = _requestInfoMap[p.postId];
    if (info != null) {
      // Ekhane PostModel.fromMap use kora hoyeche jate ekta independent object thake
      // Jodi tomar model-e toMap() thake tobe:
      // PostModel copy = PostModel.fromMap(p.toMap());

      p.status = info['status'] ?? p.status;
      p.deliveryStatus = info['deliverystatus'] ?? 'pending';
    }
    return p;
  }

  void fetchAllPosts() {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    _isLoading = true;
    notifyListeners();

    // requests listen kora
    _requestsSub?.cancel();
    _requestsSub = _db.collection('requests')
        .where('receiverId', isEqualTo: uid)
    // .orderBy('createdAt', descending: true) // Jodi composite index na thake eta error dite pare
        .snapshots().listen((snapshot) {
      _requestInfoMap.clear();
      for (var doc in snapshot.docs) {
        final data = doc.data();
        _requestInfoMap[data['postId']] = {
          'requestId': doc.id,
          'status': data['status'] ?? 'pending',
          'deliverystatus': data['deliverystatus'] ?? 'pending',
          'createdAt': data['createdAt'] ?? Timestamp.now(),
        };
      }
      notifyListeners();
    }, onError: (e) {
      debugPrint("Requests Fetch Error: $e");
    });

    // posts listen kora
    _postsSub?.cancel();
    _postsSub = _db.collection('posts')
        .orderBy('createdAt', descending: true)
        .snapshots().listen((snapshot) {
      _allPosts = snapshot.docs.map((doc) => PostModel.fromSnapshot(doc)).toList();
      _isLoading = false;
      notifyListeners();
    }, onError: (e) {
      _isLoading = false;
      notifyListeners();
      debugPrint("Posts Fetch Error: $e");
    });
  }

  Future<void> sendRequest(String postId, String donorId) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null || _requestInfoMap.containsKey(postId)) return;

    setRequesting(postId, true);
    try {
      WriteBatch batch = _db.batch();
      DocumentReference reqRef = _db.collection('requests').doc();

      batch.set(reqRef, {
        "requestId": reqRef.id,
        "postId": postId,
        "donorId": donorId,
        "receiverId": uid,
        "status": "pending",
        "deliverystatus": "pending",
        "createdAt": FieldValue.serverTimestamp(),
      });

      batch.update(_db.collection('posts').doc(postId), {
        "requestedBy": FieldValue.arrayUnion([uid])
      });

      await batch.commit();
    } catch (e) {
      debugPrint("Send Request Error: $e");
    } finally {
      setRequesting(postId, false);
    }
  }

  void setRequesting(String postId, bool v) {
    isRequesting[postId] = v;
    notifyListeners();
  }

  @override
  void dispose() {
    _postsSub?.cancel();
    _requestsSub?.cancel();
    super.dispose();
  }
}