import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class NavigationState extends Equatable {
  NavigationState([List properties = const []]) : super(properties);
}

class DrawSplashScreenState extends NavigationState {
  @override
  String toString() {
    return "DrawSplashScreenState";
  }
}

class DrawHomeScreenState extends NavigationState {
  @override
  String toString() {
    return "DrawHomeScreenState";
  }
}