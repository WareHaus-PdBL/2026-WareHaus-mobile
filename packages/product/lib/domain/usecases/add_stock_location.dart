import 'package:product/domain/entities/stock_location_input.dart';
import 'package:product/domain/repositories/product_repository.dart';

class AddStockLocation {
  final ProductRepository repository;

  const AddStockLocation(this.repository);

  Future<void> call(StockLocationInput input) {
    return repository.addStockLocation(input);
  }
}