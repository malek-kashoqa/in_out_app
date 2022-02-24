import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_out_app/shared/components/components.dart';
import 'package:in_out_app/shared/components/constants.dart';
import 'package:in_out_app/shared/cubit/cubit.dart';
import 'package:in_out_app/shared/cubit/states.dart';
import 'package:sqflite/sqflite.dart';

class ConfirmScreen extends StatelessWidget {
  String inTime;
  String outTime;
  String shiftTime;

  ConfirmScreen(this.inTime, this.outTime, this.shiftTime);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
          builder: (context, state) {
            AppCubit cubit = AppCubit.get(context);
            return Scaffold(
              appBar: AppBar(),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TimeWidget(
                      label: 'IN',
                      controller: TextEditingController(text: inTime),
                      textFontSize: 20.0,
                    ),
                    TimeWidget(
                      label: 'OUT',
                      controller: TextEditingController(text: outTime),
                      textFontSize: 20.0,
                    ),
                    SizedBox(
                      height: 35.0,
                    ),
                    Text(
                      shiftTime,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          DefaultButton(
                              onPressed: () {
                                cubit.confirmShift();
                              },
                              text: 'Yes',
                              color: Colors.green),
                          DefaultButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              text: 'No',
                              color: Colors.red)
                        ],
                      ),
                      flex: 2,
                    ),
                  ],
                ),
              ),
            );
          },
          listener: (context, state) {}),
    );
  }
}
