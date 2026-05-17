import 'package:product/data/models/stock_location_input_model.dart';
import 'package:product/domain/repositories/product_repository.dart';

class MoveStockLocation {
  final ProductRepository repository;

  const MoveStockLocation(this.repository);

  Future<void> call(MoveStockInput input) {
    return repository.moveStockLocation(input);
  }
}