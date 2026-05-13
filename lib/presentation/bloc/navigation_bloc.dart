import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/presentation/bloc/navigation_event.dart';
import 'package:mobile/presentation/bloc/navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationState(currentIndex: 0)) {
    on<ChangeTabEvent>((event, emit) {
      emit(NavigationState(currentIndex: event.index));
    });
  }
}
