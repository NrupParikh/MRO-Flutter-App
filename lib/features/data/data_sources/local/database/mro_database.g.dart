// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mro_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorMroDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$MroDatabaseBuilder databaseBuilder(String name) =>
      _$MroDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$MroDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$MroDatabaseBuilder(null);
}

class _$MroDatabaseBuilder {
  _$MroDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$MroDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$MroDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<MroDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$MroDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$MroDatabase extends MroDatabase {
  _$MroDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  MroDAO? _mroDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `GetCurrency` (`id` INTEGER, `version` INTEGER, `name` TEXT, `iso` TEXT, `prefix` TEXT, `postfix` TEXT, `currencyFormat` TEXT, `countryId` INTEGER, `countryName` TEXT, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  MroDAO get mroDao {
    return _mroDaoInstance ??= _$MroDAO(database, changeListener);
  }
}

class _$MroDAO extends MroDAO {
  _$MroDAO(
    this.database,
    this.changeListener,
  ) : _getCurrencyInsertionAdapter = InsertionAdapter(
            database,
            'GetCurrency',
            (GetCurrency item) => <String, Object?>{
                  'id': item.id,
                  'version': item.version,
                  'name': item.name,
                  'iso': item.iso,
                  'prefix': item.prefix,
                  'postfix': item.postfix,
                  'currencyFormat': item.currencyFormat,
                  'countryId': item.countryId,
                  'countryName': item.countryName
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final InsertionAdapter<GetCurrency> _getCurrencyInsertionAdapter;

  @override
  Future<void> insertCurrency(GetCurrency currency) async {
    await _getCurrencyInsertionAdapter.insert(
        currency, OnConflictStrategy.abort);
  }

  @override
  Future<List<int>> insertAllCurrency(List<GetCurrency> currencyList) {
    return _getCurrencyInsertionAdapter.insertListAndReturnIds(
        currencyList, OnConflictStrategy.abort);
  }
}
