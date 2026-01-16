import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final DatabaseReference _chatRef =
  FirebaseDatabase.instance.ref().child('chats');

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Chat Messages
        Expanded(
          child: StreamBuilder(
            stream: _chatRef.onValue,
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              }

              final chatMap = (snapshot.data!).snapshot.value
              as Map<dynamic, dynamic>?;

              if (chatMap == null) {
                return const Center(child: Text("No messages"));
              }

              final messages = chatMap.entries.toList();

              return ListView.builder(
                reverse: true,
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message =
                      messages[messages.length - 1 - index].value;
                  return ListTile(
                    title: Text(message['text']),
                    subtitle: Text(message['sender'] ?? 'Anonymous'),
                  );
                },
              );
            },
          ),
        ),
        // Input Field
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                      hintText: 'Type your message',
                      border: OutlineInputBorder()),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {
                  if (_controller.text.isEmpty) return;

                  _chatRef.push().set({
                    'text': _controller.text,
                    'sender': 'User', // user id / name দিতে পারো
                    'time': DateTime.now().toIso8601String(),
                  });

                  _controller.clear();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

