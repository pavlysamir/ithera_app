class RegionModel {
  final String nameAr;
  final String nameEn;
  final String internalCode;
  final int internalRef;
  final String description;
  final int cityId;
  final dynamic city;
  final List<dynamic> doctorRegionPrices;
  final dynamic patient;
  final dynamic regionPrices;
  final int id;
  final bool isActive;
  final bool isDeleted;
  final DateTime createdOn;
  final DateTime modifyOn;

  RegionModel({
    required this.nameAr,
    required this.nameEn,
    required this.internalCode,
    required this.internalRef,
    required this.description,
    required this.cityId,
    this.city,
    required this.doctorRegionPrices,
    this.patient,
    this.regionPrices,
    required this.id,
    required this.isActive,
    required this.isDeleted,
    required this.createdOn,
    required this.modifyOn,
  });

  factory RegionModel.fromJson(Map<String, dynamic> json) {
    return RegionModel(
      nameAr: json['nameAr'],
      nameEn: json['nameEn'],
      internalCode: json['internalCode'],
      internalRef: json['internalRef'],
      description: json['description'],
      cityId: json['cityId'],
      city: json['city'],
      doctorRegionPrices: List<dynamic>.from(json['doctorRegionPrices']),
      patient: json['patient'],
      regionPrices: json['regionPrices'],
      id: json['id'],
      isActive: json['isActive'],
      isDeleted: json['isDeleted'],
      createdOn: DateTime.parse(json['createdOn']),
      modifyOn: DateTime.parse(json['modifyOn']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nameAr': nameAr,
      'nameEn': nameEn,
      'internalCode': internalCode,
      'internalRef': internalRef,
      'description': description,
      'cityId': cityId,
      'city': city,
      'doctorRegionPrices': doctorRegionPrices,
      'patient': patient,
      'regionPrices': regionPrices,
      'id': id,
      'isActive': isActive,
      'isDeleted': isDeleted,
      'createdOn': createdOn.toIso8601String(),
      'modifyOn': modifyOn.toIso8601String(),
    };
  }
}
