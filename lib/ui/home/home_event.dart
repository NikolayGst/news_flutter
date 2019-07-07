import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HomeEvent extends Equatable {
  HomeEvent([List props = const []]) : super(props);
}

class LoadArticles extends HomeEvent {
  final String category;

  LoadArticles(this.category) : super([category]);

  @override
  String toString() {
    return 'LoadArticles{category: $category}';
  }
}

class LoadCategories extends HomeEvent {
  @override
  String toString() {
    return 'LoadCategories';
  }
}
