import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hollet_admin/repository/table/table_data.dart';
import 'package:hollet_admin/widget/table/table_widget.dart';
import '../controllers/inMenu/store_manage_edit_controller.dart';

class DraggableTableContainer extends GetView<StoreManageEditController> {
  final TableData table;
  final Function(Offset) onDragEnd;
  final VoidCallback? onTap;

  const DraggableTableContainer({
    super.key,
    required this.table,
    required this.onDragEnd,
    this.onTap,
  });

  Widget _buildTableWidget({
    bool isDragging = false,
    bool isFeedback = false,
    bool isConnected = false,
  }) {
    return TableWidget(
      tableInfo: table,
      isConnected: isConnected,
      size: table.size,
      isSelected: !isDragging && controller.selectedTable.value?.id == table.id,
      eventHandler: controller,
    );
  }

  Widget _buildDraggable(BuildContext context, Widget child) {
    if (!controller.isEditMode) {
      return child;
    }

    return Draggable<String>(
      data: table.id.toString(),
      feedback: Material(
        color: Colors.transparent,
        child: Opacity(
          opacity: 0.7,
          child: _buildTableWidget(isDragging: true, isFeedback: true),
        ),
      ),
      childWhenDragging: Opacity(
        opacity: 0.3,
        child: _buildTableWidget(isDragging: true),
      ),
      child: child,
      onDragEnd: (details) {
        controller.selectTable(table.id);
        final RenderBox parentBox =
            context.findRenderObject()?.parent as RenderBox;
        final Offset localPosition = parentBox.globalToLocal(details.offset);
        onDragEnd(localPosition);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: table.position.dx,
      top: table.position.dy,
      child: _buildDraggable(
        context,
        Obx(() {
          final isConnected = controller.isDeviceConnectedToTable(table.id);
          return _buildTableWidget(isConnected: isConnected);
        }),
      ),
    );
  }
}
