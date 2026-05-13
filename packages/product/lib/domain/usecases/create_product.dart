import 'package:product/domain/entities/product.dart';
import 'package:product/domain/repositories/product_repository.dart';

class CreateProduct {
  final ProductRepository repository;
  const CreateProduct(this.repository);

  Future<void> call(Product product) {
    return repository.createProduct(product);
  }
}
