import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReceiverSearchScreen extends StatefulWidget {
  @override
  State<ReceiverSearchScreen> createState() => _ReceiverSearchScreenState();
}

class _ReceiverSearchScreenState extends State<ReceiverSearchScreen> {
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
