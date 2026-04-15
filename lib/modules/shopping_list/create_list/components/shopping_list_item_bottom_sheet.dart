import 'package:flutter/material.dart';
import 'package:shopping_list/components/modals/app_bottom_sheet.dart';
import 'package:shopping_list/l10n/l10n.dart';
import 'package:shopping_list/theme/color_theme.dart';

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
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final modalButtonTextStyle = theme.textTheme.titleMedium?.copyWith(
      fontSize: 17,
      fontWeight: FontWeight.w700,
    );

    return AppBottomSheet(
      title: l10n.addItemToList,
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
                labelText: l10n.itemName,
                hintText: l10n.enterItemName,
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return l10n.pleaseEnterItemName;
                }
                return null;
              },
              textInputAction: TextInputAction.next,
              autofocus: true,
            ),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.canvas,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: AppColors.ink.withValues(alpha: 0.08),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.quantity,
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: AppColors.ink,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  _QuantityButton(
                    icon: Icons.remove_rounded,
                    onTap: _quantity > 1 ? _decrementQuantity : null,
                  ),
                  Container(
                    width: 58,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: AppColors.ink.withValues(alpha: 0.08),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '$_quantity',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: AppColors.ink,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                  _QuantityButton(
                    icon: Icons.add_rounded,
                    onTap: _incrementQuantity,
                    backgroundColor: AppColors.teal,
                    iconColor: Colors.white,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _addItem,
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
                    : Text(l10n.addItem),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuantityButton extends StatelessWidget {
  const _QuantityButton({
    required this.icon,
    required this.onTap,
    this.backgroundColor = AppColors.surface,
    this.iconColor = AppColors.ink,
  });

  final IconData icon;
  final VoidCallback? onTap;
  final Color backgroundColor;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    final isEnabled = onTap != null;

    return Material(
      color: isEnabled
          ? backgroundColor
          : AppColors.ink.withValues(alpha: 0.06),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: AppColors.ink.withValues(alpha: 0.08)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: SizedBox(
          width: 42,
          height: 42,
          child: Icon(
            icon,
            color: isEnabled
                ? iconColor
                : AppColors.ink.withValues(alpha: 0.35),
            size: 20,
          ),
        ),
      ),
    );
  }
}
