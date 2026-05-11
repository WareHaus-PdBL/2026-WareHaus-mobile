import 'package:flutter_bloc/flutter_bloc.dart';
import 'receiving_event.dart';
import 'receiving_state.dart';
import '../../../domain/usecases/submit_quality_control_report.dart';
import '../../../domain/usecases/get_put_away_suggestion.dart';

class ReceivingBloc extends Bloc<ReceivingEvent, ReceivingState> {
  final SubmitQCReport submitQCReport;
  final GetPutAwaySuggestion getPutAwaySuggestion;

  ReceivingBloc({
    required this.submitQCReport,
    required this.getPutAwaySuggestion,
  }) : super(ReceivingInitial()) {
    
    on<SubmitQCAndGetSuggestion>((event, emit) async {
      emit(ReceivingLoading());
      try {
        // 1. Catat hasil QC ke backend
        await submitQCReport(
          poItemId: event.poItemId,
          qtyReceived: event.qtyReceived,
          condition: event.condition,
          expiryDate: event.expiryDate,
          photoUrl: event.photoUrl,
        );

        // 2. Jika QC sukses, langsung minta saran rak kosong ke algoritma backend
        final suggestion = await getPutAwaySuggestion(event.poItemId);

        // 3. Emit state sukses bersama data instruksi Rak-nya
        emit(PutAwaySuggestionReady(suggestion));
        
      } catch (e) {
        emit(ReceivingError(e.toString()));
      }
    });
  }
}