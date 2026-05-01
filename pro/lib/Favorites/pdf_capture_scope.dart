import 'package:flutter/widgets.dart';

class PdfCaptureScope extends InheritedWidget {
  final bool isCapturing;

  const PdfCaptureScope({
    super.key,
    required this.isCapturing,
    required super.child,
  });

  static bool of(BuildContext context) {
    return context
            .dependOnInheritedWidgetOfExactType<PdfCaptureScope>()
            ?.isCapturing ??
        false;
  }

  @override
  bool updateShouldNotify(PdfCaptureScope oldWidget) {
    return oldWidget.isCapturing != isCapturing;
  }
}
