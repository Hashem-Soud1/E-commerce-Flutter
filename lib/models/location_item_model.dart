// ignore_for_file: public_member_api_docs, sort_constructors_first

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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'city': city,
      'country': country,
      'imgUrl': imgUrl,
      'isChoosen': isChoosen,
    };
  }

  factory LocationItemModel.fromMap(Map<String, dynamic> map) {
    return LocationItemModel(
      id: map['id'] as String,
      city: map['city'] as String,
      country: map['country'] as String,
      imgUrl: map['imgUrl'] as String,
      isChoosen: map['isChoosen'] as bool,
    );
  }
}
