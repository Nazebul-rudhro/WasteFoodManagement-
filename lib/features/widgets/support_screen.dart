import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:waste_food_management/features/widgets/support_card.dart';
import '../../../../app/app_theme.dart';
import '../../core/constants/app_colors.dart';

class SupportScreen extends StatelessWidget {
  static const String routeName = '/support-screen';

  const SupportScreen({super.key});

  // 1. WhatsApp Function (Universal Link Fix)
  Future<void> _openWhatsApp() async {
    const String phone = "8801580339094";
    const String message = "Hello, I need some help regarding Waste Food Management App.";
    final Uri uri = Uri.parse("https://wa.me/$phone?text=${Uri.encodeComponent(message)}");

    // externalApplication dile WhatsApp app open hobe, na thakle browser e jabe
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      debugPrint("WhatsApp open korte somossa hoyeche: $e");
    }
  }

  // 2. Call Function (Dialer open hobe)
  Future<void> _makeCall() async {
    final Uri uri = Uri(scheme: 'tel', path: '01580339094');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      debugPrint("Dialer open kora jachhe na");
    }
  }

  // 3. Email Function (Gmail/Email app open hobe)
  Future<void> _sendEmail() async {
    final Uri uri = Uri(
      scheme: 'mailto',
      path: 'haque-ia18@dipti.com.bd',
      query: 'subject=Support Request&body=Hi Team,',
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      debugPrint("Email app khuje paoya jachhe na");
    }
  }

  // FAQ Alert Dialog
  void _showFaqDialog(BuildContext context, String question, String answer) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(question, style: AppData.heading2.copyWith(color: AppColor.green)),
        content: Text(answer, style: AppData.heading3),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close", style: TextStyle(color: AppColor.green, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("Help & Support"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Icon(Icons.support_agent_rounded, size: 80, color: AppColor.green),
            const SizedBox(height: 10),
            Text("How can we help you?", style: AppData.heading1.copyWith(fontSize: 22)),
            const SizedBox(height: 25),

            // WhatsApp Support
            SupportCard(
              title: "WhatsApp Support",
              subtitle: "Chat with us on WhatsApp",
              icon: Icons.chat_bubble_outline_rounded,
              iconColor: Colors.green,
              onTap: _openWhatsApp,
            ),
            const SizedBox(height: 12),

            // Call Support (Dialer open hobe)
            SupportCard(
              title: "Call Us",
              subtitle: "01580339094",
              icon: Icons.phone_in_talk_outlined,
              iconColor: AppColor.primary,
              onTap: _makeCall,
            ),
            const SizedBox(height: 12),

            // Email Support
            SupportCard(
              title: "Email Support",
              subtitle: "haque-ia18@dipti.com.bd",
              icon: Icons.mail_outline_rounded,
              iconColor: Colors.orange,
              onTap: _sendEmail,
            ),

            const SizedBox(height: 35),
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Common Questions", style: AppData.heading2),
            ),
            const Divider(),

            // FAQ List
            _buildFaqTile(context, "How to donate food?", "Go to the home screen and click on 'Donate Food'. Fill the details and confirm your post."),
            _buildFaqTile(context, "Is my data safe?", "Yes, we use secure encryption and Firestore rules to protect your personal data."),
            _buildFaqTile(context, "Can I cancel a request?", "You can cancel any request from the 'My Posts' section before a volunteer accepts it."),
            _buildFaqTile(context, "How to earn points?", "You earn points by successfully donating food and receiving positive feedback from receivers."),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildFaqTile(BuildContext context, String question, String answer) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(question, style: AppData.heading3.copyWith(fontWeight: FontWeight.w500)),
      trailing: const Icon(Icons.add_circle_outline, color: AppColor.green, size: 20),
      onTap: () => _showFaqDialog(context, question, answer),
    );
  }
}