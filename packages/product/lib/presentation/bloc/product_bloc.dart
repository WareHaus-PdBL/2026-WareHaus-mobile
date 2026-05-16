import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product/domain/entities/product.dart';
import 'package:product/domain/usecases/create_product.dart';
import 'package:product/domain/usecases/delete_product.dart';
import 'package:product/domain/usecases/delete_product_stock_location.dart';
import 'package:product/domain/usecases/get_product_detail.dart';
import 'package:product/domain/usecases/get_products.dart';
import 'package:product/domain/usecases/update_product.dart';
import 'package:product/presentation/bloc/product_event.dart';
import 'package:product/presentation/bloc/product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProducts getProductsUsecase;
  final GetProductDetail getProductDetailUsecase;
  final CreateProduct createProductUsecase;
  final UpdateProduct updateProductUsecase;
  final DeleteProduct deleteProductUsecase;
  final DeleteProductStockLocation deleteProductStockLocationUsecase;

  ProductBloc({
    required this.getProductsUsecase,
    required this.getProductDetailUsecase,
    required this.createProductUsecase,
    required this.updateProductUsecase,
    required this.deleteProductUsecase,
    required this.deleteProductStockLocationUsecase,
  }) : super(ProductInitial()) {
    on<GetProductsEvent>((event, emit) async {
      debugPrint('[ProductBloc] GetProductsEvent');
      emit(ProductLoading());
      try {
        final products = await getProductsUsecase();
        debugPrint(
          '[ProductBloc] GetProductsEvent success: ${products.length}',
        );
        emit(ProductLoaded(products));
      } catch (e) {
        debugPrint('[ProductBloc] GetProductsEvent error: $e');
        emit(ProductError(e.toString()));
      }
    });
    on<GetProductDetailsEvent>((event, emit) async {
      debugPrint('[ProductBloc] GetProductDetailsEvent: ${event.id}');
      emit(ProductLoading());
      try {
        final product = await getProductDetailUsecase(event.id);
        debugPrint(
          '[ProductBloc] GetProductDetailsEvent success: ${product.id}',
        );
        emit(ProductDetailLoaded(product));
      } catch (e) {
        debugPrint('[ProductBloc] GetProductDetailsEvent error: $e');
        emit(ProductError(e.toString()));
      }
    });
    on<CreateProductEvent>((event, emit) async {
      debugPrint('[ProductBloc] CreateProductEvent: ${event.sku}');
      emit(ProductLoading());
      try {
        await createProductUsecase(_productFromEvent(event));
        debugPrint('[ProductBloc] CreateProductEvent success');
        add(GetProductsEvent());
      } catch (e) {
        debugPrint('[ProductBloc] CreateProductEvent error: $e');
        emit(ProductError(e.toString()));
      }
    });
    on<UpdateProductEvent>((event, emit) async {
      debugPrint('[ProductBloc] UpdateProductEvent: ${event.id}');
      emit(ProductLoading());
      try {
        await updateProductUsecase(_productFromEvent(event));
        debugPrint('[ProductBloc] UpdateProductEvent success');
        add(GetProductDetailsEvent(event.id));
      } catch (e) {
        debugPrint('[ProductBloc] UpdateProductEvent error: $e');
        emit(ProductError(e.toString()));
      }
    });
    on<DeleteProductEvent>((event, emit) async {
      debugPrint('[ProductBloc] DeleteProductEvent: ${event.id}');
      emit(ProductLoading());
      try {
        await deleteProductUsecase(event.id);
        debugPrint('[ProductBloc] DeleteProductEvent success');
        add(GetProductsEvent());
      } catch (e) {
        debugPrint('[ProductBloc] DeleteProductEvent error: $e');
        emit(ProductError(e.toString()));
      }
    });
    on<DeleteProductStockLocationEvent>((event, emit) async {
      debugPrint(
        '[ProductBloc] DeleteProductStockLocationEvent: '
        '${event.productId}/${event.shelfId}',
      );
      emit(ProductLoading());
      try {
        await deleteProductStockLocationUsecase(
          productId: event.productId,
          shelfId: event.shelfId,
        );
        debugPrint('[ProductBloc] DeleteProductStockLocationEvent success');
        add(GetProductDetailsEvent(event.productId));
      } catch (e) {
        debugPrint('[ProductBloc] DeleteProductStockLocationEvent error: $e');
        emit(ProductError(e.toString()));
      }
    });
  }

  Product _productFromEvent(ProductEvent event) {
    if (event is CreateProductEvent) {
      return Product(
        id: '',
        sku: event.sku,
        productName: event.productName,
        barcode: event.barcode,
        unitOfMeasure: event.unitOfMeasure,
      );
    }

    if (event is UpdateProductEvent) {
      return Product(
        id: event.id,
        sku: event.sku ?? '',
        productName: event.productName ?? '',
        barcode: event.barcode ?? '',
        unitOfMeasure: event.unitOfMeasure ?? '',
      );
    }

    throw ArgumentError('Unsupported product event: $event');
  }
}
