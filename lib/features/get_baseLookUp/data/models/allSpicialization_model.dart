class SpecializationModel {
  final String nameAr;
  final String nameEn;
  final String internalCode;
  final int internalRef;
  final bool isActive;
  final String description;
  final List<dynamic> userSpecializationField;
  final int id;
  final bool isDeleted;

  SpecializationModel({
    required this.nameAr,
    required this.nameEn,
    required this.internalCode,
    required this.internalRef,
    required this.isActive,
    required this.description,
    required this.userSpecializationField,
    required this.id,
    required this.isDeleted,
  });

  factory SpecializationModel.fromJson(Map<String, dynamic> json) {
    return SpecializationModel(
      nameAr: json['nameAr'],
      nameEn: json['nameEn'],
      internalCode: json['internalCode'],
      internalRef: json['internalRef'],
      isActive: json['isActive'],
      description: json['description'],
      userSpecializationField:
          List<dynamic>.from(json['userSpecializationField']),
      id: json['id'],
      isDeleted: json['isDeleted'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nameAr': nameAr,
      'nameEn': nameEn,
      'internalCode': internalCode,
      'internalRef': internalRef,
      'isActive': isActive,
      'description': description,
      'userSpecializationField': userSpecializationField,
      'id': id,
      'isDeleted': isDeleted,
    };
  }
}
