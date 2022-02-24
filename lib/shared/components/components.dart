import 'package:flutter/material.dart';
import 'package:in_out_app/shared/components/constants.dart';
import 'package:in_out_app/shared/cubit/cubit.dart';
import 'package:intl/intl.dart';

Widget BuildShiftIte(Map model, context) => Padding(
      padding:
          const EdgeInsetsDirectional.only(top: 5.0, start: 20.0, bottom: 5.0),
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
    );

class BuildShiftItem extends StatelessWidget {
  Map model;
  BuildContext context;

  BuildShiftItem(this.model, this.context);

  @override
  Widget build(context) {
    return Padding(
      padding:
          const EdgeInsetsDirectional.only(top: 5.0, start: 20.0, bottom: 5.0),
      child: Container(
        child: Row(
          children: [
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
          ],
        ),
        height: 60.0,
        // decoration: BoxDecoration(
        //   border: Border.all(),
        //   borderRadius: BorderRadius.circular(10),
        // ),
      ),
    );
  }
}

class ListSeparator extends StatelessWidget {
  @override
  Widget build(context) {
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
  }
}

class TimeWidget extends StatelessWidget {
  String label;
  Function? onTap;
  TextEditingController? controller;
  double labelFontSize;
  double textFontSize;

  TimeWidget({
    required String this.label,
    Function? this.onTap,
    TextEditingController? this.controller,
    double this.labelFontSize = 40.0,
    double this.textFontSize = 40.0,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: labelFontSize,
              ),
            ),
            flex: 1,
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: TextFormField(
                onTap: () {
                  onTap!();
                },
                keyboardType: TextInputType.none,
                controller: controller,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                ),
                style: TextStyle(
                  fontSize: textFontSize,
                ),
              ),
            ),
            flex: 2,
          ),
        ],
      ),
      flex: 1,
    );
  }
}

/*Widget TimeWidget({
  required String label,
  Function? onTap,
  TextEditingController? controller,
}) =>
    Expanded(
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
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
                  onTap!();
                },
                keyboardType: TextInputType.none,
                controller: controller,
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
    );*/

class DefaultButton extends StatelessWidget {
  Function onPressed;
  String text;
  Color color;
  Color textColor;

  DefaultButton({
    required Function this.onPressed,
    required String this.text,
    required Color this.color,
    Color this.textColor = Colors.white70,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        onPressed();
      },
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 20.0,
        ),
      ),
      color: color,
    );
  }
}
