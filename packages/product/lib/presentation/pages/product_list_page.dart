import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/presentation/bloc/navigation_bloc.dart';
import 'package:mobile/route_observer.dart';
import 'package:product/presentation/bloc/product_bloc.dart';
import 'package:product/presentation/bloc/product_event.dart';
import 'package:product/presentation/bloc/product_state.dart';
import 'package:product/presentation/pages/create_product_page.dart';
import 'package:product/presentation/pages/product_detail_page.dart';
import 'package:product/presentation/widgets/product_card.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<ProductBloc>().add(GetProductsEvent());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final modalRoute = ModalRoute.of(context);
    if (modalRoute != null) {
      routeObserver.subscribe(this, modalRoute);
    }
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    // Only fetch if this page is currently displayed (tab index 1)
    final navigationState = context.read<NavigationBloc>().state;
    if (navigationState.currentIndex == 1) {
      context.read<ProductBloc>().add(GetProductsEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHColors.background,
      appBar: WHAppbar(title: 'Product Management'),
      body: Container(
        color: WHColors.background,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            WHSearch(hintText: 'Search products'),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is ProductError) {
                    return Center(
                      child: Text(
                        state.message,
                        style: WHTypography.bodyText,
                        textAlign: TextAlign.center,
                      ),
                    );
                  }

                  if (state is ProductLoaded) {
                    if (state.products.isEmpty) {
                      return const Center(
                        child: Text(
                          'No products found',
                          style: WHTypography.bodyText,
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: state.products.length,
                      itemBuilder: (context, index) {
                        final product = state.products[index];
                        return ProductCard(
                          product: product,
                          onView: () async {
                            await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) =>
                                    ProductDetailPage(productId: product.id),
                              ),
                            );
                            if (!mounted) return;
                            context.read<ProductBloc>().add(GetProductsEvent());
                          },
                        );
                      },
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final navigator = Navigator.of(context);
          await navigator.push(
            PageRouteBuilder(
              pageBuilder: (_, _, _) => const CreateProductPage(),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
          );
          if (!mounted) return;
          context.read<ProductBloc>().add(GetProductsEvent());
        },
        backgroundColor: WHColors.primary3,
        child: const Icon(Icons.add, color: WHColors.surface),
      ),
    );
  }
}
