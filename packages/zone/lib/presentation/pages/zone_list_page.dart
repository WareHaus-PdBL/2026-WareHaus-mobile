import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zone/presentation/bloc/zone_bloc.dart';
import 'package:zone/presentation/bloc/zone_event.dart';
import 'package:zone/presentation/bloc/zone_state.dart';
import 'package:zone/presentation/pages/zone_detail_page.dart';
import 'package:zone/presentation/widgets/zone_card.dart';

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
                  Expanded(child: body),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
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
            body: Column(
              children: [
                const WHSearch(hintText: "Search zones..."),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
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
