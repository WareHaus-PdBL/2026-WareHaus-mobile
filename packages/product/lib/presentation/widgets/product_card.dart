import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:product/domain/entities/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final bool? isDetailed;
  final int? shelfStock;
  final VoidCallback? onView;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  const ProductCard({
    super.key,
    required this.product,
    this.isDetailed = false,
    this.shelfStock,
    this.onView,
    this.onEdit,
    this.onDelete,
  });

  int get _totalStock {
    if (shelfStock != null) return shelfStock!;
    if (product.currentStock > 0) return product.currentStock;
    final stocks = product.stocks;
    if (stocks == null || stocks.isEmpty) return 0;
    return stocks.fold<int>(0, (sum, stock) => sum + stock.quantity);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: WHColors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: WHColors.grey5),
        boxShadow: isDetailed == false
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: isDetailed == false
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.productName,
                    style: WHTypography.heading2.copyWith(
                      color: WHColors.primary1,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('SKU', style: WHTypography.caption),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: WHColors.grey4),
                            ),
                            child: Text(
                              product.sku,
                              style: WHTypography.bodyText,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            'Current Stock',
                            style: WHTypography.caption,
                          ),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: '$_totalStock ',
                                  style: WHTypography.heading1.copyWith(
                                    color: WHColors.secondary4,
                                  ),
                                ),
                                TextSpan(
                                  text: product.unitOfMeasure,
                                  style: WHTypography.bodyText.copyWith(
                                    color: WHColors.secondary4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: onView ?? () {},
                      icon: const Icon(Icons.visibility_outlined, size: 18),
                      label: Text(
                        'View',
                        style: WHTypography.bodyText.copyWith(
                          color: WHColors.surface,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: WHColors.primary1,
                        foregroundColor: WHColors.surface,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.productName, style: WHTypography.heading2),
                  Text(product.barcode, style: WHTypography.caption),
                  const SizedBox(
                    height: 16,
                    width: double.infinity,
                    child: Divider(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('SKU', style: WHTypography.caption),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: WHColors.grey),
                            ),
                            child: Text(
                              product.sku,
                              style: WHTypography.bodyText,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            'Current Stock',
                            style: WHTypography.caption,
                          ),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: '$_totalStock ',
                                  style: WHTypography.heading1.copyWith(
                                    color: WHColors.secondary4,
                                  ),
                                ),
                                TextSpan(
                                  text: product.unitOfMeasure,
                                  style: WHTypography.bodyText.copyWith(
                                    color: WHColors.secondary4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      isDetailed == false
                          ? Expanded(
                              child: ElevatedButton(
                                onPressed: onView ?? () {},
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                  backgroundColor: WHColors.primary3,
                                ),
                                child: Text(
                                  'View',
                                  style: WHTypography.bodyText.copyWith(
                                    color: WHColors.surface,
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                      const SizedBox(width: 8),
                      SizedBox(
                        height: 40,
                        child: ElevatedButton(
                          onPressed: onEdit ?? () {},
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            minimumSize: const Size(40, 40),
                            backgroundColor: WHColors.warning2,
                          ),
                          child: const Icon(
                            Icons.edit,
                            size: 20,
                            color: WHColors.surface,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      SizedBox(
                        height: 40,
                        child: ElevatedButton(
                          onPressed: onDelete ?? () {},
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            minimumSize: const Size(40, 40),
                            backgroundColor: WHColors.error2,
                          ),
                          child: const Icon(
                            Icons.delete,
                            size: 20,
                            color: WHColors.surface,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
