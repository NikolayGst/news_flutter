import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_flutter/ui/navigation/navigation_bloc.dart';
import 'package:news_flutter/ui/navigation/navigation_event.dart';
import 'package:news_flutter/ui/splash/splash_bloc.dart';
import 'package:news_flutter/ui/splash/splash_event.dart';
import 'package:news_flutter/ui/splash/splash_state.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  SplashBloc _splashBloc;

  @override
  void initState() {
    super.initState();
    _splashBloc = SplashBloc();
  }

  @override
  void dispose() {
    super.dispose();
    _splashBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var navigationBloc = BlocProvider.of<NavigationBloc>(context);
    return Scaffold(
        body: BlocBuilder(
      bloc: _splashBloc,
      builder: (BuildContext context, SplashState state) {
        if (state is InitialState) {
             _splashBloc.dispatch(FetchArticles());
        } else if (state is DrawMainScreenState) {
            navigationBloc.dispatch(GoToHomeScreen());
        } else if (state is DrawErrorState) {
          return Center(child: Text("Упс, что-то пошло не так :(", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 25)));
        }
        return Center(child: buildSplashViews());
      },
    ));
  }

  Widget buildSplashViews() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset("assets/images/splash_logo.png"),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("NEWS", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: LinearProgressIndicator(),
        )
      ],
    );
  }
}
