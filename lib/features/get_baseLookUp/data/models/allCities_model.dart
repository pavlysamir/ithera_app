import 'package:equatable/equatable.dart';

class CityModel extends Equatable {
  final String nameAr;
  final String nameEn;
  final String internalCode;
  final int internalRef;
  final bool isActive;
  final String description;
  final List<dynamic> patients;
  final List<dynamic> regions;
  final dynamic doctors;
  final int id;
  final bool isDeleted;
  final DateTime createdOn;
  final DateTime modifyOn;

  const CityModel({
    required this.nameAr,
    required this.nameEn,
    required this.internalCode,
    required this.internalRef,
    required this.isActive,
    required this.description,
    required this.patients,
    required this.regions,
    this.doctors,
    required this.id,
    required this.isDeleted,
    required this.createdOn,
    required this.modifyOn,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      nameAr: json['nameAr'] ?? '',
      nameEn: json['nameEn'] ?? '',
      internalCode: json['internalCode'] ?? '',
      internalRef: json['internalRef'] ?? 0,
      isActive: json['isActive'] ?? false,
      description: json['description'] ?? '',
      patients: List<dynamic>.from(json['patients'] ?? []),
      regions: List<dynamic>.from(json['regions'] ?? []),
      doctors: json['doctors'],
      id: json['id'] ?? 0,
      isDeleted: json['isDeleted'] ?? false,
      createdOn: DateTime.tryParse(json['createdOn'] ?? '') ?? DateTime.now(),
      modifyOn: DateTime.tryParse(json['modifyOn'] ?? '') ?? DateTime.now(),
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
      'patients': patients,
      'regions': regions,
      'doctors': doctors,
      'id': id,
      'isDeleted': isDeleted,
      'createdOn': createdOn.toIso8601String(),
      'modifyOn': modifyOn.toIso8601String(),
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
        patients,
        regions,
        doctors,
        id,
        isDeleted,
        createdOn,
        modifyOn,
      ];
}
