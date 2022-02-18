import 'package:flutter/material.dart';

class ArchiveScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: ListView.separated(
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsetsDirectional.only(
                    top: 5.0, end: 20.0, start: 20.0, bottom: 5.0),
                child: Container(
                  child: Row(children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.black,
                      child: CircleAvatar(
                        child: Text(
                          'Feb 29',
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
                            Text('00:00'),
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
                            Text('00:00'),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 60.0,
                    ),
                    Text('Shift Time: 00:00'),
                  ]),
                  height: 60.0,
                  // decoration: BoxDecoration(
                  //   border: Border.all(),
                  //   borderRadius: BorderRadius.circular(10),
                  // ),
                ),
              );
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
            itemCount: 10),
      ),
    );
  }
}
