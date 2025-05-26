import 'package:equatable/equatable.dart';

class SpecializationModel extends Equatable {
  final String nameAr;
  final String nameEn;
  final String internalCode;
  final int internalRef;
  final bool isActive;
  final String description;
  final List<dynamic> userSpecializationField;
  final int id;
  final bool isDeleted;

  const SpecializationModel({
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
      nameAr: json['nameAr'] ?? '',
      nameEn: json['nameEn'] ?? '',
      internalCode: json['internalCode'] ?? '',
      internalRef: json['internalRef'] ?? 0,
      isActive: json['isActive'] ?? false,
      description: json['description'] ?? '',
      userSpecializationField:
          List<dynamic>.from(json['userSpecializationField'] ?? []),
      id: json['id'] ?? 0,
      isDeleted: json['isDeleted'] ?? false,
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

  @override
  List<Object?> get props => [
        nameAr,
        nameEn,
        internalCode,
        internalRef,
        isActive,
        description,
        userSpecializationField,
        id,
        isDeleted,
      ];
}
