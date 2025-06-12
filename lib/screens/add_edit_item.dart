import 'package:flutter/material.dart';
import '../models/inventory_item.dart';
import '../services/database_service.dart';

class AddEditItem extends StatefulWidget {
  final InventoryItem? item;

  AddEditItem({this.item});

  @override
  _AddEditItemState createState() => _AddEditItemState();
}

class _AddEditItemState extends State<AddEditItem> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String category = '';
  String location = '';
  int quantity = 0;
  final _db = DatabaseService();

  @override
  void initState() {
    super.initState();
    if (widget.item != null) {
      name = widget.item!.name;
      category = widget.item!.category;
      location = widget.item!.location;
      quantity = widget.item!.quantity;
    }
  }

  void _saveItem() {
    if (_formKey.currentState!.validate()) {
      final item = InventoryItem(
        id: widget.item?.id ?? '',
        name: name,
        category: category,
        quantity: quantity,
        location: location,
        lastUpdated: DateTime.now().millisecondsSinceEpoch,
      );

      if (widget.item == null) {
        _db.addItem(item);
      } else {
        _db.updateItem(widget.item!.id, item);
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(widget.item == null ? 'Add Item' : 'Edit Item')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            TextFormField(
              initialValue: name,
              decoration: InputDecoration(labelText: 'Name'),
              onChanged: (val) => name = val,
              validator: (val) => val!.isEmpty ? 'Required' : null,
            ),
            TextFormField(
              initialValue: category,
              decoration: InputDecoration(labelText: 'Category'),
              onChanged: (val) => category = val,
              validator: (val) => val!.isEmpty ? 'Required' : null,
            ),
            TextFormField(
              initialValue: location,
              decoration: InputDecoration(labelText: 'Location'),
              onChanged: (val) => location = val,
              validator: (val) => val!.isEmpty ? 'Required' : null,
            ),
            TextFormField(
              initialValue: quantity.toString(),
              decoration: InputDecoration(labelText: 'Quantity'),
              keyboardType: TextInputType.number,
              onChanged: (val) => quantity = int.tryParse(val) ?? 0,
              validator: (val) => (int.tryParse(val!) == null) ? 'Enter number' : null,
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _saveItem, child: Text('Save')),
          ],
        ),
      ),
    ),
  );
}
