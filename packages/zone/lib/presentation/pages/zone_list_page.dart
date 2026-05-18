import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/presentation/bloc/navigation_bloc.dart';
import 'package:mobile/presentation/bloc/navigation_state.dart';
import 'package:mobile/route_observer.dart';
import 'package:zone/domain/entities/zone.dart';
import 'package:zone/presentation/bloc/zone_bloc.dart';
import 'package:zone/presentation/bloc/zone_event.dart';
import 'package:zone/presentation/bloc/zone_state.dart';
import 'package:zone/presentation/pages/create_zone_page.dart';
import 'package:zone/presentation/pages/zone_detail_page.dart';
import 'package:zone/presentation/widgets/zone_card.dart';
import 'package:zone/presentation/widgets/zone_edit_dialog.dart';

class ZoneListPage extends StatefulWidget {
  const ZoneListPage({super.key});

  @override
  State<ZoneListPage> createState() => _ZoneListPageState();
}

class _ZoneListPageState extends State<ZoneListPage> with RouteAware {
  bool _hasShownSwipeHint = false;

  void _showSwipeHintIfNeeded() {
    if (!mounted || _hasShownSwipeHint) return;

    _hasShownSwipeHint = true;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text(
            'Geser kartu zone ke kiri untuk melihat menu Edit dan Delete.',
          ),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 4),
        ),
      );
  }

  Future<void> _showEditZoneDialog(Zone zone) async {
    final bloc = context.read<ZoneBloc>();

    String? toOptionalValue(String initial, String current) {
      if (initial == current) return null;
      return current;
    }

    final edited = await showZoneEditDialog(context, zone);

    // Tunggu satu frame agar dialog sepenuhnya di-dispose sebelum
    // men-dispatch event ke bloc. Ini mencegah error _dependents.isEmpty
    // yang terjadi karena race condition antara dialog disposal dan
    // state change dari BLoC.
    // Tunggu hingga frame berikutnya selesai di-render (bukan hanya microtask)
    // agar dialog widget sepenuhnya di-dispose dari tree sebelum BLoC
    // emit state baru. Ini mencegah assertion _dependents.isEmpty.
    await Future.delayed(Duration.zero);

    if (edited == null || !mounted) return;

    final zoneName = toOptionalValue(zone.zoneName, edited.zoneName);
    final category = toOptionalValue(zone.category, edited.category);
    final description = toOptionalValue(zone.description, edited.description);

    if (zoneName == null && category == null && description == null) return;

    bloc.add(
      UpdateZoneEvent(
        id: zone.id,
        zoneName: zoneName,
        category: category,
        description: description,
      ),
    );
  }

  Future<void> _confirmDeleteZone(Zone zone) async {
    final bloc = context.read<ZoneBloc>();

    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: WHColors.surface,
        title: const Text('Delete Zone', style: WHTypography.heading1),
        content: Text(
          'Delete zone "${zone.zoneName}"?',
          style: WHTypography.bodyText,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text(
              'Cancel',
              style: TextStyle(color: WHColors.grey3),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: ElevatedButton.styleFrom(backgroundColor: WHColors.error2),
            child: const Text('Delete', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    if (shouldDelete == true && mounted) {
      bloc.add(DeleteZoneEvent(zone.id));
    }
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<ZoneBloc>().add(GetZonesEvent());
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final navigationState = context.read<NavigationBloc>().state;
      if (navigationState.currentIndex == 2) {
        _showSwipeHintIfNeeded();
      }
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
    final navigationState = context.read<NavigationBloc>().state;
    if (navigationState.currentIndex == 2) {
      context.read<ZoneBloc>().add(GetZonesEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NavigationBloc, NavigationState>(
      listenWhen: (previous, current) =>
          previous.currentIndex != current.currentIndex,
      listener: (context, state) {
        if (state.currentIndex == 2) {
          _showSwipeHintIfNeeded();
          context.read<ZoneBloc>().add(GetZonesEvent());
        }
      },
      child: BlocListener<ZoneBloc, ZoneState>(
        // Tangkap ZoneError → tampilkan snackbar, jangan ubah UI halaman
        listenWhen: (previous, current) => current is ZoneError,
        listener: (context, state) {
          if (state is ZoneError) {
            WHSnackBar.showError(context, state.message);
          }
        },
        child: BlocBuilder<ZoneBloc, ZoneState>(
        // Rebuild saat ZoneOperationSuccess agar list ter-update
        // ZoneError TIDAK masuk buildWhen supaya list tidak blank saat error
        buildWhen: (previous, current) =>
            current is ZoneLoading ||
            current is ZoneLoaded ||
            current is ZoneOperationSuccess,
        builder: (context, state) {
          // Treat ZoneOperationSuccess sama seperti ZoneLoaded untuk tampilan list
          final effectiveState = state is ZoneOperationSuccess
              ? ZoneLoaded(state.zones)
              : state;
          Widget buildScaffold({required Widget body}) {
            return Scaffold(
              backgroundColor: WHColors.background,
              appBar: WHAppbar(title: 'Zone Management'),
              body: Container(
                color: WHColors.background,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Zone Hierarchy", style: WHTypography.heading1),
                        Text(
                          "Manage your warehouse zones efficiently",
                          style: WHTypography.caption,
                        ),
                      ],
                    ),
                    // const SizedBox(height: 16),
                    // const WHSearch(hintText: "Search zones..."),
                    Expanded(child: body),
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () async {
                  final navigator = Navigator.of(context);
                  await navigator.push(
                    PageRouteBuilder(
                      pageBuilder: (_, _, _) => const CreateZonePage(),
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero,
                    ),
                  );
                },
                backgroundColor: WHColors.primary,
                child: const Icon(Icons.add, color: Colors.white),
              ),
            );
          }

          if (effectiveState is ZoneLoading) {
            return buildScaffold(
              body: Center(
                child: CircularProgressIndicator(color: WHColors.primary),
              ),
            );
          } else if (effectiveState is ZoneLoaded) {
            return buildScaffold(
              body: effectiveState.zones.isEmpty
                  ? const Center(
                      child: Text(
                        'No zones available. Tap the + button to create one.',
                        style: WHTypography.bodyText,
                        textAlign: TextAlign.center,
                      ),
                    )
                  : WHRefresh(
                      onRefresh: () async {
                        context.read<ZoneBloc>().add(GetZonesEvent());
                      },
                      child: Column(
                        children: [
                          const SizedBox(height: 16),
                          Expanded(
                            child: ListView.separated(
                              key: const PageStorageKey('zone_list_key'),
                              cacheExtent: 588,
                              addAutomaticKeepAlives: false,
                              addRepaintBoundaries: true,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 16),
                              itemCount: effectiveState.zones.length,
                              itemBuilder: (context, index) {
                                return ZoneCard(
                                  zone: effectiveState.zones[index],
                                  onEdit: () => _showEditZoneDialog(
                                    effectiveState.zones[index],
                                  ),
                                  onDelete: () => _confirmDeleteZone(
                                    effectiveState.zones[index],
                                  ),
                                  onTap: () async {
                                    final navigator = Navigator.of(context);
                                    showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (ctx) => Center(
                                        child: CircularProgressIndicator(
                                          color: WHColors.primary,
                                        ),
                                      ),
                                    );
                                    final changed = await Navigator.of(context)
                                        .push<bool>(
                                          PageRouteBuilder(
                                            pageBuilder: (_, _, _) =>
                                                ZoneDetailPage(
                                                  zoneId: effectiveState
                                                      .zones[index]
                                                      .id,
                                                  zoneName: effectiveState
                                                      .zones[index]
                                                      .zoneName,
                                                ),
                                            transitionDuration: Duration.zero,
                                            reverseTransitionDuration:
                                                Duration.zero,
                                          ),
                                        );
                                    if (!mounted) {
                                      return;
                                    }
                                    if (navigator.canPop()) {
                                      navigator.pop();
                                    }
                                    if (changed == true) {
                                      context.read<ZoneBloc>().add(
                                        GetZonesEvent(),
                                      );
                                    }
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
            );
          } else {
            return buildScaffold(
              body: const Center(child: Text('No zones available')),
            );
          }
        },
        ),
      ),
    );
  }
}