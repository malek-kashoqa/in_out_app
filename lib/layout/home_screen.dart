import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_out_app/layout/archive_screen.dart';
import 'package:in_out_app/layout/confirm_screen.dart';
import 'package:in_out_app/shared/components/constants.dart';
import 'package:in_out_app/shared/cubit/cubit.dart';
import 'package:in_out_app/shared/cubit/states.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if (inConfirm != null && outConfirm != null)
            isConfirmButtonVisible = true;
        },
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          if (inConfirm != null && outConfirm != null)
            isConfirmButtonVisible = true;
          return Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(
                      start: 20.0, end: 20.0, top: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                'IN',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 40.0,
                                ),
                              ),
                              flex: 1,
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                child: TextFormField(
                                  onTap: () {
                                    showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now())
                                        .then((time) {
                                      cubit.setInTime(
                                          datetime: cubit.getDateTime(time));
                                    });
                                  },
                                  keyboardType: TextInputType.none,
                                  controller: cubit.inTime,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.0),
                                      ),
                                    ),
                                  ),
                                  style: TextStyle(
                                    fontSize: 40.0,
                                  ),
                                ),
                              ),
                              flex: 2,
                            ),
                          ],
                        ),
                        flex: 1,
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Out',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 40.0,
                                ),
                              ),
                              flex: 1,
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                child: TextFormField(
                                  keyboardType: TextInputType.none,
                                  onTap: () {
                                    showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now())
                                        .then((time) {
                                      cubit.setOutTime(
                                          datetime: cubit.getDateTime(time));
                                    });
                                  },
                                  controller: cubit.outTime,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.0),
                                      ),
                                    ),
                                  ),
                                  style: TextStyle(
                                    fontSize: 40.0,
                                  ),
                                ),
                              ),
                              flex: 2,
                            ),
                          ],
                        ),
                        flex: 1,
                      ),
                      SizedBox(
                        height: 35.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            shiftTimeText,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          // IconButton(
                          //   onPressed: () {
                          //     cubit.shiftTimeUpdate();
                          //     cubit.emit(AppRefreshShiftTimeState());
                          //   },
                          //   icon: Icon(Icons.refresh),
                          // ),
                        ],
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                MaterialButton(
                                  onPressed: () {
                                    cubit.setInTime();
                                  },
                                  child: Text(
                                    'Check In',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                  color: Colors.green,
                                ),
                                MaterialButton(
                                  onPressed: () {
                                    cubit.setOutTime();
                                  },
                                  child: Text(
                                    'Check Out',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                  color: Colors.red,
                                ),
                              ],
                            ),
                            Container(
                              width: double.infinity,
                              child: Visibility(
                                visible: isConfirmButtonVisible,
                                child: MaterialButton(
                                  onPressed: () {
                                    if (inConfirm != null &&
                                        outConfirm != null) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ConfirmScreen(
                                                  DateFormat(
                                                          'yyyy/MM/dd hh:mm a')
                                                      .format(inConfirm),
                                                  DateFormat(
                                                          'yyyy/MM/dd hh:mm a')
                                                      .format(outConfirm),
                                                  shiftTimeText)));
                                      cubit.emit(AppConfirmScreenState());
                                    }
                                  },
                                  child: Text(
                                    'Confirm',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                  color: Colors.blue,
                                ),
                              ),
                            )
                          ],
                        ),
                        flex: 2,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                color: Colors.grey,
                child: TextButton(
                  onPressed: () {
                    cubit.getDatabaseRecords();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ArchiveScreen()));
                  },
                  child: Text(
                    'Archive',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.zero),
                    minimumSize:
                        MaterialStateProperty.all(Size.fromHeight(50.0)),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
