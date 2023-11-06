part of 'sms_bloc.dart';

sealed class SmsState extends Equatable {
  const SmsState();
  
  @override
  List<Object?> get props => [];
}

final class SmsLoading extends SmsState {}

final class SmsUpdate extends SmsState {
  final bool isNewSms;

  const SmsUpdate({
    required this.isNewSms
  });

  @override
  List<Object?> get props => [isNewSms];      
}

final class SmsFullLoaded extends SmsState {
  final List<SmsBody?> smsBodies;

  const SmsFullLoaded({
    required this.smsBodies
  });

  @override
  List<Object?> get props => [smsBodies];    
}

final class SmsError extends SmsState {
  final Object? error;

  const SmsError({
    required this.error
  });

  @override
  List<Object?> get props => [error];  
}