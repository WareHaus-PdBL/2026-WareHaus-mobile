import 'package:product/domain/entities/product.dart';
import 'package:product/domain/repositories/product_repository.dart';

class GetProducts {
  final ProductRepository repository;
  GetProducts(this.repository);

  Future<List<Product>> call() {
    return repository.getProducts();
  }
}
