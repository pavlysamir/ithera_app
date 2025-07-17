part of 'setting_cubit.dart';

sealed class SettingState extends Equatable {
  const SettingState();

  @override
  List<Object> get props => [];
}

final class SettingInitial extends SettingState {}

final class DataWalletLoading extends SettingState {}

final class DataWalletLoaded extends SettingState {
  final WalletResponseModel walletData;

  const DataWalletLoaded(this.walletData);

  @override
  List<Object> get props => [walletData];
}

final class DataWalletError extends SettingState {
  final String error;

  const DataWalletError(this.error);

  @override
  List<Object> get props => [error];
}

final class SubmetDataWalletLoading extends SettingState {}

final class SubmetDataWalletLoaded extends SettingState {
  final String data;

  const SubmetDataWalletLoaded(this.data);

  @override
  List<Object> get props => [data];
}

final class SubmetDataWalletError extends SettingState {
  final String error;

  const SubmetDataWalletError(this.error);

  @override
  List<Object> get props => [error];
}

final class SuccessfulPickImage extends SettingState {}

final class FailPickImage extends SettingState {}
