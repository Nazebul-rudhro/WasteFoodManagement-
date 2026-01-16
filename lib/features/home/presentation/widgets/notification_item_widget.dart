import 'package:flutter/material.dart';
import 'package:waste_food_management/app/app_theme.dart';

class NotificationItem extends StatefulWidget {
  final String id;
  final String message;
  final VoidCallback onApprove;
  final VoidCallback onReject;

  const NotificationItem({
    super.key,
    required this.id,
    required this.message,
    required this.onApprove,
    required this.onReject,
  });

  @override
  State<NotificationItem> createState() => _NotificationItemState();
}

class _NotificationItemState extends State<NotificationItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = _isExpanded
        ? Colors.green.withOpacity(0.1)
        : Colors.grey.shade200;

    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("ID: ${widget.id}", style: AppData.heading3),
            const SizedBox(height: 5),
            Text(widget.message, style: AppData.heading2),
            const SizedBox(height: 10),

            if (_isExpanded)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: widget.onReject,
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      backgroundColor: Colors.red.withOpacity(0.1),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                    ),
                    child: const Text(
                      "Reject",
                      style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ),

                  const SizedBox(width: 10),
                  TextButton(
                    onPressed: widget.onApprove,
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      backgroundColor: Colors.red.withOpacity(0.1),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                    ),
                    child: const Text("Approve",
                        style: TextStyle(color: Colors.green)),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
