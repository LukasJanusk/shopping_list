import 'package:flutter/material.dart';

class ShoppingListBottomSheet extends StatefulWidget {
  const ShoppingListBottomSheet({super.key, required this.onItemAdded});

  final void Function(Map<String, dynamic> itemData) onItemAdded;

  @override
  State<ShoppingListBottomSheet> createState() =>
      _ShoppingListBottomSheetState();
}

class _ShoppingListBottomSheetState extends State<ShoppingListBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  int _quantity = 1;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _incrementQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decrementQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  void _addItem() {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      final name = _nameController.text.trim();
      widget.onItemAdded({'name': name, 'quantity': _quantity});

      if (mounted) {
        setState(() => _isLoading = false);
        Navigator.pop(context, {'name': name, 'quantity': _quantity});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () => Navigator.pop(context),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Add item to list',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Item Name',
                    border: OutlineInputBorder(),
                    hintText: 'Enter item name',
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter an item name';
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  autofocus: true,
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Text(
                      'Quantity',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: _decrementQuantity,
                      icon: Icon(Icons.remove),
                      color: _quantity > 1
                          ? Theme.of(context).primaryColor
                          : Colors.grey,
                    ),
                    Container(
                      width: 70,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          '$_quantity',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: _incrementQuantity,
                      icon: Icon(Icons.add),
                      color: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
                SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _addItem,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: _isLoading
                        ? SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          )
                        : Text('Add Item'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
