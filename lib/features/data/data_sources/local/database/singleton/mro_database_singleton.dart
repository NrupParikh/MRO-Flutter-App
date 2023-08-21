import 'package:mro/features/data/data_sources/local/database/mro_database.dart';

class MroDatabaseSingleton {
  static late MroDatabase _database;

  static Future<void> init() async {
    _database = await $FloorMroDatabase.databaseBuilder("mro_database.db").build();
  }

  static MroDatabase get database {
    return _database;
  }
}


