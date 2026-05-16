import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product/domain/entities/product.dart';
import 'package:product/domain/entities/stock_location_input.dart';
import 'package:product/domain/usecases/add_stock_location.dart';
import 'package:product/domain/usecases/create_product.dart';
import 'package:product/domain/usecases/delete_product.dart';
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
  final AddStockLocation addStockLocationUsecase;

  ProductBloc({
    required this.getProductsUsecase,
    required this.getProductDetailUsecase,
    required this.createProductUsecase,
    required this.updateProductUsecase,
    required this.deleteProductUsecase,
    required this.addStockLocationUsecase,
  }) : super(ProductInitial()) {
    on<GetProductsEvent>((event, emit) async {
      emit(ProductLoading());
      try {
        final products = await getProductsUsecase();
        emit(ProductLoaded(products));
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });
    on<GetProductDetailsEvent>((event, emit) async {
      emit(ProductLoading());
      try {
        final product = await getProductDetailUsecase(event.id);
        emit(ProductDetailLoaded(product));
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });
    on<CreateProductEvent>((event, emit) async {
      emit(ProductLoading());
      try {
        await createProductUsecase(_productFromEvent(event));
        add(GetProductsEvent());
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });
    on<UpdateProductEvent>((event, emit) async {
      emit(ProductLoading());
      try {
        await updateProductUsecase(_productFromEvent(event));
        add(GetProductsEvent());
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });
    on<DeleteProductEvent>((event, emit) async {
      emit(ProductLoading());
      try {
        await deleteProductUsecase(event.id);
        add(GetProductsEvent());
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });
    on<AddStockLocationEvent>((event, emit) async {
      emit(ProductLoading());
      try {
        await addStockLocationUsecase(
          StockLocationInput(
            productId: event.productId,
            shelfId: event.shelfId,
            quantity: event.quantity,
          ),
        );
        final product = await getProductDetailUsecase(event.productId);
        emit(ProductDetailLoaded(product));
      } catch (e) {
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
