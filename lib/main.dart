import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:in_out_app/layout/home_screen.dart';
import 'package:in_out_app/shared/bloc_observer.dart';
import 'package:in_out_app/shared/cubit/cubit.dart';

void main() {
  BlocOverrides.runZoned(
    () {
      runApp(MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('In Out App'),
          centerTitle: true,
        ),
        body: HomeScreen(),
      ),
    );
  }
}
