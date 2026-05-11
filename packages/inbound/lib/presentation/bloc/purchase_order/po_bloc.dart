import 'package:flutter_bloc/flutter_bloc.dart';
import 'po_event.dart';
import 'po_state.dart';
import '../../../domain/usecases/get_purchase_orders.dart';
import '../../../domain/usecases/get_purchase_order_details.dart';
import '../../../domain/usecases/create_purchase_order.dart';

class POBloc extends Bloc<POEvent, POState> {
  final GetPurchaseOrders getPurchaseOrders;
  final GetPODetails getPODetails;
  final CreatePurchaseOrder createPurchaseOrder;

  POBloc({
    required this.getPurchaseOrders,
    required this.getPODetails,
    required this.createPurchaseOrder,
  }) : super(POInitial()) {
    
    // Saat layar meminta daftar PO
    on<LoadPOList>((event, emit) async {
      emit(POLoading());
      try {
        final poList = await getPurchaseOrders(); // Memanggil Usecase (call)
        emit(POListLoaded(poList));
      } catch (e) {
        emit(POError(e.toString()));
      }
    });

    // Saat layar meminta detail satu PO
    on<LoadPODetails>((event, emit) async {
      emit(POLoading());
      try {
        final po = await getPODetails(event.id);
        emit(PODetailLoaded(po));
      } catch (e) {
        emit(POError(e.toString()));
      }
    });

    // Saat tombol Simpan PO ditekan
    on<SubmitNewPO>((event, emit) async {
      emit(POLoading());
      try {
        final newPo = await createPurchaseOrder(
          poNumber: event.poNumber,
          supplierName: event.supplierName,
          items: event.items,
        );
        emit(POCreateSuccess(newPo));
      } catch (e) {
        emit(POError(e.toString()));
      }
    });
  }
}