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
    // Only fetch if zone object not provided
    if (widget.zone == null && widget.zoneId != null) {
      Future.microtask(() {
        context.read<ZoneBloc>().add(
          GetZoneDetailsEvent(zoneId: widget.zoneId!),
        );
      });
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
        // If zone is provided directly, use it
        if (widget.zone != null) {
          return buildScaffold(
            body: Column(
              children: [
                WHSearch(hintText: 'Search Zone...'),
                const SizedBox(height: 16),
                ZoneDetailCard(zone: widget.zone!),
                const SizedBox(height: 16),
                Expanded(child: ZoneVisualizer(zone: widget.zone!)),
              ],
            ),
          );
        }

        // Otherwise use bloc state
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
            body: Column(
              children: [
                WHSearch(hintText: 'Search Zone...'),
                const SizedBox(height: 16),
                ZoneDetailCard(zone: zone),
                const SizedBox(height: 16),
                Expanded(child: ZoneVisualizer(zone: zone)),
              ],
            ),
          );
        } else if (state is ZoneError) {
          return buildScaffold(body: Center(child: Text(state.message)));
        }
        return buildScaffold(
          body: const Center(child: Text('No zone data available')),
        );
      },
    );
  }
}
