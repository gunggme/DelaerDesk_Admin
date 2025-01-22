import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hollet_admin/controllers/inMenu/store_manage_controller.dart';
import 'package:hollet_admin/controllers/inMenu/store_manage_edit_controller.dart';
import 'package:hollet_admin/repository/table/table_data.dart';
import 'package:hollet_admin/widget/preset/modal/preset_empty_modal.dart';
import '../../app/constants/app_colors.dart';
import 'constants/table_size_constants.dart';
import 'models/resize_handler_position.dart';
import 'handlers/table_resize_handler.dart';
import 'handlers/table_event_handler.dart';
import 'components/table_body.dart';
import 'components/table_content.dart';

class TableWidget extends StatelessWidget {
  final TableData tableInfo;
  final bool isConnected;
  final bool isSelected;
  final Size size;
  final TableEventHandler eventHandler;

  const TableWidget({
    super.key,
    required this.tableInfo,
    required this.eventHandler,
    this.isConnected = false,
    this.isSelected = false,
    this.size = const Size(
        TableSizeConstants.DEFAULT_WIDTH, TableSizeConstants.DEFAULT_HEIGHT),
  });

  void _handleResize(
      ResizeHandlerPosition position, DragUpdateDetails details) {
    if (!isSelected || !eventHandler.isEditMode) return;
    eventHandler.onTableResize(tableInfo.id, position, details);
  }

  Widget _buildResizeHandler(ResizeHandlerPosition position) {
    const double touchAreaSize = 24.0;
    const double visibleHandlerSize = 10.0;

    return Positioned(
      left: position.isLeft ? -touchAreaSize / 2 : null,
      top: position.isTop ? -touchAreaSize / 2 : null,
      right: !position.isLeft ? -touchAreaSize / 2 : null,
      bottom: !position.isTop ? -touchAreaSize / 2 : null,
      child: MouseRegion(
        cursor: TableResizeHandler.getResizeCursor(position),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onPanUpdate: (details) => _handleResize(position, details),
          child: Container(
            width: touchAreaSize,
            height: touchAreaSize,
            alignment: Alignment.center,
            color: Colors.transparent,
            child: Container(
              width: visibleHandlerSize,
              height: visibleHandlerSize,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.primary,
                  width: 3,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (eventHandler is StoreManageEditController) {
      return GestureDetector(
        onTap: () => eventHandler.onTableTap(tableInfo.id),
        onPanUpdate: eventHandler.isEditMode
            ? (details) => eventHandler.onTableMove(tableInfo.id, details.delta)
            : null,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            TableBody(
              size: size,
              isSelected: isSelected,
              child: TableContent(
                title: tableInfo.title,
                playerCount: tableInfo.currentPlayerCount,
                maxPlayerCount: tableInfo.maxPlayerCount,
                isConnected: isConnected,
                size: size,
              ),
            ),
            if (isSelected && eventHandler.isEditMode) ...[
              for (final position in ResizeHandlerPosition.values)
                _buildResizeHandler(position),
            ],
          ],
        ),
      );
    } else if (eventHandler is StoreManageController) {
      return _buildStoreManageTable();
    }
    return const SizedBox.shrink();
  }

  Widget _buildStoreManageTable() {
    return GestureDetector(
      onTap: () => eventHandler.onTableTap(tableInfo.id),
      onPanUpdate: eventHandler.isEditMode
          ? (details) => eventHandler.onTableMove(tableInfo.id, details.delta)
          : null,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          TableBody(
            size: size,
            isSelected: isSelected,
            child: Column(
              children: [
                TableContent(
                  title: tableInfo.title,
                  playerCount: tableInfo.currentPlayerCount,
                  maxPlayerCount: tableInfo.maxPlayerCount,
                  isConnected: isConnected,
                  size: size,
                ),
                SingleChildScrollView(child: _buildStoreManageTableGameState()),
                _buildStoreManageTableButtons()
              ],
            ),
          ),
          if (isSelected && eventHandler.isEditMode) ...[
            for (final position in ResizeHandlerPosition.values)
              _buildResizeHandler(position),
          ],
        ],
      ),
    );
  }

  Widget _buildStoreManageTableButtons() {
    // 버튼의 최소 필요 너비 계산 (여백 포함)
    const double minButtonWidth = 130; // 버튼 하나의 예상 최소 너비
    const double buttonSpacing = 10; // 버튼 사이 간격
    final double totalMinWidth = (minButtonWidth * 2) + buttonSpacing;

    return LayoutBuilder(builder: (context, constraints) {
      final useColumn = constraints.maxWidth < totalMinWidth;

      return Flex(
        direction: useColumn ? Axis.vertical : Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: minButtonWidth,
            child: ElevatedButton(
              // todo 나중에 확장성 높게 개발 필요
              onPressed: () => Get.dialog(PresetEmptyModal(
                onNewPreset: () {
                  print("새 게임 생성");
                  Get.back();
                },
                onCancel: () => Get.back(),
              )),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: const Text(
                "새 게임",
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(
            width: useColumn ? 0 : buttonSpacing,
            height: useColumn ? buttonSpacing : 0,
          ),
          SizedBox(
            width: minButtonWidth,
            child: ElevatedButton(
              onPressed: () => print("게임 불러오기"),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF2F2F2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: const Text(
                "게임 불러오기",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      );
    });
  }

  // todo 게임 상태 확인
  Widget _buildStoreManageTableGameState() {
    TextStyle gameStateTextStyle = const TextStyle(
      fontSize: 13,
      decoration: TextDecoration.none,
      color: Colors.black,
    );

    TextStyle gameTimerTextStyle = const TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.bold,
      decoration: TextDecoration.none,
      color: Color(0xFFA2A2A2),
    );

    TextStyle noGameTextStyle = const TextStyle(
      fontSize: 13,
      decoration: TextDecoration.none,
      color: Color(0xFFA2A2A2),
    );

    return SizedBox(
      width: size.width * 0.87,
      height: 76,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("현재 게임 상태", style: gameStateTextStyle),
              Row(
                children: [
                  const Icon(Icons.timer, size: 16, color: Color(0xFFA2A2A2)),
                  Text("00:00", style: gameTimerTextStyle),
                ],
              )
            ],
          ),
          const Divider(
            color: Colors.grey,
            thickness: 0.5,
          ),
          Text("지정된 게임이 없습니다.", style: noGameTextStyle)
        ],
      ),
    );
  }
}
