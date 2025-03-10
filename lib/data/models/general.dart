class HotelCategoryModel {
  final String label;
  final String value;

  HotelCategoryModel({required this.label, required this.value});

  // Factory constructor to create a Category from a Map
  factory HotelCategoryModel.fromMap(Map<String, dynamic> map) {
    final attributes =
        map['attributes'] as Map<String, dynamic>?; // Safely cast to Map
    if (attributes == null) {
      throw ArgumentError('Invalid map: attributes key is missing');
    }
    return HotelCategoryModel(
      label: attributes['name'] ?? '', // Fallback to empty string if null
      value: attributes['id'] ?? '', // Fallback to empty string if null
    );
  }

  // Convert a Category object to a Map
  Map<String, String> toMap() {
    return {
      'label': label,
      'value': value,
    };
  }
}
