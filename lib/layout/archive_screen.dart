import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_out_app/shared/components/constants.dart';
import 'package:in_out_app/shared/cubit/cubit.dart';
import 'package:in_out_app/shared/cubit/states.dart';
import 'package:intl/intl.dart';

import '../shared/components/components.dart';

class ArchiveScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AppCubit()..createDatabase(),
        child: BlocConsumer<AppCubit, AppStates>(
          builder: (context, state) {
            AppCubit cubit = AppCubit.get(context);
            cubit.emit(AppOpenArchiveState());
            return Scaffold(
              appBar: AppBar(
                actions: [
                  IconButton(
                      onPressed: () {
                        print(shifts[0]['id']);
                      },
                      icon: Icon(Icons.refresh))
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return BuildShiftItem(shifts[index], context);
                      // return Dismissible(
                      //   onDismissed: (direction) {
                      //     cubit.deleteDatabase(id: shifts[index]['id']);
                      //   },
                      //   key: Key(shifts[index].toString()),
                      //   child: SingleChildScrollView(
                      //     scrollDirection: Axis.horizontal,
                      //     child: Padding(
                      //       padding: const EdgeInsetsDirectional.only(
                      //           top: 5.0, start: 20.0, bottom: 5.0),
                      //       child: Container(
                      //         child: Row(children: [
                      //           CircleAvatar(
                      //             radius: 28,
                      //             backgroundColor: Colors.black,
                      //             child: CircleAvatar(
                      //               child: Text(
                      //                 DateFormat('MMMd').format(DateTime.parse(
                      //                     shifts[index]['timeIn'])),
                      //                 style: TextStyle(
                      //                   fontSize: 15.0,
                      //                 ),
                      //               ),
                      //               radius: 27,
                      //             ),
                      //           ),
                      //           SizedBox(
                      //             width: 5.0,
                      //           ),
                      //           Container(
                      //             color: Colors.black,
                      //             width: 2.0,
                      //           ),
                      //           SizedBox(
                      //             width: 5.0,
                      //           ),
                      //           Column(
                      //             crossAxisAlignment: CrossAxisAlignment.start,
                      //             mainAxisSize: MainAxisSize.min,
                      //             children: [
                      //               Row(
                      //                 children: [
                      //                   SizedBox(
                      //                     child: Text('Time In:'),
                      //                     width: 65.0,
                      //                   ),
                      //                   Text(DateFormat('hh:mm a').format(
                      //                       DateTime.parse(
                      //                           shifts[index]['timeIn']))),
                      //                 ],
                      //               ),
                      //               SizedBox(
                      //                 height: 10.0,
                      //               ),
                      //               Row(
                      //                 children: [
                      //                   SizedBox(
                      //                     child: Text('Time Out:'),
                      //                     width: 65.0,
                      //                   ),
                      //                   Text(DateFormat('hh:mm a').format(
                      //                       DateTime.parse(
                      //                           shifts[index]['timeOut']))),
                      //                 ],
                      //               ),
                      //             ],
                      //           ),
                      //           SizedBox(
                      //             width: 30.0,
                      //           ),
                      //           Text('${shifts[index]['shiftTime']}'),
                      //         ]),
                      //         height: 60.0,
                      //         // decoration: BoxDecoration(
                      //         //   border: Border.all(),
                      //         //   borderRadius: BorderRadius.circular(10),
                      //         // ),
                      //       ),
                      //     ),
                      //   ),
                      // );
                    },
                    separatorBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsetsDirectional.only(
                          start: 15.0,
                          top: 5.0,
                          bottom: 5.0,
                        ),
                        child: Container(
                          height: 2.0,
                          color: Colors.grey,
                        ),
                      );
                    },
                    itemCount: shifts.length),
              ),
            );
          },
          listener: (context, state) {},
        ));
  }
}
