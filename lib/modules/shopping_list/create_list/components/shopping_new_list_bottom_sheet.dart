import 'package:flutter/material.dart';
import 'package:shopping_list/modules/shopping_list/models/shopping_list_model.dart';

class ShoppingNewListBottomSheet extends StatefulWidget {
  const ShoppingNewListBottomSheet({super.key, required this.onListCreated});

  final void Function(ShoppingListModel list) onListCreated;

  @override
  State<ShoppingNewListBottomSheet> createState() =>
      _ShoppingNewListBottomSheetState();
}

class _ShoppingNewListBottomSheetState
    extends State<ShoppingNewListBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _createList() {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      final listName = _nameController.text.trim();
      final newList = ShoppingListModel(name: listName);

      widget.onListCreated(newList);

      if (mounted) {
        setState(() => _isLoading = false);
        Navigator.pop(context);
        Navigator.pushNamed(context, '/shopping-list-info', arguments: newList);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final keyboardInset = MediaQuery.viewInsetsOf(context).bottom;

    return SafeArea(
      top: false,
      child: AnimatedPadding(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        padding: EdgeInsets.only(bottom: keyboardInset),
        child: SingleChildScrollView(
          child: Padding(
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
                        'Create New List',
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
                      labelText: 'List Name',
                      border: OutlineInputBorder(),
                      hintText: 'Enter list name',
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a list name';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.done,
                    autofocus: true,
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _createList,
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 12),
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
                              : Text('Create List'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
