import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_out_app/shared/cubit/cubit.dart';
import 'package:in_out_app/shared/cubit/states.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Padding(
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
                            onTap: () {
                              showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now())
                                  .then((value) {
                                cubit.setInTime(time: value?.format(context));
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
                                  .then((value) {
                                cubit.setOutTime(time: value?.format(context));
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
                  height: 50.0,
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
                        child: MaterialButton(
                          onPressed: () {
                            print(cubit.inTime.text);
                            print(cubit.outTime.text);
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
                      )
                    ],
                  ),
                  flex: 2,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
