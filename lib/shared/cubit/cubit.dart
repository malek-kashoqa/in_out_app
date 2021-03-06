import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_out_app/layout/archive_screen.dart';
import 'package:in_out_app/layout/confirm_screen.dart';
import 'package:in_out_app/shared/components/constants.dart';
import 'package:in_out_app/shared/cubit/states.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);

  late Database database;
  late Database database2;
  TextEditingController inTime = new TextEditingController();
  TextEditingController outTime = new TextEditingController();
  DateTime inDateTime = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0);
  DateTime outDateTime = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0);

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
    updateDatabaseTemp();
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
    updateDatabaseTemp();
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

  void createDatabase() async {
    database = await openDatabase(
      'temp.db',
      version: 1,
      onCreate: (database, version) {
        print("DataBase Created");
        database
            .execute(
                'CREATE TABLE temp (id INTEGER PRIMARY KEY, inConfirmTemp TEXT, outConfirmTemp TEXT)')
            .then((value) {
          emit(AppCreateDatabaseState());
          print("Table created");
        }).catchError((error) {
          print("Error when creating the table: ${error.toString()}");
        });
      },
      onOpen: (database) async {
        print("DataBase - temp Opened");
        tempInOut = await database.rawQuery('SELECT * FROM temp');
        if (tempInOut.length == 0) {
          await database.transaction((txn) async {
            int id1 = await txn.rawInsert(
                'INSERT INTO temp(inConfirmTemp, outConfirmTemp) VALUES("null", "null")');
            print('inserted1 $id1');
          });
        }
        print(tempInOut);
        if (tempInOut[0]['inConfirmTemp'] != 'null') {
          DateTime datetime = DateTime.parse(tempInOut[0]['inConfirmTemp']);
          inDateTime = datetime;
          inConfirm = datetime;
          inTime.text = formatTime(datetime);
        }
        if (tempInOut[0]['outConfirmTemp'] != 'null') {
          DateTime datetime = DateTime.parse(tempInOut[0]['outConfirmTemp']);
          outDateTime = datetime;
          outConfirm = datetime;
          outTime.text = formatTime(datetime);
        }
        shiftTimeUpdate();
        emit(AppOpenDatabaseState());
      },
    );

    database2 = await openDatabase(
      'shifts.db',
      version: 1,
      onCreate: (database, version) {
        print("DataBase Created");
        database
            .execute(
                'CREATE TABLE shifts (id INTEGER PRIMARY KEY, timeIn TEXT, timeOut TEXT, shiftTime TEXT)')
            .then((value) {
          emit(AppCreateDatabaseState());
          print("Table created");
        }).catchError((error) {
          print("Error when creating the table: ${error.toString()}");
        });
      },
      onOpen: (database) async {
        print("DataBase - shifts Opened");
        shifts = await database.rawQuery('SELECT * FROM shifts');
        print(shifts);
        emit(AppOpenDatabaseState());
      },
    );
  }

  void insertDatabaseShift(
      String inTime, String outTime, String shiftTime) async {
    await database2.transaction((txn) async {
      int id1 = await txn.rawInsert(
          'INSERT INTO shifts(timeIn, timeOut, shiftTime) VALUES("$inTime", "$outTime", "$shiftTime")');
      print('inserted1 $id1');
    });
  }

  void getDatabaseRecords() async {
    emit(AppGetDatabaseLoadingState());
    tempInOut = await database.rawQuery('SELECT * FROM temp');
    database2.rawQuery('SELECT * FROM shifts').then((value) {
      shifts = [];
      value.forEach((element) {
        shifts.add(element);
      });
    });
    emit(AppUpdateDatabaseState());
    // shifts.forEach((element) {
    //   print(element);
    // });
  }

  void updateDatabaseTemp() async {
    int count = await database.rawUpdate(
        'UPDATE temp SET inConfirmTemp = ?, outConfirmTemp = ? WHERE id = ?',
        ['${inConfirm.toString()}', '${outConfirm.toString()}', 1]);
    print('updated: $count');
  }

  void deleteDatabase({required int id}) async {
    database2.rawUpdate(
      "DELETE FROM shifts WHERE id = ?",
      [id],
    ).then((value) {
      emit(AppDeleteDatabaseState());
      getDatabaseRecords();
    }).onError((error, stackTrace) {
      print('${error.toString()}');
    });
  }

  void confirmAction(context) {
    if (inConfirm != null && outConfirm != null) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ConfirmScreen(
                  DateFormat('yyyy/MM/dd hh:mm a').format(inConfirm),
                  DateFormat('yyyy/MM/dd hh:mm a').format(outConfirm),
                  shiftTimeText)));
      emit(AppConfirmScreenState());
    }
  }

  void archiveAction(context) {
    getDatabaseRecords();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ArchiveScreen()));
  }

  void confirmShift() {
    insertDatabaseShift(
        inConfirm.toString(), outConfirm.toString(), shiftTimeText);
  }
}
