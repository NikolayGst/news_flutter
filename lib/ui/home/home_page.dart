import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_flutter/domain/models/entites/article_model.dart';
import 'package:news_flutter/other/consts.dart';
import 'package:news_flutter/ui/home/home_bloc.dart';
import 'package:news_flutter/ui/home/home_event.dart';
import 'package:news_flutter/ui/home/home_state.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc _homeBloc;

  @override
  void initState() {
    super.initState();
    _homeBloc = HomeBloc();
  }

  @override
  void dispose() {
    super.dispose();
    _homeBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categoriesHeight = 150.0;
    final parts = {"categories": Container(), "articles": Container()};
    return Scaffold(
        appBar: AppBar(
          title: Text("News", style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
        ),
        body: Container(
          child: LayoutBuilder(
            builder: (context, size) => BlocBuilder(
                bloc: _homeBloc,
                builder: (context, HomeState state) {
                  if (state is InitialState) {
                    _homeBloc.dispatch(LoadCategories());
                  }

                  if (state is DrawCategoriesState) {
                    parts["categories"] = buildHorizontalCategories(
                        categoriesHeight, state.categoriesWithCount);
                    _homeBloc.dispatch(LoadArticles(Constants.BUSINESS));
                  }

                  if (state is DrawArticlesState) {
                    parts["articles"] = buildArticlesList(
                        size.maxHeight - categoriesHeight - 40, state.articles);
                  }

                  return Column(children: parts.values.toList());
                }),
          ),
        ));
  }

  Widget buildHorizontalCategories(double heightSize, Map<String, int> categories) {
    final list = List<Widget>();

    categories.forEach((k, v) {
      list.add(CategoryItem(
          title: _getCategoryName(k),
          count: "${categories[k]} статей",
          color: _getCategoryColor(k),
          onTap: () {
            _homeBloc.dispatch(LoadArticles(k));
          }));
    });

    list.add(Container(width: 10));

    return Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: heightSize,
        child: ListView(scrollDirection: Axis.horizontal, children: list));
  }

  String _getCategoryName(String category) {
    if (category == Constants.BUSINESS) {
      return "Бизнес";
    } else if (category == Constants.SPORTS) {
      return "Спорт";
    } else if (category == Constants.SCIENCE) {
      return "Наука";
    } else if (category == Constants.TECHNOLOGY) {
      return "Технологии";
    }
    return "";
  }

  Color _getCategoryColor(String category) {
    if (category == Constants.BUSINESS) {
      return Colors.blue;
    } else if (category == Constants.SPORTS) {
      return Colors.green;
    } else if (category == Constants.SCIENCE) {
      return Colors.orange.shade400;
    } else if (category == Constants.TECHNOLOGY) {
      return Colors.redAccent;
    }
    return Colors.blue;
  }

  Widget buildArticlesList(double heightSize, List<ArticleModel> articles) {
    var list = articles.map((item) {
      return ListTile(
          title: Text(item.title),
          leading: item.urlToImage != null
              ? CircleAvatar(backgroundImage: NetworkImage(item.urlToImage))
              : Container(),
          subtitle: Text(item.category));
    }).toList();

    return Container(
        height: heightSize,
        child: ListView(scrollDirection: Axis.vertical, children: list));
  }
}

class CategoryItem extends StatelessWidget {
  final String title;
  final String count;
  final Color color;
  final Function onTap;

  CategoryItem({this.title, this.count, this.color, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      margin: EdgeInsets.only(left: 10),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 150,
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 8, bottom: 8),
                  child: Text(title,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontFamily: 'roboto-medium')),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, bottom: 16),
                  child: Text(count,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                          fontFamily: 'roboto',
                          fontWeight: FontWeight.w200)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
