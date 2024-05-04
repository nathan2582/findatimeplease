import 'package:flutter/material.dart';

import 'common/app_base_button.dart';

class AppIconButton extends AppBaseButton {
  const AppIconButton({
    super.key,
    this.onPressed,
    required this.icon,
    super.showLoadingSpinner = false,
    this.visualDensity,
    required super.analyticsName,
    this.outline = false,
  });

  final VoidCallback? onPressed;
  final Widget icon;
  final VisualDensity? visualDensity;
  final bool outline;

  @override
  Widget build(BuildContext context) {
    return outline
        ? OutlinedButton(
            style: Theme.of(context).outlinedButtonTheme.style?.copyWith(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Theme.of(context).colorScheme.background,
                  ),
                  side: MaterialStateProperty.all<BorderSide>(
                    BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                      width: 2,
                    ),
                  ),
                ),
            onPressed: onPressed == null ? null : buttonTap(context, onPressed),
            child: icon,
          )
        : IconButton(
            padding: EdgeInsets.zero,
            onPressed: onPressed == null ? null : buttonTap(context, onPressed),
            icon: showLoadingSpinner ? loadingWidget(context) : icon,
            visualDensity: visualDensity,
          );
  }
}
