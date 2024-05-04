import 'package:flutter/material.dart';

import 'common/app_base_button.dart';

class AppTextButton extends AppBaseButton {
  const AppTextButton({
    super.key,
    this.onPressed,
    this.text,
    this.icon,
    this.color,
    super.showLoadingSpinner = false,
    this.fontWeight,
    this.child,
    this.style,
    required super.analyticsName,
  }) : assert(
          (text == null) || (child == null),
          'You cannot use both text and child at the same time',
        );
  final VoidCallback? onPressed;
  final String? text;
  final Widget? icon;
  final Color? color;
  final FontWeight? fontWeight;
  final Widget? child;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return icon != null
        ? TextButton.icon(
            onPressed: onPressed == null ? null : buttonTap(context, onPressed),
            icon: icon!,
            label: _buildLabel(context),
          )
        : TextButton(
            onPressed: onPressed == null ? null : buttonTap(context, onPressed),
            child: child ?? _buildLabel(context),
          );
  }

  FittedBox _buildLabel(BuildContext context) {
    return FittedBox(
      child: Text(
        text ?? '',
        style: style ??
            Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontWeight: fontWeight,
                  color: color ?? Theme.of(context).colorScheme.primary,
                ),
      ),
    );
  }
}
