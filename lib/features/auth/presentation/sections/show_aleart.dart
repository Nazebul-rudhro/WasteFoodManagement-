import 'package:flutter/material.dart';

class ShowAlertMessage {
  final BuildContext context;
  final String title;
  final String boldText;
  final String message;
  final bool isSuccess;

  ShowAlertMessage({
    required this.context,
    required this.title,
    required this.boldText,
    required this.message,
    this.isSuccess = true,
  }) {
    _show();
  }

  void _show() {
    Future.microtask(() {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (dialogContext) {
          // MediaQuery ব্যবহার করে স্ক্রিনের সাইজ নেওয়া
          final size = MediaQuery.of(dialogContext).size;
          final bool isLandscape = MediaQuery.of(dialogContext).orientation == Orientation.landscape;

          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              // ল্যান্ডস্কেপ মোডে ডায়ালগ যেন পুরো স্ক্রিন জুড়ে না যায় তার জন্য উইডথ কন্ট্রোল
              width: isLandscape ? size.width * 0.5 : size.width * 0.85,
              child: SingleChildScrollView( // 🔹 ডাইনামিক করার জন্য যাতে কন্টেন্ট না কাটে
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min, // 🔹 কন্টেন্ট অনুযায়ী হাইট নিবে
                    children: [
                      // আইকন
                      Icon(
                        isSuccess ? Icons.check_circle : Icons.error,
                        size: isLandscape ? 50 : 70, // রোটেশন অনুযায়ী সাইজ পরিবর্তন
                        color: isSuccess ? Colors.green : Colors.red,
                      ),
                      const SizedBox(height: 12),

                      // টাইটেল
                      Text(
                        title,
                        style: TextStyle(
                          color: isSuccess ? Colors.green : Colors.red,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // বোল্ড মেইন টেক্সট
                      Text(
                        boldText,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: isLandscape ? 18 : 22,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF2D3132),
                        ),
                      ),
                      const SizedBox(height: 10),

                      // ছোট মেসেজ টেক্সট
                      Text(
                        message,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 28),

                      // কন্টিনিউ বাটন
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isSuccess ? Colors.green : Colors.red,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(dialogContext).pop();
                          },
                          child: const Text(
                            "Continue",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    });
  }
}