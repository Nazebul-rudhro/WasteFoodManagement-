import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart'; // ফোন কল এবং ম্যাপের জন্য
import '../../../../../../../core/constants/app_colors.dart';
import '../../../../../../auth/provider/generic_auth_provider.dart';
import '../provider/volunteer_provider.dart';

class VolunteerTabSection extends StatefulWidget {
  final TabController tabController;
  const VolunteerTabSection({super.key, required this.tabController});

  @override
  State<VolunteerTabSection> createState() => _VolunteerTabSectionState();
}

class _VolunteerTabSectionState extends State<VolunteerTabSection> {
  String? _loadingRequestId;
  bool _isActionProcessing = false;

  // ফোন কল করার ফাংশন
  Future<void> _makeCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);

    }
  }

  // গুগল ম্যাপে লোকেশন দেখার ফাংশan
  Future<void> _openMap(String address) async {
    final query = Uri.encodeComponent(address);
    final googleMapsUrl = "https://www.google.com/maps/search/?api=1&query=$query";
    final uri = Uri.parse(googleMapsUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        TabBar(
          controller: widget.tabController,
          labelColor: AppColor.green,
          unselectedLabelColor: isDark ? Colors.white70 : Colors.black54,
          indicatorColor: AppColor.green,
          indicatorSize: TabBarIndicatorSize.label,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          dividerColor: Colors.transparent,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          tabs: const [
            Tab(text: "Available"),
            Tab(text: "Ongoing"),
            Tab(text: "Completed"),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: widget.tabController,
            children: [ _buildList(0), _buildList(1), _buildList(2) ],
          ),
        ),
      ],
    );
  }

  Widget _buildList(int tabIndex) {
    final vProvider = Provider.of<VolunteerProvider>(context);
    final authProvider = Provider.of<GenericAuthProvider>(context, listen: false);
    final String userUid = authProvider.user?.uid ?? "";
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return StreamBuilder<QuerySnapshot>(
      stream: tabIndex == 0 ? vProvider.getAvailableRequests() :
      tabIndex == 1 ? vProvider.getMyDeliveries(userUid) :
      vProvider.getCompletedDeliveries(userUid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(color: AppColor.green));
        }

        final docs = snapshot.data?.docs ?? [];
        if (docs.isEmpty) return _buildEmptyState(tabIndex, isDark);

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: docs.length,
          itemBuilder: (context, index) {
            final data = docs[index].data() as Map<String, dynamic>;
            final String reqId = docs[index].id;
            return _buildCard(data, reqId, tabIndex, vProvider, authProvider, isDark);
          },
        );
      },
    );
  }

  Widget _buildEmptyState(int index, bool isDark) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.layers_clear_outlined, size: 60, color: isDark ? Colors.white10 : Colors.grey[300]),
          const SizedBox(height: 10),
          Text("No requests found here", style: TextStyle(color: isDark ? Colors.white30 : Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildCard(Map<String, dynamic> data, String id, int tab, VolunteerProvider vp, GenericAuthProvider auth, bool isDark) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      elevation: 6,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          // উপরের সেকশন: খাবারের নাম এবং সময়
          _fetchFoodDetailsHeader(data['postId'] ?? "", isDark),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // ১. ডোনারের তথ্য (Pickup Point)
                _buildDeliveryStep(
                  context: context,
                  title: "PICKUP FROM (DONOR)",
                  uid: data['donorId'],
                  icon: Icons.storefront_rounded,
                  color: Colors.orange,
                  isDark: isDark,
                  postId: data['postId'],
                ),

                // কানেক্টিং লাইন
                _buildStepConnector(Colors.orange, AppColor.green),

                // ২. রিসিভারের তথ্য (Delivery Point)
                _buildDeliveryStep(
                  context: context,
                  title: "DELIVER TO (RECEIVER)",
                  uid: data['receiverId'],
                  icon: Icons.location_on_rounded,
                  color: AppColor.green,
                  isDark: isDark,
                ),

                const Divider(height: 30),

                // একশন বাটন (যদি কমপ্লিটেড ট্যাব না হয়)
                if (tab != 2) _buildBtn(tab, id, vp, auth, data),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryStep({
    required BuildContext context,
    required String title,
    required String uid,
    required IconData icon,
    required Color color,
    required bool isDark,
    String? postId,
  }) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('accounts').doc(uid).get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const LinearProgressIndicator();

        final userData = (snapshot.data?.data() as Map<String, dynamic>?)?['profile'] ?? {};
        final String name = userData['contactPerson'] ?? "Unknown";
        final String phone = userData['phone'] ?? "No Phone";

        // অ্যাড্রেস নির্ধারণ লজিক
        return FutureBuilder<DocumentSnapshot>(
          future: postId != null
              ? FirebaseFirestore.instance.collection('posts').doc(postId).get()
              : null,
          builder: (context, postSnap) {
            String address = "No Address Provided";
            if (postId != null && postSnap.hasData) {
              address = (postSnap.data?.data() as Map<String, dynamic>?)?['pickupAddress'] ?? address;
            } else {
              address = userData['address'] ?? address;
            }

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(backgroundColor: color.withOpacity(0.1), radius: 18, child: Icon(icon, color: color, size: 20)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey[600])),
                      Text(name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black87)),
                      const SizedBox(height: 4),
                      Text("📍 $address", style: TextStyle(fontSize: 13, color: isDark ? Colors.white70 : Colors.black54)),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          _contactActionButton(Icons.call, "Call", color, () => _makeCall(phone)),
                          const SizedBox(width: 10),
                          _contactActionButton(Icons.map, "Directions", color, () => _openMap(address)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _contactActionButton(IconData icon, String label, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
        child: Row(
          children: [
            Icon(icon, size: 14, color: color),
            const SizedBox(width: 4),
            Text(label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: color)),
          ],
        ),
      ),
    );
  }

  Widget _buildStepConnector(Color c1, Color c2) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(left: 17, top: 5, bottom: 5),
        height: 30, width: 2,
        decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [c1, c2])),
      ),
    );
  }

  Widget _fetchFoodDetailsHeader(String pid, bool isDark) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('posts').doc(pid).get(),
      builder: (context, snapshot) {
        final d = snapshot.data?.data() as Map<String, dynamic>? ?? {};
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: AppColor.green.withOpacity(0.1), borderRadius: const BorderRadius.vertical(top: Radius.circular(20))),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(d['foodName'] ?? "Loading...", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColor.green)),
                    Text("Quantity: ${d['quantity'] ?? 'N/A'}", style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text("PICKUP TIME", style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.grey)),
                  Text(d['pickupTime'] ?? "ASAP", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.orange)),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildBtn(int tab, String id, VolunteerProvider vp, GenericAuthProvider auth, Map<String, dynamic> data) {
    bool loading = _loadingRequestId == id && _isActionProcessing;
    String btnText = tab == 0 ? (data['status'] == 'delivered' ? "CONFIRM PICKUP" : "ACCEPT FOR DELIVERY") : "MARK AS COMPLETED";

    return SizedBox(
      width: double.infinity, height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: AppColor.green, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
        onPressed: loading ? null : () async {
          setState(() { _loadingRequestId = id; _isActionProcessing = true; });
          try {
            if (tab == 0) {
              if (data['status'] == 'delivered') {
                await vp.confirmPickup(id);
                widget.tabController.animateTo(1);
              } else {
                await vp.requestPickup(id, auth.user?.uid ?? "", auth.userData?['profile']?['contactPerson'] ?? "Volunteer");
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Request sent to Donor!")));
              }
            } else {
              await vp.completeDelivery(requestId: id, volunteerId: auth.user?.uid ?? "", donorId: data['donorId'] ?? "", receiverId: data['receiverId'] ?? "");
              widget.tabController.animateTo(2);
            }
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
          } finally {
            if (mounted) setState(() { _loadingRequestId = null; _isActionProcessing = false; });
          }
        },
        child: loading ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)) : Text(btnText, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}