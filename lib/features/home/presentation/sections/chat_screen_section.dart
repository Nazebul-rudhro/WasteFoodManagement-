// // import 'package:flutter/material.dart';
// // import 'package:firebase_database/firebase_database.dart';
// //
// // class ChatScreen extends StatefulWidget {
// //   const ChatScreen({super.key});
// //
// //   @override
// //   State<ChatScreen> createState() => _ChatScreenState();
// // }
// //
// // class _ChatScreenState extends State<ChatScreen> {
// //   final DatabaseReference _chatRef =
// //   FirebaseDatabase.instance.ref().child('chats');
// //
// //   final TextEditingController _controller = TextEditingController();
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Column(
// //       children: [
// //         // Chat Messages
// //         Expanded(
// //           child: StreamBuilder(
// //             stream: _chatRef.onValue,
// //             builder: (context, snapshot) {
// //               if (!snapshot.hasData || snapshot.data == null) {
// //                 return const Center(child: CircularProgressIndicator());
// //               }
// //
// //               final chatMap = (snapshot.data!).snapshot.value
// //               as Map<dynamic, dynamic>?;
// //
// //               if (chatMap == null) {
// //                 return const Center(child: Text("No messages"));
// //               }
// //
// //               final messages = chatMap.entries.toList();
// //
// //               return ListView.builder(
// //                 reverse: true,
// //                 itemCount: messages.length,
// //                 itemBuilder: (context, index) {
// //                   final message =
// //                       messages[messages.length - 1 - index].value;
// //                   return ListTile(
// //                     title: Text(message['text']),
// //                     subtitle: Text(message['sender'] ?? 'Anonymous'),
// //                   );
// //                 },
// //               );
// //
// //             },
// //           ),
// //         ),
// //         // Input Field
// //         Padding(
// //           padding: const EdgeInsets.all(8.0),
// //           child: Row(
// //             children: [
// //               Expanded(
// //                 child: TextField(
// //                   controller: _controller,
// //                   decoration: const InputDecoration(
// //                       hintText: 'Type your message',
// //                       border: OutlineInputBorder()),
// //                 ),
// //               ),
// //               IconButton(
// //                 icon: const Icon(Icons.send),
// //                 onPressed: () {
// //                   if (_controller.text.isEmpty) return;
// //
// //                   _chatRef.push().set({
// //                     'text': _controller.text,
// //                     'sender': 'User', // user id / name দিতে পারো
// //                     'time': DateTime.now().toIso8601String(),
// //                   });
// //
// //                   _controller.clear();
// //                 },
// //               ),
// //             ],
// //           ),
// //         ),
// //         SizedBox(height: 100,),
// //       ],
// //     );
// //   }
// // }
// //
//
//
//
//
//
// import 'package:flutter/material.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:waste_food_management/core/constants/app_colors.dart'; // আপনার AppColor ব্যবহার করার জন্য
//
// class ChatScreen extends StatefulWidget {
//   const ChatScreen({super.key});
//
//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }
//
// class _ChatScreenState extends State<ChatScreen> {
//   // Firebase Reference
//   final DatabaseReference _chatRef = FirebaseDatabase.instance.ref().child('chats');
//   final TextEditingController _controller = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         // 🔹 Chat Messages Section
//         Expanded(
//           child: StreamBuilder(
//             stream: _chatRef.onValue,
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(child: CircularProgressIndicator(color: AppColor.green));
//               }
//
//               if (!snapshot.hasData || snapshot.data?.snapshot.value == null) {
//                 return const Center(child: Text("No messages yet", style: TextStyle(color: Colors.grey)));
//               }
//
//               // Firebase ডাটা ম্যাপে কনভার্ট করা
//               final Map<dynamic, dynamic> chatMap =
//               Map<dynamic, dynamic>.from(snapshot.data!.snapshot.value as Map);
//
//               // ডাটা লিস্টে নেওয়া এবং সময় অনুযায়ী সর্ট করা
//               final messages = chatMap.entries.toList();
//               messages.sort((a, b) => a.value['time'].compareTo(b.value['time']));
//
//               // Reverse List (নিচ থেকে উপরে ওঠার জন্য)
//               final displayMessages = messages.reversed.toList();
//
//               return ListView.builder(
//                 reverse: true, // মেসেজ নিচ থেকে উপরে উঠবে
//                 padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                 itemCount: displayMessages.length,
//                 itemBuilder: (context, index) {
//                   final message = displayMessages[index].value;
//                   return ListTile(
//                     contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
//                     title: Text(
//                       message['text'] ?? '',
//                       style: const TextStyle(fontWeight: FontWeight.w500),
//                     ),
//                     subtitle: Text(
//                       message['sender'] ?? 'Anonymous',
//                       style: TextStyle(fontSize: 12, color: Colors.grey[600]),
//                     ),
//                   );
//                 },
//               );
//             },
//           ),
//         ),
//
//         // 🔹 Input Field Section
//         Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: Row(
//             children: [
//               Expanded(
//                 child: TextField(
//                   controller: _controller,
//                   decoration: InputDecoration(
//                     hintText: 'Type your message...',
//                     // ফোকাস না থাকা অবস্থায় বর্ডার কালার (Green)
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: const BorderSide(color: AppColor.green, width: 1.5),
//                     ),
//                     // ফোকাস থাকা অবস্থায় বর্ডার কালার (Green)
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: const BorderSide(color: AppColor.green, width: 2.0),
//                     ),
//                     contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 8),
//
//               // 🔹 Professional Send Button
//               CircleAvatar(
//                 backgroundColor: AppColor.green,
//                 radius: 25,
//                 child: IconButton(
//                   icon: const Icon(Icons.send, color: Colors.white),
//                   onPressed: () {
//                     final text = _controller.text.trim();
//                     if (text.isEmpty) return;
//
//                     _chatRef.push().set({
//                       'text': text,
//                       'sender': 'User', // এখানে আপনার Auth User Name দিতে পারেন
//                       'time': DateTime.now().toIso8601String(),
//                     });
//
//                     _controller.clear();
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//         // আপনার দেওয়া অতিরিক্ত স্পেস
//         const SizedBox(height: 100),
//       ],
//     );
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
// }


import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:waste_food_management/core/constants/app_colors.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final DatabaseReference _chatRef = FirebaseDatabase.instance.ref().child('chats');
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // ডাইনামিক প্যাডিং পাওয়ার জন্য MediaQuery ব্যবহার করা হয়েছে
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea( // এটি স্ট্যাটাস বার এবং বটম বার থেকে ডাইনামিক স্পেস দিবে
        child: Column(
          children: [
            // 🔹 Chat Messages
            Expanded(
              child: StreamBuilder(
                stream: _chatRef.onValue,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator(color: AppColor.green));
                  }

                  if (!snapshot.hasData || snapshot.data?.snapshot.value == null) {
                    return const Center(child: Text("No messages yet", style: TextStyle(color: Colors.grey)));
                  }

                  final Map<dynamic, dynamic> chatMap =
                  Map<dynamic, dynamic>.from(snapshot.data!.snapshot.value as Map);

                  final messages = chatMap.entries.toList();
                  messages.sort((a, b) => a.value['time'].compareTo(b.value['time']));
                  final displayMessages = messages.reversed.toList();

                  return ListView.builder(
                    reverse: true,
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    itemCount: displayMessages.length,
                    itemBuilder: (context, index) {
                      final message = displayMessages[index].value;
                      return ListTile(
                        title: Text(message['text'] ?? ''),
                        subtitle: Text(message['sender'] ?? 'Anonymous'),
                      );
                    },
                  );
                },
              ),
            ),

            // 🔹 Input Field with Dynamic Padding
            Container(
              padding: EdgeInsets.only(
                  left: 12,
                  right: 12,
                  top: 8,
                  bottom: bottomPadding > 0 ? 8 : 20 // কিবোর্ড থাকলে ৮, না থাকলে ২০ ডাইনামিক প্যাডিং
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Type your message...',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8), // গোল বর্ডার প্রফেশনাল দেখায়
                          borderSide: const BorderSide(color: AppColor.green, width: 1.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: const BorderSide(color: AppColor.green, width: 2.0),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      final text = _controller.text.trim();
                      if (text.isEmpty) return;
                      _chatRef.push().set({
                        'text': text,
                        'sender': 'User',
                        'time': DateTime.now().toIso8601String(),
                      });
                      _controller.clear();
                    },
                    child: const CircleAvatar(
                      backgroundColor: AppColor.green,
                      radius: 22,
                      child: Icon(Icons.send, color: Colors.white, size: 20),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}