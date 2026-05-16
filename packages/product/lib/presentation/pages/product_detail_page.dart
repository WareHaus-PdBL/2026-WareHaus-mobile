import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product/presentation/bloc/product_bloc.dart';
import 'package:product/presentation/bloc/product_event.dart';
import 'package:product/presentation/bloc/product_state.dart';
import 'package:product/presentation/pages/add_stock.dart';
import 'package:product/presentation/widgets/product_card.dart';
import 'package:product/presentation/widgets/shelf_card.dart';

class ProductDetailPage extends StatefulWidget {
  final String productId;
  const ProductDetailPage({super.key, required this.productId});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<ProductBloc>().add(GetProductDetailsEvent(widget.productId));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHColors.background,
      appBar: WHAppbar(title: 'Product Detail'),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ProductError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  state.message,
                  style: WHTypography.bodyText,
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          if (state is ProductDetailLoaded) {
            final product = state.product;
            final stocks = product.stocks ?? const [];

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProductCard(product: product, isDetailed: true),
                  const SizedBox(height: 16),
                  Text('List Shelf', style: WHTypography.heading1),
                  const SizedBox(height: 8),
                  if (stocks.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        'No shelf data available',
                        style: WHTypography.bodyText,
                      ),
                    )
                  else
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: stocks.length,
                      itemBuilder: (context, index) {
                        return ShelfCard(stock: stocks[index]);
                      },
                    ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: WHColors.primary1,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: () {
                        Navigator.push<bool>(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                AddStockPage(product: product),
                          ),
                        ).then((isChanged) {
                          if ((isChanged ?? false) && context.mounted) {
                            context.read<ProductBloc>().add(
                              GetProductDetailsEvent(widget.productId),
                            );
                          }
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.post_add, size: 16),
                          const SizedBox(width: 12),
                          const Text('Add Stock'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
