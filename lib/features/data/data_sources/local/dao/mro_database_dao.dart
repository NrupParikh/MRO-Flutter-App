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
  Future<List<int>> insertAllAttributes(List<Attributes> attributesList);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertAllAccounts(List<Accounts> accountsList);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertAllFields(List<Fields> fieldsList);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insertParent(Parent parent);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insertOrganizationType(OrganizationType organizationType);
}
