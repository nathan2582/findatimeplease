import 'package:flutter/material.dart';

class PretendMobileAppWrapper extends StatelessWidget {
  const PretendMobileAppWrapper({
    super.key,
    required this.child,
    this.phoneSize = const Size(414, 896),
    this.phoneBorderRadius = 16,
  });

  final Widget child;
  final Size phoneSize;
  final double phoneBorderRadius;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(
            color: Colors.black,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(phoneBorderRadius),
          ),
        ),
        width: size.width.clamp(0, phoneSize.width),
        height: size.height.clamp(0, phoneSize.height),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(phoneBorderRadius),
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
