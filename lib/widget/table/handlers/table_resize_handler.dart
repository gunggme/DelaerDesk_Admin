import 'package:flutter/material.dart';
import '../constants/table_size_constants.dart';
import '../models/resize_handler_position.dart';
import '../models/resize_result.dart';

class TableResizeHandler {
  static ResizeResult calculateResize(
    ResizeHandlerPosition position,
    DragUpdateDetails details,
    Size currentSize,
    Offset currentPosition,
  ) {
    double newWidth = currentSize.width;
    double newHeight = currentSize.height;
    double dx = details.delta.dx;
    double dy = details.delta.dy;
    Offset newPosition = currentPosition;

    switch (position) {
      case ResizeHandlerPosition.topLeft:
        newWidth = currentSize.width - dx;
        newHeight = currentSize.height - dy;
        if (_isWidthValid(newWidth)) {
          newPosition = Offset(currentPosition.dx + dx, newPosition.dy);
        }
        if (_isHeightValid(newHeight)) {
          newPosition = Offset(newPosition.dx, currentPosition.dy + dy);
        }
        break;

      case ResizeHandlerPosition.topRight:
        newWidth = currentSize.width + dx;
        newHeight = currentSize.height - dy;
        if (_isHeightValid(newHeight)) {
          newPosition = Offset(currentPosition.dx, currentPosition.dy + dy);
        }
        break;

      case ResizeHandlerPosition.bottomLeft:
        newWidth = currentSize.width - dx;
        newHeight = currentSize.height + dy;
        if (_isWidthValid(newWidth)) {
          newPosition = Offset(currentPosition.dx + dx, currentPosition.dy);
        }
        break;

      case ResizeHandlerPosition.bottomRight:
        newWidth = currentSize.width + dx;
        newHeight = currentSize.height + dy;
        break;
    }

    return ResizeResult(
      size: Size(
        newWidth.clamp(
            TableSizeConstants.MIN_WIDTH, TableSizeConstants.MAX_WIDTH),
        newHeight.clamp(
            TableSizeConstants.MIN_HEIGHT, TableSizeConstants.MAX_HEIGHT),
      ),
      position: newPosition,
    );
  }

  static bool _isWidthValid(double width) =>
      width >= TableSizeConstants.MIN_WIDTH &&
      width <= TableSizeConstants.MAX_WIDTH;

  static bool _isHeightValid(double height) =>
      height >= TableSizeConstants.MIN_HEIGHT &&
      height <= TableSizeConstants.MAX_HEIGHT;

  static MouseCursor getResizeCursor(ResizeHandlerPosition position) {
    switch (position) {
      case ResizeHandlerPosition.topLeft:
      case ResizeHandlerPosition.bottomRight:
        return SystemMouseCursors.resizeUpLeftDownRight;
      case ResizeHandlerPosition.topRight:
      case ResizeHandlerPosition.bottomLeft:
        return SystemMouseCursors.resizeUpRightDownLeft;
    }
  }
}
