import 'package:floor/floor.dart';
import 'package:mro/features/data/models/currency/currency.dart';
import 'package:mro/features/data/models/sign_in/accounts.dart';
import 'package:mro/features/data/models/sign_in/attributes.dart';
import 'package:mro/features/data/models/sign_in/employee.dart';
import 'package:mro/features/data/models/sign_in/fields.dart';
import 'package:mro/features/data/models/sign_in/organization_type.dart';
import 'package:mro/features/data/models/sign_in/parent.dart';

import '../../../models/sign_in/organizations.dart';

@dao
abstract class MroDAO {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertCurrency(Currency currency);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertAllCurrency(List<Currency> currencyList);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insertEmployee(Employee employee);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertAllOrganizations(List<Organizations> organizationsList);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insertOrganization(Organizations organization);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insertAttributes(Attributes attributes);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insertAccounts(Accounts accounts);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insertAccountsFields(Fields fields);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insertParents(Parent parent);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insertOrganizationType(OrganizationType organizationType);

  @Query("select * from Organizations where employeeId= :id")
  Future<List<Organizations>> getOrganizationsBasedOnEmployee(int id);

  @Query("select * from Currency")
  Future<List<Currency>> getAllCurrencies();

  @Query("select * from accounts where organizationId in (select organizationId from organizations where employeeId = :id)")
  Future<List<Accounts>> getAccountsBasedOnOrganizations(int id);

// @Insert(onConflict: OnConflictStrategy.replace)
// Future<List<int>> insertAllAttributes(List<Attributes> attributesList);

// @Insert(onConflict: OnConflictStrategy.replace)
// Future<List<int>> insertAllAccounts(List<Accounts> accountsList);
//
// @Insert(onConflict: OnConflictStrategy.replace)
// Future<List<int>> insertAllFields(List<Fields> fieldsList);
//
// @Insert(onConflict: OnConflictStrategy.replace)
// Future<int> insertParent(Parent parent);
//
// @Insert(onConflict: OnConflictStrategy.replace)
// Future<int> insertOrganizationType(OrganizationType organizationType);
}
