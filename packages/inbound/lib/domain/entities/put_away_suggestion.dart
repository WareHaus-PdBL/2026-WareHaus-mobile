class PutAwaySuggestion {
  final String orderNumber;
  final int currentItemIndex;
  final int totalItems;
  
  final String locationText;
  
  final String productSku;
  final String productName;
  final String? productImageUrl; 
  final int requiredQty;
  
  final List<UpcomingLocation> upcomingLocations;

  const PutAwaySuggestion({
    required this.orderNumber,
    required this.currentItemIndex,
    required this.totalItems,
    required this.locationText,
    required this.productSku,
    required this.productName,
    this.productImageUrl,
    required this.requiredQty,
    this.upcomingLocations = const [],
  });
}

// Entitas untuk list "Upcoming" di bagian bawah layar
class UpcomingLocation {
  final String locationName; 
  final int qty;             

  const UpcomingLocation({
    required this.locationName,
    required this.qty,
  });
}