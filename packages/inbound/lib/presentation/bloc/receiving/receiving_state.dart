import '../../../domain/entities/put_away_suggestion.dart';

abstract class ReceivingState {}

class ReceivingInitial extends ReceivingState {}

class ReceivingLoading extends ReceivingState {}

class PutAwaySuggestionReady extends ReceivingState {
  final PutAwaySuggestion suggestion;
  PutAwaySuggestionReady(this.suggestion);
}

class ReceivingError extends ReceivingState {
  final String message;
  ReceivingError(this.message);
}