import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_out_app/shared/cubit/states.dart';
import 'package:intl/intl.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);

  TextEditingController inTime = new TextEditingController();
  TextEditingController outTime = new TextEditingController();

  DateTime inDateTime = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0);
  DateTime outDateTime = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0);
  late DateTime inConfirm;
  late DateTime outConfirm;
  int shiftDuration = 0;
  String shiftTimeText = 'Shift time: 00:00 hours';

  void setInTime({
    DateTime? datetime,
  }) {
    if (datetime != null) {
      inDateTime = datetime;
      inConfirm = datetime;
      inTime.text = formatTime(datetime);
    } else {
      inConfirm = DateTime.now();
      inDateTime = DateTime.now();
      inTime.text = DateFormat('hh:mm a').format(inDateTime);
    }
    shiftTimeUpdate();
    emit(AppGetInTimeState());
  }

  void setOutTime({
    DateTime? datetime,
  }) {
    if (datetime != null) {
      outDateTime = datetime;
      outConfirm = datetime;
      outTime.text = formatTime(datetime);
    } else {
      outDateTime = DateTime.now();
      outConfirm = DateTime.now();
      outTime.text = DateFormat('hh:mm a').format(DateTime.now());
    }
    shiftTimeUpdate();
    emit(AppGetOutTimeState());
  }

  String formatTime(time) {
    var now = DateTime.now();
    return DateFormat('hh:mm a')
        .format(DateTime(now.year, now.month, now.day, time.hour, time.minute));
  }

  DateTime getDateTime(time) {
    var now = DateTime.now();
    return DateTime(now.year, now.month, now.day, time.hour, time.minute);
  }

  void shiftTimeUpdate() {
    shiftDuration = outDateTime.difference(inDateTime).inMinutes;
    if (shiftDuration > 0)
      shiftTimeText =
          'Shift time: ${Duration(minutes: shiftDuration).toString().split('.')[0].padLeft(8, '0').substring(0, 5)} hours';
  }
}
