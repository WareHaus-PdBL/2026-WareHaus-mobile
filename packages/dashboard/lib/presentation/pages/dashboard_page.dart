import 'package:core_ui/core_ui.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dashboard/services/dashboard_service.dart';
import 'package:product/presentation/bloc/product_bloc.dart';
import 'package:product/presentation/bloc/product_state.dart';
import 'package:get_it/get_it.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<ActivityLog> recentLogs = [];
  bool isLoading = true;
  String? errorMessage;
  late final DashboardService _service;

  @override
  void initState() {
    super.initState();
    // Get Dio instance from core_services
    final dio = GetIt.instance<Dio>();
    _service = DashboardService(dio);
    _fetchDashboardData();
  }

  Future<void> _fetchDashboardData() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = null;
      });

      final logs = await _service.getRecentLogs(limit: 10);

      if (mounted) {
        setState(() {
          recentLogs = logs;
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          errorMessage = 'Failed to load dashboard data: $e';
          isLoading = false;
        });
      }
      debugPrint('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHColors.background,
      appBar: const WHAppbar(title: 'Dashboard'),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          final productCount = state is ProductLoaded ? state.products.length : 0;

          return WHRefresh(
            onRefresh: () async {
              await _fetchDashboardData();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Stats Card
                  _buildStatCard(
                    title: 'TOTAL PRODUCTS',
                    value: productCount.toString(),
                    subtitle: 'Items Registered',
                    icon: Icons.inventory_2_outlined,
                  ),

                  const SizedBox(height: 24),

                  // Recent Activity Header
                  Text(
                    'RECENT ACTIVITY',
                    style: WHTypography.caption.copyWith(
                      fontWeight: FontWeight.w700,
                      color: WHColors.grey2,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Divider(height: 1, color: WHColors.grey5),
                  const SizedBox(height: 12),

                  // Error Message
                  if (errorMessage != null)
                    Container(
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: WHColors.error2.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: WHColors.error3),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.error_outline, color: WHColors.error2, size: 20),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              errorMessage!,
                              style: WHTypography.caption.copyWith(color: WHColors.error2),
                            ),
                          ),
                        ],
                      ),
                    ),

                  // Loading or Empty
                  if (isLoading)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(40),
                        child: CircularProgressIndicator(),
                      ),
                    )
                  else if (recentLogs.isEmpty)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: WHColors.surface,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: WHColors.grey5),
                      ),
                      child: Column(
                        children: [
                          const Icon(Icons.history, size: 48, color: WHColors.grey3),
                          const SizedBox(height: 12),
                          Text(
                            'No activity yet',
                            style: WHTypography.bodyText.copyWith(color: WHColors.grey2),
                          ),
                        ],
                      ),
                    )
                  else
                    ...recentLogs.map((log) => _buildLogItem(log)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: WHColors.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: WHColors.grey5),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: WHColors.secondary3.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: WHColors.secondary3, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: WHTypography.caption.copyWith(
                    color: WHColors.grey2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: WHTypography.heading1.copyWith(
                    color: WHColors.secondary3,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  subtitle,
                  style: WHTypography.caption.copyWith(color: WHColors.grey2),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogItem(ActivityLog log) {
    final isStockIn = log.isStockIn;
    final color = isStockIn ? WHColors.primary3 : WHColors.secondary3;
    final icon = isStockIn ? Icons.arrow_downward : Icons.arrow_upward;
    final label = isStockIn ? 'Stock In' : 'Stock Out';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: WHColors.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: WHColors.grey5),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        label,
                        style: WHTypography.caption.copyWith(
                          color: color,
                          fontWeight: FontWeight.w600,
                          fontSize: 10,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        log.productName,
                        style: WHTypography.bodyText.copyWith(fontWeight: FontWeight.w600),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  '${log.sku} • ${log.locationName}',
                  style: WHTypography.caption.copyWith(color: WHColors.grey2),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  'Qty: ${log.quantity} → After: ${log.stockAfterMovement}',
                  style: WHTypography.caption.copyWith(color: WHColors.grey2),
                ),
              ],
            ),
          ),
          Text(
            log.time,
            style: WHTypography.caption.copyWith(color: WHColors.grey2),
          ),
        ],
      ),
    );
  }
}