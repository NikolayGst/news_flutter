import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:news_flutter/ui/navigation/navigation_bloc.dart';
import 'package:news_flutter/other/custom/simple_bloc_delegate.dart';
import 'package:news_flutter/ui/root_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
      runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.grey,
        ),
        home: BlocProvider(
          builder: (context) => NavigationBloc(),
          child: RootPage(),
        ));
  }
}
