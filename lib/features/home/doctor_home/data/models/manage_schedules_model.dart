class ManageSchedulesModel {
  final int doctorId;
  final String startDate;
  final List<RegionsModel> regions;

  ManageSchedulesModel({
    required this.doctorId,
    required this.startDate,
    required this.regions,
  });

  factory ManageSchedulesModel.fromJson(Map<String, dynamic> json) {
    return ManageSchedulesModel(
      doctorId: json['doctorId'],
      startDate: json['startDate'],
      regions: List<RegionsModel>.from(
          json['regions'].map((x) => RegionsModel.fromJson(x))),
    );
  }
}

class RegionsModel {
  final int regionId;
  final List<SchedulesModel> schedules;

  RegionsModel({
    required this.regionId,
    required this.schedules,
  });

  factory RegionsModel.fromJson(Map<String, dynamic> json) {
    return RegionsModel(
      regionId: json['regionId'],
      schedules: List<SchedulesModel>.from(
          json['schedules'].map((x) => SchedulesModel.fromJson(x))),
    );
  }
}

class SchedulesModel {
  int? day;
  String? startTime;
  String? endTime;

  SchedulesModel.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    startTime = json['startTime'];
    endTime = json['endTime'];
  }
}
