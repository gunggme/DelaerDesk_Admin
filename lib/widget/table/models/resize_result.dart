import 'package:flutter/material.dart';
import '../constants/table_size_constants.dart';

class ResizeResult {
  final Size size;
  final Offset position;

  const ResizeResult({
    required this.size,
    required this.position,
  });

  bool get isValid =>
      size.width >= TableSizeConstants.MIN_WIDTH &&
      size.width <= TableSizeConstants.MAX_WIDTH &&
      size.height >= TableSizeConstants.MIN_HEIGHT &&
      size.height <= TableSizeConstants.MAX_HEIGHT;
}
