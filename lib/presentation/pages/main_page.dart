import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/presentation/bloc/navigation_bloc.dart';
import 'package:mobile/presentation/bloc/navigation_event.dart';
import 'package:mobile/presentation/bloc/navigation_state.dart';
import 'package:zone/presentation/pages/zone_list_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return Scaffold(
          body: IndexedStack(
            index: state.currentIndex,
            children: const [
              DesignSystemGalleryPage(),
              Center(child: Text("Products Page")),
              Center(child: Text("Flows Page")),
              ZoneListPage(),              
            ],
          ),
          bottomNavigationBar: WHBottomNav(
            currentIndex: state.currentIndex,
            onTap: (index) {
              context.read<NavigationBloc>().add(ChangeTabEvent(index));
            },
          ),
          /* floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton(
            backgroundColor: WHColors.surface,
            shape: const CircleBorder(),
            onPressed: () {
              // Logika scanner barcode diletakkan di sini
            },
            child: const Icon(Icons.qr_code_scanner, color: Colors.white),
          ),*/
        );
      },
    );
  }
}
