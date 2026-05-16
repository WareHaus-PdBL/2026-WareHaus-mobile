import 'package:product/domain/entities/product.dart';
import 'package:product/domain/entities/stock_location_input.dart';

abstract class ProductRepository {
  Future<List<Product>> getProducts();
  Future<Product> getProductDetails(String id);
  Future<void> createProduct(Product product);
  Future<void> updateProduct(Product product);
  Future<void> deleteProduct(String id);
  Future<void> addStockLocation(StockLocationInput input);
}
