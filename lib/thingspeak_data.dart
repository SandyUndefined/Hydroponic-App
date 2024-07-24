class ThingSpeakData {
  final String createdAt;
  final double field1;

  ThingSpeakData({required this.createdAt, required this.field1});

  factory ThingSpeakData.fromJson(Map<String, dynamic> json) {
    return ThingSpeakData(
      createdAt: json['created_at'],
      field1: double.parse(json['field1']),
    );
  }
}
