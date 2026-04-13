import 'package:flutter/material.dart';

class BottomTitleEditModal extends StatefulWidget {
  const BottomTitleEditModal({
    super.key,
    required this.title,
    required this.onTitleUpdate,
    this.label = 'Update List',
    this.hintText = 'Enter list title',
    this.modalTitle = 'Update List Title',
    this.buttonText = 'Update',
  });

  final String title;
  final void Function(String) onTitleUpdate;
  final String label;
  final String hintText;
  final String modalTitle;
  final String buttonText;
  @override
  State<BottomTitleEditModal> createState() => _BottomTitleEditModalState();
}

class _BottomTitleEditModalState extends State<BottomTitleEditModal> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  bool _isLoading = false;

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
                        widget.modalTitle,
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
                      labelText: widget.label,
                      border: OutlineInputBorder(),
                      hintText: widget.hintText,
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Field cannot be empty';
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
                          onPressed: _isLoading ? null : _updateList,
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
                              : Text(widget.buttonText),
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
