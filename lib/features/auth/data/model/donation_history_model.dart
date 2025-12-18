class DonationHistoryModel {
  final String id;
  final String timeAgo;
  final String title;
  final String quantity;
  final String status;
  final String image;

  const DonationHistoryModel({
    required this.id,
    required this.timeAgo,
    required this.title,
    required this.quantity,
    required this.status,
    required this.image,
  });
}
