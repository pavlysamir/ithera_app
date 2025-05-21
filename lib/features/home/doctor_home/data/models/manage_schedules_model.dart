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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['doctorId'] = doctorId;
    data['startDate'] = startDate;
    data['regions'] = regions.map((v) => v.toJson()).toList();
    return data;
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['regionId'] = regionId;
    data['schedules'] = schedules.map((v) => v.toJson()).toList();
    return data;
  }
}

class SchedulesModel {
  int? day;
  String? startTime;
  String? endTime;

  SchedulesModel({
    this.day,
    this.startTime,
    this.endTime,
  });

  SchedulesModel.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    startTime = json['startTime'];
    endTime = json['endTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['day'] = day;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    return data;
  }
}
