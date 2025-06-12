import 'package:flutter/material.dart';
import '../models/inventory_item.dart';
import '../services/database_service.dart';
import '../widgets/item_card.dart';
import 'add_edit_item.dart';

class HomeScreen extends StatelessWidget {
  final DatabaseService _db = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Inventory')),
      body: StreamBuilder<List<InventoryItem>>(
        stream: _db.getItems(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          final items = snapshot.data!;
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (_, i) => ItemCard(item: items[i]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_circle_outline),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => AddEditItem()),
        ),
      ),
    );
  }
}
