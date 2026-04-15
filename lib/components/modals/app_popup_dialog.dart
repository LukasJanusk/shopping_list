import 'package:flutter/material.dart';
import 'package:shopping_list/theme/app_decorations.dart';
import 'package:shopping_list/theme/color_theme.dart';

enum AppPopupDialogVariant { neutral, success, danger }

Future<T?> showAppPopupDialog<T>({
  required BuildContext context,
  required String title,
  required String message,
  required String confirmLabel,
  required VoidCallback onConfirm,
  String cancelLabel = 'Cancel',
  AppPopupDialogVariant variant = AppPopupDialogVariant.neutral,
  IconData? icon,
}) {
  return showDialog<T>(
    context: context,
    builder: (dialogContext) => AppPopupDialog(
      title: title,
      message: message,
      confirmLabel: confirmLabel,
      cancelLabel: cancelLabel,
      variant: variant,
      icon: icon,
      onConfirm: () {
        onConfirm();
        Navigator.pop(dialogContext);
      },
      onCancel: () => Navigator.pop(dialogContext),
    ),
  );
}

class AppPopupDialog extends StatelessWidget {
  const AppPopupDialog({
    super.key,
    required this.title,
    required this.message,
    required this.confirmLabel,
    required this.cancelLabel,
    required this.onConfirm,
    required this.onCancel,
    this.variant = AppPopupDialogVariant.neutral,
    this.icon,
  });

  final String title;
  final String message;
  final String confirmLabel;
  final String cancelLabel;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;
  final AppPopupDialogVariant variant;
  final IconData? icon;

  Color get _accentColor {
    switch (variant) {
      case AppPopupDialogVariant.success:
        return AppColors.teal;
      case AppPopupDialogVariant.danger:
        return AppColors.error;
      case AppPopupDialogVariant.neutral:
        return AppColors.ink;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      backgroundColor: AppColors.surface,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
      contentPadding: const EdgeInsets.fromLTRB(24, 0, 24, 8),
      actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null) ...[
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: _accentColor.withAlpha(20),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: _accentColor),
            ),
            const SizedBox(width: 14),
          ],
          Expanded(
            child: Text(
              title,
              style: theme.textTheme.headlineSmall?.copyWith(
                color: AppColors.ink,
                fontSize: 24,
              ),
            ),
          ),
        ],
      ),
      content: Text(
        message,
        style: theme.textTheme.bodyLarge?.copyWith(
          color: AppColors.inkSoft,
          fontSize: 15,
          height: 1.4,
        ),
      ),
      actions: [
        OutlinedButton(
          onPressed: onCancel,
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.ink,
            side: BorderSide(color: AppColors.inkSoft.withAlpha(48)),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: AppDecorations.buttonRadius,
            ),
          ),
          child: Text(cancelLabel),
        ),
        ElevatedButton(
          onPressed: onConfirm,
          style: AppDecorations.actionButtonStyle(
            backgroundColor: _accentColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          ),
          child: Text(confirmLabel),
        ),
      ],
    );
  }
}
