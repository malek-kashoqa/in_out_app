import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                                keyboardType: TextInputType.none,
                                controller: TextEditingController(text: inTime),
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                  ),
                                ),
                                style: TextStyle(
                                  fontSize: 20.0,
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
                                controller:
                                    TextEditingController(text: outTime),
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                  ),
                                ),
                                style: TextStyle(
                                  fontSize: 20.0,
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
                          shiftTime,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
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
                                  cubit.insertDatabaseShift(
                                      inConfirm.toString(),
                                      outConfirm.toString(),
                                      shiftTime);
                                },
                                child: Text(
                                  'Yes',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 20.0,
                                  ),
                                ),
                                color: Colors.green,
                              ),
                              MaterialButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'No',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 20.0,
                                  ),
                                ),
                                color: Colors.red,
                              ),
                            ],
                          ),
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
