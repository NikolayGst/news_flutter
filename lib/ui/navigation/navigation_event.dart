import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class NavigationEvent extends Equatable {
  NavigationEvent([List properties = const []]) : super(properties);
}

class GoToSlashScreen extends NavigationEvent {
  @override
  String toString() {
    return "GoToSlashScreen";
  }
}

class GoToHomeScreen extends NavigationEvent {
  @override
  String toString() {
    return "GoToHomeScreen";
  }
}
