import 'dart:async';

import 'package:floor/floor.dart';
import 'package:mro/features/data/data_sources/local/dao/mro_database_dao.dart';
import 'package:mro/features/data/models/sign_in/accounts.dart';
import 'package:mro/features/data/models/sign_in/attributes.dart';
import 'package:mro/features/data/models/sign_in/employee.dart';
import 'package:mro/features/data/models/sign_in/fields.dart';
import 'package:mro/features/data/models/sign_in/organization_type.dart';
import 'package:mro/features/data/models/sign_in/organizations.dart';
import 'package:mro/features/data/models/sign_in/parent.dart';
import 'package:mro/features/data/models/type_converter/accounts_list_type_converter.dart';
import 'package:mro/features/data/models/type_converter/attributes_list_type_converter.dart';
import 'package:mro/features/data/models/type_converter/field_list_converter.dart';
import 'package:mro/features/data/models/type_converter/organization_type_type_converter.dart';
import 'package:mro/features/data/models/type_converter/organizations_list_type_converter.dart';
import 'package:mro/features/data/models/type_converter/parents_type_converter.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../../../models/currency/currency.dart';

part 'mro_database.g.dart';

@Database(version: 1, entities: [Currency, Employee, Organizations, Attributes, Accounts, Parent, OrganizationType, Fields])
@TypeConverters([
  OrganizationsListConverter,
  AttributesListConverter,
  AccountsListConverter,
  ParentConverter,
  OrganizationTypeConverter,
  FieldsListConverter
])
abstract class MroDatabase extends FloorDatabase {
  MroDAO get mroDao;
}
