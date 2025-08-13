import 'package:equatable/equatable.dart';

class ManageSchedulesModel extends Equatable {
  final int doctorId;
  final String startDate;
  final List<RegionsModel> regions;

  const ManageSchedulesModel({
    required this.doctorId,
    required this.startDate,
    required this.regions,
  });

  factory ManageSchedulesModel.fromJson(Map<String, dynamic> json) {
    return ManageSchedulesModel(
      doctorId: json['doctorId'],
      startDate: json['startDate'],
      regions: List<RegionsModel>.from(
        json['regions'].map((x) => RegionsModel.fromJson(x)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'doctorId': doctorId,
      'startDate': startDate,
      'regions': regions.map((v) => v.toJson()).toList(),
    };
  }

  @override
  List<Object> get props => [doctorId, startDate, regions];
}

class RegionsModel extends Equatable {
  final int regionId;
  final List<int> days;
  final List<SchedulesModel> schedules;

  const RegionsModel({
    required this.regionId,
    required this.days,
    required this.schedules,
  });

  factory RegionsModel.fromJson(Map<String, dynamic> json) {
    return RegionsModel(
      regionId: json['regionId'],
      days: List<int>.from(json['days']),
      schedules: List<SchedulesModel>.from(
        json['schedules'].map((x) => SchedulesModel.fromJson(x)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'regionId': regionId,
      'days': days,
      'schedules': schedules.map((v) => v.toJson()).toList(),
    };
  }

  @override
  List<Object> get props => [regionId, days, schedules];
}

class SchedulesModel extends Equatable {
  final String? startTime;
  final String? endTime;

  const SchedulesModel({
    this.startTime,
    this.endTime,
  });

  factory SchedulesModel.fromJson(Map<String, dynamic> json) {
    return SchedulesModel(
      startTime: json['startTime'],
      endTime: json['endTime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'startTime': startTime,
      'endTime': endTime,
    };
  }

  @override
  List<Object?> get props => [startTime, endTime];
}
