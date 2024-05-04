import 'package:flutter/material.dart';

import 'common/app_base_button.dart';

class AppPrimaryButton extends AppBaseButton {
  const AppPrimaryButton({
    super.key,
    this.onPressed,
    required this.text,
    this.icon,
    this.trailingIcon,
    this.color,
    super.showLoadingSpinner = false,
    required super.analyticsName,
  });

  final VoidCallback? onPressed;

  final String text;
  final Widget? icon;
  final Widget? trailingIcon;
  final Color? color;

  ButtonStyle? getStyle(BuildContext context) {
    return Theme.of(context).elevatedButtonTheme.style?.copyWith(
      backgroundColor: MaterialStateProperty.resolveWith(
        (states) {
          if (states.contains(MaterialState.disabled)) {
            return Theme.of(context).disabledColor;
          }
          return color ?? Theme.of(context).colorScheme.primary;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var textColor = onPressed == null
        ? const Color.fromARGB(255, 80, 81, 80)
        : Theme.of(context).colorScheme.onPrimary;

    return icon != null
        ? ElevatedButton.icon(
            onPressed: onPressed == null ? null : buttonTap(context, onPressed),
            style: getStyle(context),
            icon: showLoadingSpinner ? Container() : icon!,
            label: FittedBox(
              child: showLoadingSpinner
                  ? loadingWidget(context)
                  : Text(
                      text,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: textColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                    ),
            ),
          )
        : ElevatedButton(
            onPressed: onPressed == null ? null : buttonTap(context, onPressed),
            style: getStyle(context),
            child: FittedBox(
              child: showLoadingSpinner
                  ? loadingWidget(context)
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          text,
                          style:
                              Theme.of(context).textTheme.labelLarge?.copyWith(
                                    color: textColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                        ),
                        if (trailingIcon != null)
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: trailingIcon!,
                          ),
                      ],
                    ),
            ),
          );
  }
}
