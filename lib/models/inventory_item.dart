class InventoryItem {
  String id;
  String name;
  String category;
  int quantity;
  String location;
  int lastUpdated;

  InventoryItem({
    required this.id,
    required this.name,
    required this.category,
    required this.quantity,
    required this.location,
    required this.lastUpdated,
  });

  factory InventoryItem.fromMap(String key, Map<String, dynamic> map) {
    return InventoryItem(
      id: key,
      name: map['name'],
      category: map['category'],
      quantity: map['quantity'],
      location: map['location'],
      lastUpdated: map['lastUpdated'],
    );
  }

  Map<String, dynamic> toMap() => {
    "name": name,
    "category": category,
    "quantity": quantity,
    "location": location,
    "lastUpdated": lastUpdated,
  };
}
