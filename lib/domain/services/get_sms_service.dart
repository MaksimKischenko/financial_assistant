import 'dart:async';
import 'dart:developer';
import 'package:either_dart/either.dart';
import 'package:financial_assistant/failure.dart';
import 'package:permission_handler/permission_handler.dart';


import 'package:telephony/telephony.dart';

class GetSmsService {
  GetSmsService._();
  static final _instance = GetSmsService._();
  static GetSmsService get instance => _instance; 
  static const _bnb1 = 'BNB-Bank';
  static const _bnb2 = 'BNB-BANK';
  static final _telephony = Telephony.instance;
  static final _controller = StreamController<bool>.broadcast();
  Stream<bool> get myStream => _controller.stream;


  void closeStream() {
    _controller.close();
  }

  Future<void> requestSmsPermissions() async{
    await _telephony.requestSmsPermissions;
  }

  static Future<void> listenForIncomingSms() async {
    _telephony.listenIncomingSms(
      listenInBackground: false,
      onNewMessage: (message) async{
        if(message.address == _bnb1 || message.address == _bnb2) {
          await Future.delayed(const Duration(milliseconds: 200));
          _controller.sink.add(true);
        } else {
          _controller.sink.add(false);
        }
      },
    );
  }

  Future<Either<Failure, List<SmsMessage>>> getAllSmsStatistics() async {
    final status =  await Permission.sms.status;
    if(status.isGranted) {
      try {
        final messages = await _telephony.getInboxSms(
          columns: [SmsColumn.ADDRESS, SmsColumn.BODY, SmsColumn.DATE_SENT],
          filter: SmsFilter.where(SmsColumn.ADDRESS).equals(_bnb1).
          or(SmsColumn.ADDRESS).equals(_bnb2), 
          sortOrder: [OrderBy(SmsColumn.DATE_SENT, sort: Sort.DESC)]
        );
        return Right(messages);  
      } on Exception catch (e) {
        return Left(SimpleFailure(error: e));
      }
    } else {
      return const Right([]);
    }
  }

  Future<Either<Failure, List<SmsMessage>>> getSMSByFilters({
    required DateTime selectedDateFrom, 
    required DateTime selectedDateTo, 
  }) async {
    try {
     final firstPartMessages = await _telephony.getInboxSms(
        columns: [SmsColumn.ADDRESS,SmsColumn.DATE, SmsColumn.BODY],
        filter: SmsFilter.where(SmsColumn.ADDRESS).equals(_bnb2)
        .and(SmsColumn.DATE).greaterThanOrEqualTo(selectedDateFrom.millisecondsSinceEpoch.toString())
        .and(SmsColumn.DATE).lessThanOrEqualTo(selectedDateTo.millisecondsSinceEpoch.toString()), 
        sortOrder: [OrderBy(SmsColumn.DATE, sort: Sort.DESC),
          OrderBy(SmsColumn.BODY)]
     );

     final secondPartMessages = await _telephony.getInboxSms(
        columns: [SmsColumn.ADDRESS,SmsColumn.DATE, SmsColumn.BODY],
        filter: SmsFilter.where(SmsColumn.ADDRESS).equals(_bnb1)
        .and(SmsColumn.DATE).greaterThanOrEqualTo(selectedDateFrom.millisecondsSinceEpoch.toString())
        .and(SmsColumn.DATE).lessThanOrEqualTo(selectedDateTo.millisecondsSinceEpoch.toString()), 
        sortOrder: [OrderBy(SmsColumn.DATE, sort: Sort.DESC),
          OrderBy(SmsColumn.BODY)]
     );
      final messages = [...firstPartMessages, ...secondPartMessages]
      
     ..sort((a, b) => (a.dateSent ?? 0).compareTo(b.dateSent ?? 0));    
         log('MESS ${messages}'); 
      return Right(messages);  
    } on Exception catch(e) {
      return Left(SimpleFailure(error: e));  
    }
  }
}