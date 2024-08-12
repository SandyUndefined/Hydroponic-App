class Plant {
  final String name;
  final String imagePath;
  final String optimalConditions;
  final Map<String, String> additionalData;

  Plant({
    required this.name,
    required this.imagePath,
    required this.optimalConditions,
    required this.additionalData,
  });
}
