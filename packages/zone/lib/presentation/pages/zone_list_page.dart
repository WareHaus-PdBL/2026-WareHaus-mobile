import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zone/presentation/bloc/zone_bloc.dart';
import 'package:zone/presentation/bloc/zone_event.dart';
import 'package:zone/presentation/bloc/zone_state.dart';
import 'package:zone/presentation/pages/zone_detail_page.dart';
import 'package:zone/presentation/widgets/zone_card.dart';
import 'package:zone/presentation/widgets/zone_loading_skeleton.dart';

class ZoneListPage extends StatefulWidget {
  const ZoneListPage({super.key});

  @override
  State<ZoneListPage> createState() => _ZoneListPageState();
}

class _ZoneListPageState extends State<ZoneListPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<ZoneBloc>().add(GetZonesEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ZoneBloc, ZoneState>(
      builder: (context, state) {
        Widget buildScaffold({required Widget body}) {
          return Scaffold(
            backgroundColor: WHColors.background,
            appBar: AppBar(
              backgroundColor: WHColors.background,
              elevation: 0,
              title: Text(
                'Zone List',
                style: WHTypography.heading1.copyWith(color: WHColors.primary),
              ),
            ),
            body: body,
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              backgroundColor: WHColors.primary,
              child: const Icon(Icons.add, color: Colors.white),
            ),
          );
        }

        if (state is ZoneLoading) {
          return buildScaffold(
            body: ListView.builder(
              itemCount: 4,
              itemExtent: 98,
              cacheExtent: 392,
              addAutomaticKeepAlives: false,
              addRepaintBoundaries: true,
              itemBuilder: (context, index) {
                return const ZoneLoadingSkeleton();
              },
            ),
          );
        } else if (state is ZoneLoaded) {
          return buildScaffold(
            body: ListView.builder(
              key: const PageStorageKey('zone_list_key'),
              itemExtent: 98,
              cacheExtent: 588,
              addAutomaticKeepAlives: false,
              addRepaintBoundaries: true,
              itemCount: state.zones.length,
              itemBuilder: (context, index) {
                return ZoneCard(
                  zone: state.zones[index],
                  onTap: () async {
                    await Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (_, _, _) =>
                            ZoneDetailPage(zoneId: state.zones[index].id),
                        transitionDuration: Duration.zero,
                        reverseTransitionDuration: Duration.zero,
                      ),
                    );
                  },
                );
              },
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
