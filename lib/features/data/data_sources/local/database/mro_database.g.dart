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
            'CREATE TABLE IF NOT EXISTS `Currency` (`id` INTEGER, `version` INTEGER, `name` TEXT, `iso` TEXT, `prefix` TEXT, `postfix` TEXT, `currencyFormat` TEXT, `countryId` INTEGER, `countryName` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Employee` (`id` INTEGER, `firstName` TEXT, `lastName` TEXT, `middleName` TEXT, `initials` TEXT, `phone` TEXT, `email` TEXT, `externalIdentifier` TEXT, `account` TEXT, `organizations` TEXT NOT NULL, `vendorCode` TEXT, `isCompanyCreditCardHolder` INTEGER, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Organizations` (`id` INTEGER, `employeeId` INTEGER, `version` INTEGER, `name` TEXT, `externalIdentifier` TEXT, `abbreviation` TEXT, `attributes` TEXT NOT NULL, `shortDescription` TEXT, `parent` TEXT, `organizationType` TEXT, `active` INTEGER, `accounts` TEXT NOT NULL, `activatePrimaryVAT` INTEGER, `activateSecondaryVAT` INTEGER, `substituteSubValue` INTEGER, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Attributes` (`id` INTEGER, `organizationId` INTEGER, `version` INTEGER, `value` TEXT, `name` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Accounts` (`id` INTEGER, `organizationId` INTEGER, `version` INTEGER, `name` TEXT, `active` INTEGER, `div` TEXT, `dept` TEXT, `account` TEXT, `sub` TEXT, `receiptVerifyRequired` INTEGER, `thresholdAmount` TEXT, `receiptUploadRequired` INTEGER, `fields` TEXT NOT NULL, `identifier` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Fields` (`id` INTEGER, `accountsId` INTEGER, `version` INTEGER, `label` TEXT, `required` INTEGER, `sequence` REAL, `uppercase` INTEGER, `maxLength` INTEGER, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Parent` (`id` INTEGER, `organizationId` INTEGER, `version` INTEGER, `name` TEXT, `externalIdentifier` TEXT, `abbreviation` TEXT, `shortDescription` TEXT, `active` INTEGER, `activatePrimaryVAT` INTEGER, `activateSecondaryVAT` INTEGER, `substituteSubValue` INTEGER, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `OrganizationType` (`id` INTEGER, `organizationId` INTEGER, `code` TEXT, `name` TEXT, PRIMARY KEY (`id`))');

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
  )   : _queryAdapter = QueryAdapter(database),
        _currencyInsertionAdapter = InsertionAdapter(
            database,
            'Currency',
            (Currency item) => <String, Object?>{
                  'id': item.id,
                  'version': item.version,
                  'name': item.name,
                  'iso': item.iso,
                  'prefix': item.prefix,
                  'postfix': item.postfix,
                  'currencyFormat': item.currencyFormat,
                  'countryId': item.countryId,
                  'countryName': item.countryName
                }),
        _employeeInsertionAdapter = InsertionAdapter(
            database,
            'Employee',
            (Employee item) => <String, Object?>{
                  'id': item.id,
                  'firstName': item.firstName,
                  'lastName': item.lastName,
                  'middleName': item.middleName,
                  'initials': item.initials,
                  'phone': item.phone,
                  'email': item.email,
                  'externalIdentifier': item.externalIdentifier,
                  'account': item.account,
                  'organizations':
                      _organizationsListConverter.encode(item.organizations),
                  'vendorCode': item.vendorCode,
                  'isCompanyCreditCardHolder':
                      item.isCompanyCreditCardHolder == null
                          ? null
                          : (item.isCompanyCreditCardHolder! ? 1 : 0)
                }),
        _organizationsInsertionAdapter = InsertionAdapter(
            database,
            'Organizations',
            (Organizations item) => <String, Object?>{
                  'id': item.id,
                  'employeeId': item.employeeId,
                  'version': item.version,
                  'name': item.name,
                  'externalIdentifier': item.externalIdentifier,
                  'abbreviation': item.abbreviation,
                  'attributes':
                      _attributesListConverter.encode(item.attributes),
                  'shortDescription': item.shortDescription,
                  'parent': _parentConverter.encode(item.parent),
                  'organizationType':
                      _organizationTypeConverter.encode(item.organizationType),
                  'active': item.active,
                  'accounts': _accountsListConverter.encode(item.accounts),
                  'activatePrimaryVAT': item.activatePrimaryVAT == null
                      ? null
                      : (item.activatePrimaryVAT! ? 1 : 0),
                  'activateSecondaryVAT': item.activateSecondaryVAT == null
                      ? null
                      : (item.activateSecondaryVAT! ? 1 : 0),
                  'substituteSubValue': item.substituteSubValue == null
                      ? null
                      : (item.substituteSubValue! ? 1 : 0)
                }),
        _attributesInsertionAdapter = InsertionAdapter(
            database,
            'Attributes',
            (Attributes item) => <String, Object?>{
                  'id': item.id,
                  'organizationId': item.organizationId,
                  'version': item.version,
                  'value': item.value,
                  'name': item.name
                }),
        _accountsInsertionAdapter = InsertionAdapter(
            database,
            'Accounts',
            (Accounts item) => <String, Object?>{
                  'id': item.id,
                  'organizationId': item.organizationId,
                  'version': item.version,
                  'name': item.name,
                  'active': item.active == null ? null : (item.active! ? 1 : 0),
                  'div': item.div,
                  'dept': item.dept,
                  'account': item.account,
                  'sub': item.sub,
                  'receiptVerifyRequired': item.receiptVerifyRequired == null
                      ? null
                      : (item.receiptVerifyRequired! ? 1 : 0),
                  'thresholdAmount': item.thresholdAmount,
                  'receiptUploadRequired': item.receiptUploadRequired == null
                      ? null
                      : (item.receiptUploadRequired! ? 1 : 0),
                  'fields': _fieldsListConverter.encode(item.fields),
                  'identifier': item.identifier
                }),
        _fieldsInsertionAdapter = InsertionAdapter(
            database,
            'Fields',
            (Fields item) => <String, Object?>{
                  'id': item.id,
                  'accountsId': item.accountsId,
                  'version': item.version,
                  'label': item.label,
                  'required':
                      item.required == null ? null : (item.required! ? 1 : 0),
                  'sequence': item.sequence,
                  'uppercase':
                      item.uppercase == null ? null : (item.uppercase! ? 1 : 0),
                  'maxLength': item.maxLength
                }),
        _parentInsertionAdapter = InsertionAdapter(
            database,
            'Parent',
            (Parent item) => <String, Object?>{
                  'id': item.id,
                  'organizationId': item.organizationId,
                  'version': item.version,
                  'name': item.name,
                  'externalIdentifier': item.externalIdentifier,
                  'abbreviation': item.abbreviation,
                  'shortDescription': item.shortDescription,
                  'active': item.active,
                  'activatePrimaryVAT': item.activatePrimaryVAT == null
                      ? null
                      : (item.activatePrimaryVAT! ? 1 : 0),
                  'activateSecondaryVAT': item.activateSecondaryVAT == null
                      ? null
                      : (item.activateSecondaryVAT! ? 1 : 0),
                  'substituteSubValue': item.substituteSubValue == null
                      ? null
                      : (item.substituteSubValue! ? 1 : 0)
                }),
        _organizationTypeInsertionAdapter = InsertionAdapter(
            database,
            'OrganizationType',
            (OrganizationType item) => <String, Object?>{
                  'id': item.id,
                  'organizationId': item.organizationId,
                  'code': item.code,
                  'name': item.name
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Currency> _currencyInsertionAdapter;

  final InsertionAdapter<Employee> _employeeInsertionAdapter;

  final InsertionAdapter<Organizations> _organizationsInsertionAdapter;

  final InsertionAdapter<Attributes> _attributesInsertionAdapter;

  final InsertionAdapter<Accounts> _accountsInsertionAdapter;

  final InsertionAdapter<Fields> _fieldsInsertionAdapter;

  final InsertionAdapter<Parent> _parentInsertionAdapter;

  final InsertionAdapter<OrganizationType> _organizationTypeInsertionAdapter;

  @override
  Future<List<Organizations>> getOrganizations(int id) async {
    return _queryAdapter.queryList(
        'select * from Organizations where employeeId= ?1',
        mapper: (Map<String, Object?> row) => Organizations(
            id: row['id'] as int?,
            employeeId: row['employeeId'] as int?,
            version: row['version'] as int?,
            name: row['name'] as String?,
            externalIdentifier: row['externalIdentifier'] as String?,
            abbreviation: row['abbreviation'] as String?,
            attributes:
                _attributesListConverter.decode(row['attributes'] as String),
            shortDescription: row['shortDescription'] as String?,
            parent: _parentConverter.decode(row['parent'] as String),
            organizationType: _organizationTypeConverter
                .decode(row['organizationType'] as String),
            active: row['active'] as int?,
            accounts: _accountsListConverter.decode(row['accounts'] as String),
            activatePrimaryVAT: row['activatePrimaryVAT'] == null
                ? null
                : (row['activatePrimaryVAT'] as int) != 0,
            activateSecondaryVAT: row['activateSecondaryVAT'] == null
                ? null
                : (row['activateSecondaryVAT'] as int) != 0,
            substituteSubValue: row['substituteSubValue'] == null
                ? null
                : (row['substituteSubValue'] as int) != 0),
        arguments: [id]);
  }

  @override
  Future<void> insertCurrency(Currency currency) async {
    await _currencyInsertionAdapter.insert(
        currency, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertAllCurrency(List<Currency> currencyList) {
    return _currencyInsertionAdapter.insertListAndReturnIds(
        currencyList, OnConflictStrategy.replace);
  }

  @override
  Future<int> insertEmployee(Employee employee) {
    return _employeeInsertionAdapter.insertAndReturnId(
        employee, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertAllOrganizations(
      List<Organizations> organizationsList) {
    return _organizationsInsertionAdapter.insertListAndReturnIds(
        organizationsList, OnConflictStrategy.replace);
  }

  @override
  Future<int> insertOrganization(Organizations organization) {
    return _organizationsInsertionAdapter.insertAndReturnId(
        organization, OnConflictStrategy.replace);
  }

  @override
  Future<int> insertAttributes(Attributes attributes) {
    return _attributesInsertionAdapter.insertAndReturnId(
        attributes, OnConflictStrategy.replace);
  }

  @override
  Future<int> insertAccounts(Accounts accounts) {
    return _accountsInsertionAdapter.insertAndReturnId(
        accounts, OnConflictStrategy.replace);
  }

  @override
  Future<int> insertAccountsFields(Fields fields) {
    return _fieldsInsertionAdapter.insertAndReturnId(
        fields, OnConflictStrategy.replace);
  }

  @override
  Future<int> insertParents(Parent parent) {
    return _parentInsertionAdapter.insertAndReturnId(
        parent, OnConflictStrategy.replace);
  }

  @override
  Future<int> insertOrganizationType(OrganizationType organizationType) {
    return _organizationTypeInsertionAdapter.insertAndReturnId(
        organizationType, OnConflictStrategy.replace);
  }
}

// ignore_for_file: unused_element
final _organizationsListConverter = OrganizationsListConverter();
final _attributesListConverter = AttributesListConverter();
final _accountsListConverter = AccountsListConverter();
final _parentConverter = ParentConverter();
final _organizationTypeConverter = OrganizationTypeConverter();
final _fieldsListConverter = FieldsListConverter();
