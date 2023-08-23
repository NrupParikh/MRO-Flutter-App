import 'package:floor/floor.dart';
import 'package:mro/features/data/models/currency/currency.dart';

@dao
abstract class MroDAO {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertCurrency(Currency currency);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertAllCurrency(List<Currency> currencyList);
}
