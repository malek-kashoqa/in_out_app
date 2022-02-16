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

  void setInTime({
    time,
  }) {
    if (time != null)
      inTime.text = time;
    else
      inTime.text = DateFormat('hh:mm a').format(DateTime.now());
    emit(AppGetInTimeState());
  }

  void setOutTime({
    time,
  }) {
    if (time != null)
      outTime.text = time;
    else
      outTime.text = DateFormat('hh:mm a').format(DateTime.now());
    emit(AppGetOutTimeState());
  }
}
