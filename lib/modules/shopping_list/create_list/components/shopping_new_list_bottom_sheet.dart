import 'package:flutter/material.dart';
import 'package:shopping_list/components/modals/app_bottom_sheet.dart';
import 'package:shopping_list/modules/shopping_list/models/shopping_list_model.dart';
import 'package:shopping_list/theme/color_theme.dart';

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
    return AppBottomSheet(
      title: 'Create New List',
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'List Name',
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
            const SizedBox(height: 22),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _createList,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.surface,
                          ),
                        ),
                      )
                    : const Text('Create List'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
