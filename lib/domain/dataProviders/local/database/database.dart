import 'package:floor/floor.dart';
import 'package:news_flutter/domain/models/entites/article_model.dart';
import 'package:news_flutter/domain/dataProviders/local/database/daos/acticles_dao.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart'; // the generated code will be there

@Database(
    entities: [
      ArticleModel
    ],
    version: 1)
abstract class NewsDatabase extends FloorDatabase {

  ArticlesDao get articlesDao;
}