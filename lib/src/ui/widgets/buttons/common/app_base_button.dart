import 'dart:developer';
import 'package:findatimeplease/src/locator/locator.dart';
import 'package:findatimeplease/src/services/logger_service.dart';
import 'package:flutter/material.dart';

abstract class AppBaseButton extends StatelessWidget {
  const AppBaseButton({
    super.key,
    required this.showLoadingSpinner,
    required this.analyticsName,
  });

  final bool showLoadingSpinner;
  final String analyticsName;

  VoidCallback? buttonTap(
    BuildContext context,
    VoidCallback? onTap,
  ) {
    return showLoadingSpinner
        ? () => log('nope, not yet')
        : onTap == null
            ? null
            : () {
                _logButtonTap(context, analyticsName: analyticsName);
                onTap();
              };
  }

  _logButtonTap(BuildContext context, {required String analyticsName}) {
    locator<LoggerService>().logButtonTap(
      currentRoutePath: 'get this from a top level nav service',
      buttonText: analyticsName,
    );
  }

  Widget loadingWidget(
    BuildContext context, {
    Color? color,
    double strokeWidth = 4,
  }) {
    return Center(
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth,
        color: color ?? Theme.of(context).colorScheme.onPrimary,
      ),
    );
  }
}
