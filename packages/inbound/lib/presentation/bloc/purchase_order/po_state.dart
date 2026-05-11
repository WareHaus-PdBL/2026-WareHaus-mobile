import '../../../domain/entities/purchase_order.dart';

abstract class POState {}

class POInitial extends POState {}

class POLoading extends POState {}

class POListLoaded extends POState {
  final List<PurchaseOrder> poList;
  POListLoaded(this.poList);
}

class PODetailLoaded extends POState {
  final PurchaseOrder po;
  PODetailLoaded(this.po);
}

class POCreateSuccess extends POState {
  final PurchaseOrder newPo;
  POCreateSuccess(this.newPo);
}

class POError extends POState {
  final String message;
  POError(this.message);
}