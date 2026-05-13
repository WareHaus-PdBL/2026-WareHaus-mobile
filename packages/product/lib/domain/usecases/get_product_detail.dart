import 'package:product/domain/entities/product.dart';
import 'package:product/domain/repositories/product_repository.dart';

class GetProductDetail {
  final ProductRepository repository;
  GetProductDetail(this.repository);

  Future<Product> call(String id) {
    return repository.getProductDetails(id);
  }
}
