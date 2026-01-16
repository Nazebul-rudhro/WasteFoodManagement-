import 'package:flutter/material.dart';

class CommunitySectionModel {
  final String id;
  final String timeAgo;
  final String title;
  final String quantity;
  final String status;
  final String image;
  final VoidCallback? onTap; // Individual action for each card

  CommunitySectionModel({
    required this.id,
    required this.timeAgo,
    required this.title,
    required this.quantity,
    required this.status,
    required this.image,
    this.onTap, // Optional callback
  });
}

