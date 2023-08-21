import 'package:floor/floor.dart';
import 'package:mro/features/data/models/currency/get_currency.dart';

@dao
abstract class MroDAO {
  @insert
  Future<void> insertCurrency(GetCurrency currency);

  @insert
  Future<List<int>> insertAllCurrency(List<GetCurrency> currencyList);
}
