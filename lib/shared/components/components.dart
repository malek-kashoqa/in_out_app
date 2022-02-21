import 'package:flutter/material.dart';
import 'package:in_out_app/shared/components/constants.dart';
import 'package:in_out_app/shared/cubit/cubit.dart';
import 'package:intl/intl.dart';

Widget BuildShiftItem(Map model, context) => Dismissible(
      key: Key(model['id'].toString()),
      onDismissed: (direction) {
        AppCubit.get(context).deleteDatabase(id: model['id']);
      },
      background: Container(
        color: Colors.red,
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.only(
            top: 5.0, start: 20.0, bottom: 5.0),
        child: Container(
          child: Row(children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: Colors.black,
              child: CircleAvatar(
                child: Text(
                  DateFormat('MMMd').format(DateTime.parse(model['timeIn'])),
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
                radius: 27,
              ),
            ),
            SizedBox(
              width: 5.0,
            ),
            Container(
              color: Colors.black,
              width: 2.0,
            ),
            SizedBox(
              width: 5.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    SizedBox(
                      child: Text('Time In:'),
                      width: 65.0,
                    ),
                    Text(DateFormat('hh:mm a')
                        .format(DateTime.parse(model['timeIn']))),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    SizedBox(
                      child: Text('Time Out:'),
                      width: 65.0,
                    ),
                    Text(DateFormat('hh:mm a')
                        .format(DateTime.parse(model['timeOut']))),
                  ],
                ),
              ],
            ),
            SizedBox(
              width: 30.0,
            ),
            Text('${model['shiftTime']}'),
          ]),
          height: 60.0,
          // decoration: BoxDecoration(
          //   border: Border.all(),
          //   borderRadius: BorderRadius.circular(10),
          // ),
        ),
      ),
    );
