import 'package:equatable/equatable.dart';

class WalletResponseModel extends Equatable {
  final bool isSuccess;
  final int version;
  final String message;
  final DoctorWalletModel responseData;
  final dynamic errors;

  const WalletResponseModel({
    required this.isSuccess,
    required this.version,
    required this.message,
    required this.responseData,
    this.errors,
  });

  factory WalletResponseModel.fromJson(Map<String, dynamic> json) {
    return WalletResponseModel(
      isSuccess: json['isSuccess'],
      version: json['version'],
      message: json['message'],
      responseData: DoctorWalletModel.fromJson(json['responseData']),
      errors: json['errors'],
    );
  }

  @override
  List<Object?> get props => [
        isSuccess,
        version,
        message,
        responseData,
        errors,
      ];
}

class DoctorWalletModel extends Equatable {
  final int doctorId;
  final String doctorName;
  final double? currentBalance;
  final double? frozenBalance;
  final double? detectedBalance;
  final List<TransactionModel> transactions;

  const DoctorWalletModel({
    required this.doctorId,
    required this.doctorName,
    this.currentBalance,
    this.frozenBalance,
    this.detectedBalance,
    required this.transactions,
  });

  factory DoctorWalletModel.fromJson(Map<String, dynamic> json) {
    return DoctorWalletModel(
      doctorId: json['doctorId'],
      doctorName: json['doctorName'],
      currentBalance: (json['currentBalance'] as num?)?.toDouble(),
      frozenBalance: (json['frozenBalance'] as num?)?.toDouble(),
      detectedBalance: (json['detectedBalance'] as num?)?.toDouble(),
      transactions: (json['transactions'] as List)
          .map((e) => TransactionModel.fromJson(e))
          .toList(),
    );
  }

  @override
  List<Object?> get props => [
        doctorId,
        doctorName,
        currentBalance,
        frozenBalance,
        detectedBalance,
        transactions,
      ];
}

class TransactionModel extends Equatable {
  final DateTime date;
  final int type;
  final double amount;
  final String description;

  const TransactionModel({
    required this.date,
    required this.type,
    required this.amount,
    required this.description,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      date: DateTime.parse(json['date']),
      type: json['type'],
      amount: (json['amount'] as num).toDouble(),
      description: json['description'],
    );
  }

  @override
  List<Object?> get props => [
        date,
        type,
        amount,
        description,
      ];
}
