
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../../../services/cloudinary_service.dart';

class DonorProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final ImagePicker _picker = ImagePicker();

  bool isLoading = false;
  List<XFile> selectedImages = [];
  List<Map<String, dynamic>> receiverRequests = [];
  List<Map<String, dynamic>> approvedRequests = [];

  void fetchAllRequests() {
    final user = _auth.currentUser;
    if (user == null) return;

    // ১. রিসিভারের পেন্ডিং রিকোয়েস্ট
    _db.collection('requests')
        .where('donorId', isEqualTo: user.uid)
        .where('status', isEqualTo: 'pending')
        .snapshots().listen((snapshot) {
      receiverRequests = snapshot.docs.map((doc) => {"requestId": doc.id, ...doc.data()}).toList();
      notifyListeners();
    });

    // ২. অ্যাপ্রুভড এবং ডেলিভারি লিস্ট
    _db.collection('requests')
        .where('donorId', isEqualTo: user.uid)
        .where('status', whereIn: ['approved', 'delivered', 'ongoing'])
        .snapshots().listen((snapshot) {
      approvedRequests = snapshot.docs.map((doc) => {"requestId": doc.id, ...doc.data()}).toList();
      notifyListeners();
    });
  }

  // ✅ ডোনার যখন ভলান্টিয়ার অ্যাসাইন করবে (আপনার নতুন লজিক)
  Future<void> assignVolunteer(String requestId, String volunteerId, String volunteerName) async {
    try {
      await _db.collection('requests').doc(requestId).update({
        'volunteerId': volunteerId,
        'volunteerName': volunteerName,
        'status': 'delivered',        // ডোনারের কাজ শেষ
        'deliverystatus': 'pending',  // ভলান্টিয়ার এখনো পিকআপ করেনি
        'assignedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      debugPrint("Assign Volunteer Error: $e");
    }
  }

  Future<void> handleRequest(String requestId, String postId, String action) async {
    try {
      WriteBatch batch = _db.batch();
      DocumentReference reqRef = _db.collection('requests').doc(requestId);
      DocumentReference postRef = _db.collection('posts').doc(postId);

      if (action == 'approved') {
        batch.update(reqRef, {
          'status': 'approved',
          'deliverystatus': 'none',
          'approvedAt': FieldValue.serverTimestamp()
        });
        batch.update(postRef, {'status': 'claimed'});

        final others = await _db.collection('requests')
            .where('postId', isEqualTo: postId)
            .where('status', isEqualTo: 'pending').get();

        for (var doc in others.docs) {
          if (doc.id != requestId) batch.update(doc.reference, {'status': 'rejected'});
        }
      } else {
        batch.update(reqRef, {'status': 'rejected'});
      }
      await batch.commit();
    } catch (e) {
      debugPrint("Handle Request Error: $e");
    }
  }

  // --- Image & Post Methods ---
  Future<void> pickImages() async {
    try {
      final List<XFile>? images = await _picker.pickMultiImage(imageQuality: 70);
      if (images != null) { selectedImages.addAll(images); notifyListeners(); }
    } catch (e) { debugPrint(e.toString()); }
  }

  void removeImage(int index) {
    selectedImages.removeAt(index);
    notifyListeners();
  }

  Future<void> submitPost({
    required String foodName, required String foodType,
    required String foodCondition, required String estimatePersons,
    required String quantity, required String pickupTime,
    required String pickupAddress, required String description,
    required DateTime expiryDate,
  }) async {
    if (selectedImages.isEmpty) throw "Images required";
    isLoading = true; notifyListeners();
    try {
      final user = _auth.currentUser;
      final List<String> imageUrls = await CloudinaryService.uploadImages(selectedImages);
      final postRef = _db.collection('posts').doc();

      await postRef.set({
        'postId': postRef.id, 'donorId': user!.uid,
        'foodName': foodName, 'foodType': foodType,
        'foodCondition': foodCondition, 'estimatePersons': estimatePersons,
        'quantity': quantity, 'pickupTime': pickupTime,
        'expiryDate': Timestamp.fromDate(expiryDate), 'pickupAddress': pickupAddress,
        'description': description, 'imageUrls': imageUrls,
        'status': 'available', 'createdAt': FieldValue.serverTimestamp(),
      });
      selectedImages.clear();
    } finally { isLoading = false; notifyListeners(); }
  }
}