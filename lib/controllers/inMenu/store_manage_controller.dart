import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hollet_admin/models/device/device_data.dart';
import 'package:hollet_admin/repository/table/table_data.dart';
import 'package:hollet_admin/services/table/table_management_service.dart';
import 'package:hollet_admin/services/device/device_management_service.dart';
import 'package:hollet_admin/widget/table/handlers/table_event_handler.dart';
import 'package:hollet_admin/widget/table/handlers/table_resize_handler.dart';
import 'package:hollet_admin/widget/table/models/resize_handler_position.dart';

/// 매장 관리 화면의 상태와 로직을 관리하는 컨트롤러
class StoreManageController extends GetxController
    implements TableEventHandler {
  final TableManagementService _tableService =
      Get.find<TableManagementService>();
  final DeviceManagementService _deviceService =
      Get.find<DeviceManagementService>();

  // 테이블 관련 getter
  RxList<TableData> get tables => _tableService.tables;
  Rx<TableData?> get selectedTable => _tableService.selectedTable;

  // 디바이스 관련 getter
  RxList<DeviceData> get devices => _deviceService.devices;

  @override
  void onInit() {
    super.onInit();
    loadDeviceDatas();
  }

  // TableEventHandler 구현
  @override
  bool get isEditMode => false;

  @override
  void onTableTap(int tableId) {
    selectTable(tableId);
  }

  @override
  void onTableResize(
      int tableId, ResizeHandlerPosition position, DragUpdateDetails details) {
    final table = tables.firstWhere((table) => table.id == tableId);
    final result = TableResizeHandler.calculateResize(
      position,
      details,
      table.size,
      table.position,
    );
    updateTableSizeAndPosition(tableId, result.size, result.position);
  }

  @override
  void onTableMove(int tableId, Offset delta) {
    final table = tables.firstWhere((table) => table.id == tableId);
    final newPosition = table.position + delta;
    updateTablePosition(tableId, newPosition);
  }

  @override
  void onTableSelect(int tableId) {
    selectTable(tableId);
  }

  @override
  void onTableUnselect() {
    unselectTable();
  }

  // 테이블 관리 메서드
  void selectTable(int tableId) {
    _tableService.selectTable(tableId);
  }

  void unselectTable() {
    _tableService.unselectTable();
  }

  void updateTablePosition(int tableId, Offset newPosition) =>
      _tableService.updateTablePosition(tableId, newPosition);

  void updateTableSizeAndPosition(
          int tableId, Size newSize, Offset newPosition) =>
      _tableService.updateTableSizeAndPosition(tableId, newSize, newPosition);

  // 디바이스 관련 메서드
  Future<void> loadDeviceDatas() => _deviceService.loadDevices();

  bool isDeviceConnectedToTable(int tableId) =>
      _deviceService.isDeviceConnectedToTable(tableId);

  DeviceData? getCurrentConnectedDevice(int tableId) =>
      _deviceService.getConnectedDevice(tableId);
}
