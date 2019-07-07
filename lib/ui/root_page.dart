import 'package:flutter/material.dart';
import 'package:news_flutter/ui/home/home_page.dart';
import 'package:news_flutter/ui/navigation/navigation_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_flutter/ui/navigation/navigation_state.dart';
import 'package:news_flutter/ui/splash/spash_page.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  NavigationBloc _navigationBloc;

  @override
  void initState() {
    super.initState();
    _navigationBloc = BlocProvider.of<NavigationBloc>(context);
  }

  @override
  void dispose() {
    super.dispose();
    _navigationBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: _navigationBloc,
        builder: (context, state) {
          if (state is DrawSplashScreenState) {
            return SplashPage();
          } else if (state is DrawHomeScreenState) {
            return HomePage();
          }
          return null;
        });
  }
}
