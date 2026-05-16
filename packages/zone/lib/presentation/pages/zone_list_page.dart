import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/presentation/bloc/navigation_bloc.dart';
import 'package:mobile/route_observer.dart';
import 'package:zone/domain/entities/zone.dart';
import 'package:zone/presentation/bloc/zone_bloc.dart';
import 'package:zone/presentation/bloc/zone_event.dart';
import 'package:zone/presentation/bloc/zone_state.dart';
import 'package:zone/presentation/pages/create_zone_page.dart';
import 'package:zone/presentation/pages/zone_detail_page.dart';
import 'package:zone/presentation/widgets/zone_card.dart';

class ZoneListPage extends StatefulWidget {
  const ZoneListPage({super.key});

  @override
  State<ZoneListPage> createState() => _ZoneListPageState();
}

class _ZoneListPageState extends State<ZoneListPage> with RouteAware {
  Future<void> _showEditZoneDialog(Zone zone) async {
    final zoneNameController = TextEditingController(text: zone.zoneName);
    final categoryController = TextEditingController(text: zone.category);
    final descriptionController = TextEditingController(text: zone.description);

    String? toOptionalValue(String initial, String current) {
      if (initial == current) return null;
      return current;
    }

    final shouldSave = await showDialog<bool>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Edit Zone'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: zoneNameController,
                  decoration: const InputDecoration(labelText: 'Zone Name'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: categoryController,
                  decoration: const InputDecoration(labelText: 'Category'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                  maxLines: 3,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              child: const Text('Save'),
            ),
          ],
        );
      },
    );

    if (shouldSave != true || !mounted) {
      zoneNameController.dispose();
      categoryController.dispose();
      descriptionController.dispose();
      return;
    }

    final zoneName = toOptionalValue(
      zone.zoneName,
      zoneNameController.text.trim(),
    );
    final category = toOptionalValue(
      zone.category,
      categoryController.text.trim(),
    );
    final description = toOptionalValue(
      zone.description,
      descriptionController.text.trim(),
    );

    if (zoneName == null && category == null && description == null) {
      zoneNameController.dispose();
      categoryController.dispose();
      descriptionController.dispose();
      return;
    }

    context.read<ZoneBloc>().add(
      UpdateZoneEvent(
        id: zone.id,
        zoneName: zoneName,
        category: category,
        description: description,
      ),
    );

    zoneNameController.dispose();
    categoryController.dispose();
    descriptionController.dispose();
  }

  Future<void> _confirmDeleteZone(Zone zone) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Zone'),
        content: Text('Delete zone "${zone.zoneName}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
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
      context.read<ZoneBloc>().add(DeleteZoneEvent(zone.id));
    }
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<ZoneBloc>().add(GetZonesEvent());
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
    // Only fetch if this page is currently displayed (tab index 2)
    final navigationState = context.read<NavigationBloc>().state;
    if (navigationState.currentIndex == 2) {
      context.read<ZoneBloc>().add(GetZonesEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ZoneBloc, ZoneState>(
      builder: (context, state) {
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
                  const SizedBox(height: 16),
                  const WHSearch(hintText: "Search zones..."),
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

        if (state is ZoneLoading) {
          return buildScaffold(
            body: Center(
              child: CircularProgressIndicator(color: WHColors.primary),
            ),
          );
        } else if (state is ZoneLoaded) {
          return buildScaffold(
            body: state.zones.isEmpty
                ? const Center(
                    child: Text(
                      'No zones available. Tap the + button to create one.',
                      style: WHTypography.bodyText,
                      textAlign: TextAlign.center,
                    ),
                  )
                : Column(
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
                          itemCount: state.zones.length,
                          itemBuilder: (context, index) {
                            return ZoneCard(
                              zone: state.zones[index],
                              onEdit: () =>
                                  _showEditZoneDialog(state.zones[index]),
                              onDelete: () =>
                                  _confirmDeleteZone(state.zones[index]),
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
                                              zone: state.zones[index],
                                            ),
                                        transitionDuration: Duration.zero,
                                        reverseTransitionDuration:
                                            Duration.zero,
                                      ),
                                    );
                                // Pop loading dialog
                                if (!mounted) {
                                  return;
                                }
                                if (navigator.canPop()) {
                                  navigator.pop();
                                }
                                if (changed == true) {
                                  context.read<ZoneBloc>().add(GetZonesEvent());
                                }
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
          );
        } else if (state is ZoneError) {
          return buildScaffold(
            body: Center(
              child: Text(
                'Error: ${state.message}',
                style: const TextStyle(color: Colors.red),
              ),
            ),
          );
        } else {
          return buildScaffold(
            body: const Center(child: Text('No zones available')),
          );
        }
      },
    );
  }
}
