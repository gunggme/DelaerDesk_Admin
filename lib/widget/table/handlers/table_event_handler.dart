import 'package:flutter/material.dart';
import '../models/resize_handler_position.dart';

abstract class TableEventHandler {
  /// 테이블 편집 모드 여부
  bool get isEditMode;

  void onTableTap(int tableId);
  void onTableResize(
      int tableId, ResizeHandlerPosition position, DragUpdateDetails details);
  void onTableMove(int tableId, Offset delta);
  void onTableSelect(int tableId);
  void onTableUnselect();
}
