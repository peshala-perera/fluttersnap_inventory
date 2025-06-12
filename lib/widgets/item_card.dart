import 'package:flutter/material.dart';
import '../models/inventory_item.dart';
import '../screens/add_edit_item.dart';
import '../services/database_service.dart';

class ItemCard extends StatelessWidget {
  final InventoryItem item;
  final _db = DatabaseService();

  ItemCard({required this.item});

  @override
  Widget build(BuildContext context) => Card(
    margin: EdgeInsets.all(8),
    child: ListTile(
      title: Text(item.name),
      subtitle: Text('${item.quantity} pcs • ${item.category} • ${item.location}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(icon: Icon(Icons.edit_outlined), onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (_) => AddEditItem(item: item),
            ));
          }),
          IconButton(icon: Icon(Icons.delete_outline), onPressed: () {
            _db.deleteItem(item.id);
          }),
        ],
      ),
    ),
  );
}
