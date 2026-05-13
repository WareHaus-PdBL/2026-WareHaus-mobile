import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zone/presentation/bloc/zone_bloc.dart';
import 'package:zone/presentation/bloc/zone_event.dart';
import 'package:zone/presentation/bloc/zone_state.dart';
import 'package:zone/presentation/widgets/zone_aisle_visualizer.dart';

class ZoneAisleDetailPage extends StatefulWidget {
  final String zoneId;
  final String zoneCode;
  final int aisleNumber;

  const ZoneAisleDetailPage({
    super.key,
    required this.zoneId,
    required this.zoneCode,
    required this.aisleNumber,
  });

  @override
  State<ZoneAisleDetailPage> createState() => _ZoneAisleDetailPageState();
}

class _ZoneAisleDetailPageState extends State<ZoneAisleDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<ZoneBloc>().add(
        GetZoneByAisleEvent(
          zoneId: widget.zoneId,
          aisleNumber: widget.aisleNumber,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ZoneBloc, ZoneState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: WHColors.background,
          appBar: WHAppbar(
            title:
                'Aisle ${widget.aisleNumber > 9 ? widget.aisleNumber : '0${widget.aisleNumber}'}',
          ),
          body: Container(
            color: WHColors.background,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Text(
                  "All Zones > ${widget.zoneCode} > Aisle ${widget.aisleNumber > 9 ? widget.aisleNumber : '0${widget.aisleNumber}'}",
                  style: WHTypography.caption,
                ),
                const SizedBox(height: 16),
                Expanded(child: _buildContent(state)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildContent(ZoneState state) {
    if (state is ZoneLoading) {
      return Center(child: CircularProgressIndicator(color: WHColors.primary));
    } else if (state is ZoneLoaded) {
      if (state.zones.isEmpty) {
        return const Center(child: Text('Aisle not found'));
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WHSearch(hintText: 'Search Shelf...'),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                backgroundColor: WHColors.surface,
                side: const BorderSide(color: Colors.black),
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text(
                'Print QR Code All Shelf',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(child: ZoneAisleVisualizer(zone: state.zones.first)),
        ],
      );
    } else if (state is ZoneError) {
      return Center(child: Text('Error: ${state.message}'));
    }
    return const Center(child: Text('No aisle data available'));
  }
}
