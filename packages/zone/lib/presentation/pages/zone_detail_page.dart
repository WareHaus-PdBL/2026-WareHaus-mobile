import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zone/domain/entities/zone.dart';
import 'package:zone/presentation/bloc/zone_bloc.dart';
import 'package:zone/presentation/widgets/zone_visualizer.dart';

class ZoneDetailPage extends StatefulWidget {
  final String zoneId;

  const ZoneDetailPage({super.key, required this.zoneId});

  @override
  State<ZoneDetailPage> createState() => _ZoneDetailPageState();
}

class _ZoneDetailPageState extends State<ZoneDetailPage> {
  late Future<Zone> _zoneFuture;

  @override
  void initState() {
    super.initState();
    _zoneFuture = context.read<ZoneBloc>().getZoneDetailsUsecase(widget.zoneId);
  }

  @override
  Widget build(BuildContext context) {
    Widget buildScaffold({required Widget body}) {
      return Scaffold(
        backgroundColor: WHColors.background,
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          elevation: 0,
          title: const Text(
            'Zone Details',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: body,
      );
    }

    return FutureBuilder<Zone>(
      future: _zoneFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return buildScaffold(
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return buildScaffold(
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        }

        final zone = snapshot.data;
        if (zone == null) {
          return buildScaffold(body: const SizedBox());
        }

        return buildScaffold(body: ZoneVisualizer(zone: zone));
      },
    );
  }
}
