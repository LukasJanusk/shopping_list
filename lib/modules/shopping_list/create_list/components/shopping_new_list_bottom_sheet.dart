import 'package:flutter/material.dart';
import 'package:shopping_list/components/modals/app_bottom_sheet.dart';
import 'package:shopping_list/l10n/l10n.dart';
import 'package:shopping_list/modules/shopping_list/models/shopping_list_model.dart';
import 'package:shopping_list/theme/color_theme.dart';

class ShoppingNewListBottomSheet extends StatefulWidget {
  const ShoppingNewListBottomSheet({super.key});

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

      if (mounted) {
        setState(() => _isLoading = false);
        Navigator.pop(context, newList);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final modalButtonTextStyle = Theme.of(context).textTheme.titleMedium
        ?.copyWith(fontSize: 17, fontWeight: FontWeight.w700);

    return AppBottomSheet(
      title: l10n.createListTitle,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: l10n.listName,
                hintText: l10n.enterListName,
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return l10n.pleaseEnterListName;
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
                  textStyle: modalButtonTextStyle,
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
                    : Text(l10n.createList),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
