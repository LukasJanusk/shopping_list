import 'package:flutter/material.dart';
import 'package:shopping_list/components/modals/app_bottom_sheet.dart';
import 'package:shopping_list/l10n/l10n.dart';
import 'package:shopping_list/theme/color_theme.dart';

class BottomTitleEditModal extends StatefulWidget {
  const BottomTitleEditModal({
    super.key,
    required this.title,
    required this.onTitleUpdate,
    this.label,
    this.hintText,
    this.modalTitle,
    this.buttonText,
  });

  final String title;
  final void Function(String) onTitleUpdate;
  final String? label;
  final String? hintText;
  final String? modalTitle;
  final String? buttonText;
  @override
  State<BottomTitleEditModal> createState() => _BottomTitleEditModalState();
}

class _BottomTitleEditModalState extends State<BottomTitleEditModal> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.title;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _updateList() {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      final titleName = _nameController.text.trim();
      widget.onTitleUpdate(titleName);

      if (mounted) {
        setState(() => _isLoading = false);
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final modalButtonTextStyle = Theme.of(context).textTheme.titleMedium
        ?.copyWith(fontSize: 17, fontWeight: FontWeight.w700);

    return AppBottomSheet(
      title: widget.modalTitle ?? l10n.updateListTitle,
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
                labelText: widget.label ?? l10n.updateList,
                hintText: widget.hintText ?? l10n.enterListTitle,
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return l10n.fieldCannotBeEmpty;
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
                onPressed: _isLoading ? null : _updateList,
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
                    : Text(widget.buttonText ?? l10n.update),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
