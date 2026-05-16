import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:product/domain/entities/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final bool? isDetailed;
  final int? shelfStock;
  final VoidCallback? onView;
  final VoidCallback? onPrint;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  const ProductCard({
    super.key,
    required this.product,
    this.isDetailed = false,
    this.shelfStock,
    this.onView,
    this.onPrint,
    this.onEdit,
    this.onDelete,
  });

  int get _totalStock {
    final stocks = product.stocks;
    if (stocks == null || stocks.isEmpty) return 0;
    return stocks.fold<int>(0, (sum, stock) => sum + stock.quantity);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: WHColors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: WHColors.grey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(product.productName, style: WHTypography.heading2),
          Text(product.barcode, style: WHTypography.caption),
          const SizedBox(height: 16, width: double.infinity, child: Divider()),
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
                    child: Text(product.sku, style: WHTypography.bodyText),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text('Current Stock', style: WHTypography.caption),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text:
                              '${shelfStock != null ? shelfStock : product.currentStock}',
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
          // Actions: show full-width 'View' button in list mode,
          // or a row of compact buttons in detailed mode.
          if (isDetailed == false)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onView ?? () {},
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  backgroundColor: WHColors.primary1,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'View',
                      style: WHTypography.bodyText.copyWith(
                        color: WHColors.surface,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.remove_red_eye_outlined,
                      size: 16,
                      color: WHColors.surface,
                    ),
                  ],
                ),
              ),
            )
          else
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    onPressed: onPrint ?? () {},
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      backgroundColor: WHColors.surface,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      side: BorderSide(color: WHColors.secondary3),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.print_outlined,
                          size: 20,
                          color: WHColors.secondary3,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Print',
                          style: WHTypography.bodyText.copyWith(
                            color: WHColors.secondary3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    onPressed: onEdit ?? () {},
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      backgroundColor: WHColors.surface,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      side: BorderSide(color: WHColors.primary5),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.edit_outlined,
                          size: 20,
                          color: WHColors.primary3,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Edit',
                          style: WHTypography.bodyText.copyWith(
                            color: WHColors.primary3,
                          ),
                        ),
                      ],
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
                      backgroundColor: WHColors.surface,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      side: BorderSide(color: WHColors.error3),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.delete_outlined,
                          size: 20,
                          color: WHColors.error2,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Delete',
                          style: WHTypography.bodyText.copyWith(
                            color: WHColors.error2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
