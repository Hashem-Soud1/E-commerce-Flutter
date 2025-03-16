class LocationItemModel {
  final String id;
  final String city;
  final String country;
  final String imgUrl;
  final bool isChoosen;

  LocationItemModel({
    required this.id,
    required this.city,
    required this.country,
    this.imgUrl =
        'https://previews.123rf.com/images/emojoez/emojoez1903/emojoez190300018/119684277-illustrations-design-concept-location-maps-with-road-follow-route-for-destination-drive-by-gps.jpg',
    this.isChoosen = false,
  });

  LocationItemModel copyWith({
    String? id,
    String? city,
    String? country,
    String? imgUrl,
    bool? isChoosen,
  }) {
    return LocationItemModel(
      id: id ?? this.id,
      city: city ?? this.city,
      country: country ?? this.country,
      imgUrl: imgUrl ?? this.imgUrl,
      isChoosen: isChoosen ?? this.isChoosen,
    );
  }
}

List<LocationItemModel> dummyLocations = [
  LocationItemModel(id: '1', city: 'Cairo', country: 'Egypt'),
  LocationItemModel(id: '2', city: 'Gaza', country: 'Palestine'),
  LocationItemModel(id: '3', city: 'Dubai', country: 'UAE'),
];
