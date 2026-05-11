import '../entities/put_away_suggestion.dart';
import '../repositories/receiving_repository.dart';

class GetPutAwaySuggestion {
  final ReceivingRepository repository;

  GetPutAwaySuggestion(this.repository);

  Future<PutAwaySuggestion> call(int poItemId) async {
    return await repository.getPutAwaySuggestion(poItemId);
  }
}