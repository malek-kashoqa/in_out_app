import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_out_app/layout/archive_screen.dart';
import 'package:in_out_app/layout/confirm_screen.dart';
import 'package:in_out_app/shared/components/components.dart';
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
        listener: (context, state) {},
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
                      TimeWidget(
                          label: 'IN',
                          controller: cubit.inTime,
                          onTap: () {
                            showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now())
                                .then((time) {
                              cubit.setInTime(
                                  datetime: cubit.getDateTime(time));
                            });
                          }),
                      TimeWidget(
                          label: 'OUT',
                          controller: cubit.outTime,
                          onTap: () {
                            showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now())
                                .then((time) {
                              cubit.setOutTime(
                                  datetime: cubit.getDateTime(time));
                            });
                          }),
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
                                DefaultButton(
                                    onPressed: cubit.setInTime,
                                    text: 'Check In',
                                    color: Colors.green),
                                DefaultButton(
                                    onPressed: cubit.setOutTime,
                                    text: 'Check Out',
                                    color: Colors.red)
                              ],
                            ),
                            Container(
                                width: double.infinity,
                                child: Visibility(
                                  visible: isConfirmButtonVisible,
                                  child: DefaultButton(
                                    onPressed: () {
                                      cubit.confirmAction(context);
                                    },
                                    text: 'Confirm',
                                    color: Colors.blue,
                                    textColor: Colors.white,
                                  ),
                                ))
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
                height: 50.0,
                color: Colors.grey,
                child: DefaultButton(
                    onPressed: () {
                      cubit.archiveAction(context);
                    },
                    text: 'Archive',
                    color: Colors.grey,
                    textColor: Colors.white),
              ),
            ],
          );
        },
      ),
    );
  }
}
