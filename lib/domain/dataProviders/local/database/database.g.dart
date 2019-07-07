// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorNewsDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$NewsDatabaseBuilder databaseBuilder(String name) =>
      _$NewsDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$NewsDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$NewsDatabaseBuilder(null);
}

class _$NewsDatabaseBuilder {
  _$NewsDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  /// Adds migrations to the builder.
  _$NewsDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Creates the database and initializes it.
  Future<NewsDatabase> build() async {
    final database = _$NewsDatabase();
    database.database = await database.open(name ?? ':memory:', _migrations);
    return database;
  }
}

class _$NewsDatabase extends NewsDatabase {
  _$NewsDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ArticlesDao _articlesDaoInstance;

  Future<sqflite.Database> open(String name, List<Migration> migrations) async {
    final path = join(await sqflite.getDatabasesPath(), name);

    return sqflite.openDatabase(
      path,
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onUpgrade: (database, startVersion, endVersion) async {
        MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);
      },
      onCreate: (database, _) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `articles` (`title` TEXT, `author` TEXT, `description` TEXT, `url` TEXT, `urlToImage` TEXT, `publishedAt` TEXT, `category` TEXT, PRIMARY KEY (`title`))');
      },
    );
  }

  @override
  ArticlesDao get articlesDao {
    return _articlesDaoInstance ??= _$ArticlesDao(database, changeListener);
  }
}

class _$ArticlesDao extends ArticlesDao {
  _$ArticlesDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _articleModelInsertionAdapter = InsertionAdapter(
            database,
            'articles',
            (ArticleModel item) => <String, dynamic>{
                  'title': item.title,
                  'author': item.author,
                  'description': item.description,
                  'url': item.url,
                  'urlToImage': item.urlToImage,
                  'publishedAt': item.publishedAt,
                  'category': item.category
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final _articlesMapper = (Map<String, dynamic> row) => ArticleModel(
      row['title'] as String,
      row['author'] as String,
      row['description'] as String,
      row['url'] as String,
      row['urlToImage'] as String,
      row['publishedAt'] as String,
      row['category'] as String);

  final InsertionAdapter<ArticleModel> _articleModelInsertionAdapter;

  @override
  Future<void> deleteArticles() async {
    await _queryAdapter.queryNoReturn('DELETE FROM articles');
  }

  @override
  Stream<List<ArticleModel>> selectArticlesByCategoryAsStream(String category) {
    return _queryAdapter.queryListStream(
        'SELECT * from articles WHERE category = ?',
        arguments: <dynamic>[category],
        tableName: 'articles',
        mapper: _articlesMapper);
  }

  @override
  Future<void> insertArticles(List<ArticleModel> articles) async {
    await _articleModelInsertionAdapter.insertList(
        articles, sqflite.ConflictAlgorithm.replace);
  }
}
