import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SplashState extends Equatable {
  SplashState([List props = const []]) : super(props);
}

class InitialState extends SplashState {
  @override
  String toString() {
    return "InitialState";
  }
}

class DrawMainScreenState extends SplashState {
  @override
  String toString() {
    return "DrawMainScreenState";
  }
}

class DrawErrorState extends SplashState {

  final Exception exception;

  DrawErrorState(this.exception) : super([exception]);

  @override
  String toString() {
    return "DrawErrorState";
  }
}
