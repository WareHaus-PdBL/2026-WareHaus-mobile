import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zone/domain/entities/zone.dart';
import 'package:zone/presentation/bloc/zone_bloc.dart';
import 'package:zone/presentation/bloc/zone_event.dart';
import 'package:zone/presentation/bloc/zone_state.dart';
import 'package:zone/presentation/widgets/zone_detail_card.dart';
import 'package:zone/presentation/widgets/zone_visualizer.dart';

class ZoneDetailPage extends StatefulWidget {
  final Zone? zone;
  final String? zoneId;
  final String? zoneName;

  const ZoneDetailPage({super.key, this.zone, this.zoneId, this.zoneName});

  @override
  State<ZoneDetailPage> createState() => _ZoneDetailPageState();
}

class _ZoneDetailPageState extends State<ZoneDetailPage> {
  @override
  void initState() {
    super.initState();
    final zoneId = widget.zone?.id ?? widget.zoneId;
    final needsDetailsFetch =
        widget.zone == null ||
        widget.zone?.shelves == null ||
        widget.zone!.shelves!.isEmpty;

    if (zoneId != null && needsDetailsFetch) {
      Future.microtask(() {
        context.read<ZoneBloc>().add(GetZoneDetailsEvent(zoneId: zoneId));
      });
    }
  }

  void _loadZoneDetails() {
    final zoneId = widget.zone?.id ?? widget.zoneId;
    if (zoneId != null) {
      context.read<ZoneBloc>().add(GetZoneDetailsEvent(zoneId: zoneId));
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget buildScaffold({required Widget body}) {
      return Scaffold(
        backgroundColor: WHColors.background,
        appBar: WHAppbar(
          title:
              'Zone ${widget.zone?.zoneName ?? widget.zoneName ?? widget.zoneId ?? ''}',
        ),
        body: Container(
          color: WHColors.background,
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Text(
                "All Zones > ${widget.zone?.zoneName ?? widget.zoneName}",
                style: WHTypography.caption,
              ),
              const SizedBox(height: 16),
              Expanded(child: body),
            ],
          ),
        ),
      );
    }

    return BlocBuilder<ZoneBloc, ZoneState>(
      builder: (context, state) {
        final loadedZone = state is ZoneLoaded && state.zones.isNotEmpty
            ? state.zones.first
            : null;
        final zoneToDisplay = loadedZone ?? widget.zone;

        if (zoneToDisplay != null &&
            zoneToDisplay.shelves != null &&
            zoneToDisplay.shelves!.isNotEmpty) {
          return buildScaffold(
            body: WHRefresh(
              onRefresh: () async {
                _loadZoneDetails();
              },
              child: Column(
                children: [
                  ZoneDetailCard(zone: zoneToDisplay),
                  const SizedBox(height: 16),
                  Expanded(child: ZoneVisualizer(zone: zoneToDisplay)),
                ],
              ),
            ),
          );
        }

        if (state is ZoneLoading) {
          return buildScaffold(
            body: const Center(child: CircularProgressIndicator()),
          );
        } else if (state is ZoneLoaded) {
          if (state.zones.isEmpty) {
            return buildScaffold(
              body: const Center(child: Text('Zone not found')),
            );
          }
          final zone = state.zones.first;
          return buildScaffold(
            body: WHRefresh(
              onRefresh: () async {
                _loadZoneDetails();
              },
              child: Column(
                children: [
                  // WHSearch(hintText: 'Search Zone...'),
                  // const SizedBox(height: 16),
                  ZoneDetailCard(zone: zone),
                  const SizedBox(height: 16),
                  Expanded(child: ZoneVisualizer(zone: zone)),
                ],
              ),
            ),
          );
        } else if (state is ZoneError) {
          return buildScaffold(
            body: WHRefresh(
              onRefresh: () async {
                _loadZoneDetails();
              },
              child: Center(child: Text(state.message)),
            ),
          );
        }
        return buildScaffold(
          body: const Center(child: Text('No zone data available')),
        );
      },
    );
  }
}