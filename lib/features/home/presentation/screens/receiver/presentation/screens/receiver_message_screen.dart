import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReceiverMessageScreen extends StatefulWidget {
  @override
  State<ReceiverMessageScreen> createState() => _ReceiverMessageScreenState();
}

class _ReceiverMessageScreenState extends State<ReceiverMessageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text(
          "Coming Soon",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
