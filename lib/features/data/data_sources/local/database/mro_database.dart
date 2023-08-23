import 'dart:async';

import 'package:floor/floor.dart';
import 'package:mro/features/data/data_sources/local/dao/mro_database_dao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../../../models/currency/currency.dart';

part 'mro_database.g.dart';

@Database(version: 1, entities: [Currency])
abstract class MroDatabase extends FloorDatabase {
  MroDAO get mroDao;
}
