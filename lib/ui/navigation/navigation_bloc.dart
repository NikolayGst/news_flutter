import 'package:bloc/bloc.dart';
import 'package:news_flutter/ui/navigation/navigation_event.dart';
import 'package:news_flutter/ui/navigation/navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  @override
  NavigationState get initialState => DrawSplashScreenState();

  @override
  Stream<NavigationState> mapEventToState(NavigationEvent event) async* {
    if (event is GoToSlashScreen) {
      yield DrawSplashScreenState();
    } else if (event is GoToHomeScreen) {
      yield DrawHomeScreenState();
    }
  }
}
