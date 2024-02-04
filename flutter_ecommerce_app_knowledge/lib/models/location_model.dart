class LocationModel {
  final String id;
  final String cityName;
  final String countryName;
  final String imgUrl;
  final bool isSelected;

  const LocationModel(
      {
        required this.id,
        required this.cityName,
      required this.countryName,
      required this.imgUrl,
      this.isSelected = false,});

  LocationModel copyWith({
    String? id,
    String? cityName,
    String? countryName,
    String? imgUrl,
    bool? isSelected,
  }) {
    return LocationModel(
      id: id ?? this.id,
      cityName: cityName ?? this.cityName,
      countryName: countryName ?? this.countryName,
      imgUrl: imgUrl ?? this.imgUrl,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'id': id});
    result.addAll({'cityName': cityName});
    result.addAll({'countryName': countryName});
    result.addAll({'imgUrl': imgUrl});
    result.addAll({'isSelected': isSelected});
  
    return result;
  }

  factory LocationModel.fromMap(Map<String, dynamic> map, String documentId) {
    return LocationModel(
      id: documentId,
      cityName: map['cityName'] ?? '',
      countryName: map['countryName'] ?? '',
      imgUrl: map['imgUrl'] ?? '',
      isSelected: map['isSelected'] ?? false,
    );
  }
}
