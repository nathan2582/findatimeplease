import 'package:flutter/material.dart';

import 'common/app_base_button.dart';

class AppInkWell extends AppBaseButton {
  const AppInkWell({
    Key? key,
    this.onTap,
    required this.child,
    bool showLoadingSpinner = false,
    this.visualDensity,
    this.splashFactory,
    required String analyticsName,
  }) : super(
          key: key,
          showLoadingSpinner: showLoadingSpinner,
          analyticsName: analyticsName,
        );

  final VoidCallback? onTap;
  final Widget child;
  final VisualDensity? visualDensity;
  final InteractiveInkFeatureFactory? splashFactory;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashFactory: splashFactory,
      onTap: onTap == null ? null : buttonTap(context, onTap),
      child: showLoadingSpinner ? loadingWidget(context) : child,
    );
  }
}
