import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CategoriesState extends Equatable {
  CategoriesState([List props = const []]) : super(props);
}

class InitialCategoriesState extends CategoriesState {}

class DrawCategoriesState extends CategoriesState {
  final Map<String, int> categoriesWithCount;

  DrawCategoriesState(this.categoriesWithCount) : super([categoriesWithCount]);

  @override
  String toString() {
    return 'DrawCategoriesState{categoriesWithCount: ${categoriesWithCount.length}}';
  }
}
