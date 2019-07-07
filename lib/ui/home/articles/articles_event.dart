import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ArticlesEvent extends Equatable {
  ArticlesEvent([List props = const []]) : super(props);
}

class LoadArticles extends ArticlesEvent {
  final String category;

  LoadArticles(this.category) : super([category]);

  @override
  String toString() {
    return 'LoadArticles{category: $category}';
  }
}
