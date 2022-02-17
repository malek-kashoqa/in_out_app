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

  late DateTime inDateTime;
  late DateTime outDateTime;

  void setInTime({
    DateTime? datetime,
  }) {
    if (datetime != null) {
      inDateTime = datetime;
      inTime.text = formatTime(datetime);
    } else {
      inDateTime = DateTime.now();
      inTime.text = DateFormat('hh:mm a').format(inDateTime);
    }
    emit(AppGetInTimeState());
  }

  void setOutTime({
    DateTime? datetime,
  }) {
    if (datetime != null) {
      outDateTime = datetime;
      outTime.text = formatTime(datetime);
    } else {
      outDateTime = DateTime.now();
      outTime.text = DateFormat('hh:mm a').format(DateTime.now());
    }
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

  String formatTimeDiff(int minutes) {
    return '${(Duration(minutes: minutes))}'.split('.')[0].padLeft(8, '0');
  }
}
