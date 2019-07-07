import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_flutter/other/consts.dart';

import 'articles/bloc.dart';
import 'categories/bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CategoriesBloc _categoriesBloc;
  ArticlesBloc _articlesBloc;

  @override
  void initState() {
    super.initState();
    _categoriesBloc = CategoriesBloc();
    _articlesBloc = ArticlesBloc();

    _categoriesBloc.dispatch(LoadCategories());
    _articlesBloc.dispatch(LoadArticles(Constants.BUSINESS));
  }

  @override
  void dispose() {
    super.dispose();
    _categoriesBloc.dispose();
    _articlesBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categoriesHeight = 150.0;

    return Scaffold(
        appBar: AppBar(
          title: Text("News", style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
        ),
        body: Container(
            child: LayoutBuilder(
                builder: (context, size) => Column(children: <Widget>[
                      buildHorizontalCategories(categoriesHeight),
                      buildArticlesList(size.maxHeight - categoriesHeight - 40)
                    ]))));
  }

  Widget buildHorizontalCategories(double heightSize) {
    return BlocBuilder<CategoriesEvent, CategoriesState>(
      bloc: _categoriesBloc,
      builder: (context, state) {
        if (state is DrawCategoriesState) {
          final categories = state.categoriesWithCount;
          final list = List<Widget>();

          categories.forEach((k, v) {
            list.add(CategoryItem(
                title: _getCategoryName(k),
                count: "${categories[k]} статей",
                color: _getCategoryColor(k),
                onTap: () {
                  _articlesBloc.dispatch(LoadArticles(k));
                }));
          });

          list.add(Container(width: 10));

          return Container(
              margin: EdgeInsets.symmetric(vertical: 20.0),
              height: heightSize,
              child:
                  ListView(scrollDirection: Axis.horizontal, children: list));
        }

        return Container();
      },
    );
  }

  Widget buildArticlesList(double heightSize) {
    return BlocBuilder<ArticlesEvent, ArticlesState>(
      bloc: _articlesBloc,
      builder: (context, state) {
        if (state is DrawArticlesState) {
          final articles = state.articles;
          var list = articles.map((item) {
            return ListTile(
                title: Text(item.title),
                leading: item.urlToImage != null
                    ? CircleAvatar(
                        backgroundImage: NetworkImage(item.urlToImage))
                    : Container(),
                subtitle: Text(item.category));
          }).toList();

          return Container(
              height: heightSize,
              child: ListView(scrollDirection: Axis.vertical, children: list));
        }

        return Container();
      },
    );
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
