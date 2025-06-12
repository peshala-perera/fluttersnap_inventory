import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import '../models/inventory_item.dart';

class DatabaseService {
  // Use the correct database URL from your Firebase console
  final FirebaseDatabase _db = FirebaseDatabase.instanceFor(
    app: Firebase.app(),
    databaseURL: 'https://fluttersnap-inventory-2fb87-default-rtdb.firebaseio.com/',
  );

  DatabaseReference get _ref => _db.ref('inventory');

  Future<void> addItem(InventoryItem item) async {
    await _ref.push().set(item.toMap());
  }

  Future<void> updateItem(String id, InventoryItem item) async {
    await _ref.child(id).update(item.toMap());
  }

  Future<void> deleteItem(String id) async {
    await _ref.child(id).remove();
  }

  Stream<List<InventoryItem>> getItems() {
    return _ref.onValue.map((event) {
      final raw = event.snapshot.value;
      if (raw is Map) {
        final data = Map<String, dynamic>.from(raw);
        return data.entries
            .map((e) =>
                InventoryItem.fromMap(e.key, Map<String, dynamic>.from(e.value)))
            .toList();
      } else {
        return <InventoryItem>[];
      }
    });
  }
}
