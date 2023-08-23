import 'package:floor/floor.dart';
import 'package:mro/features/data/models/currency/currency.dart';

@dao
abstract class MroDAO {
  @insert
  Future<void> insertCurrency(Currency currency);

  @insert
  Future<List<int>> insertAllCurrency(List<Currency> currencyList);
}
