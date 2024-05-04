import 'package:flutter/material.dart';

import 'common/app_base_button.dart';

class AppOutlinedButton extends AppBaseButton {
  const AppOutlinedButton({
    super.key,
    this.onTap,
    this.text,
    this.icon,
    this.textColor,
    super.showLoadingSpinner = false,
    this.backgroundColor,
    this.borderColor,
    this.child,
    required super.analyticsName,
    this.isCircle = false,
    this.size,
  });

  final VoidCallback? onTap;
  final String? text;
  final Widget? icon;
  final Color? textColor;
  final Color? borderColor;
  final Color? backgroundColor;
  final Widget? child;
  final bool isCircle;
  final Size? size;

  @override
  Widget build(BuildContext context) {
    var disabledColor = Colors.grey.withOpacity(0.5);
    ButtonStyle? buttonStyle =
        Theme.of(context).outlinedButtonTheme.style?.copyWith(
              backgroundColor: MaterialStatePropertyAll(
                backgroundColor ?? Colors.transparent,
              ),
              foregroundColor: MaterialStatePropertyAll(
                onTap == null ? null : textColor,
              ),
              side: MaterialStatePropertyAll(
                BorderSide(
                  width: 2,
                  color: onTap == null
                      ? disabledColor
                      : borderColor ?? Theme.of(context).colorScheme.primary,
                ),
              ),
              minimumSize: size == null
                  ? null
                  : MaterialStatePropertyAll(
                      size,
                    ),
              maximumSize: size == null
                  ? null
                  : MaterialStatePropertyAll(
                      size,
                    ),
              shape: isCircle
                  ? const MaterialStatePropertyAll(CircleBorder())
                  : null,
            );

    return icon != null
        ? OutlinedButton.icon(
            onPressed: onTap == null ? null : buttonTap(context, onTap),
            icon: icon!,
            style: buttonStyle,
            label: child ?? _buildText(context, disabledColor),
          )
        : OutlinedButton(
            onPressed: onTap == null ? null : buttonTap(context, onTap),
            style: buttonStyle,
            child: child ?? _buildText(context, disabledColor),
          );
  }

  Widget _buildText(BuildContext context, Color disabled) {
    if (text == null) return const SizedBox();
    TextStyle? textStyle = Theme.of(context).textTheme.titleMedium?.copyWith(
          color: onTap == null
              ? disabled
              : textColor ?? Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
        );
    return FittedBox(
      child: showLoadingSpinner
          ? loadingWidget(
              context,
              color: textColor ?? Theme.of(context).colorScheme.primary,
            )
          : Text(
              text ?? '',
              style: textStyle,
            ),
    );
  }
}
