class NGOModel {
  final String name;
  final String pickupTime;
  final String imageUrl;
  final String location;
  final String foodRequirement;

  const NGOModel({
    required this.name,
    required this.pickupTime,
    required this.imageUrl,
    required this.location,
    required this.foodRequirement,
  });

  factory NGOModel.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      return const NGOModel(
        name: '',
        pickupTime: '',
        imageUrl: '',
        location: '',
        foodRequirement: '',
      );
    }

    return NGOModel(
      name: map['name']?.toString() ?? '',
      pickupTime: map['pickupTime']?.toString() ?? '',
      imageUrl: map['imageUrl']?.toString() ?? '',
      location: map['location']?.toString() ?? '',
      foodRequirement: map['foodRequirement']?.toString() ?? '',
    );
  }
}
