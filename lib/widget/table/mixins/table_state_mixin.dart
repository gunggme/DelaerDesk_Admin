import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/device/device_data.dart';
import '../../../repository/table/table_data.dart';
import '../../../services/table/table_management_service.dart';
import '../../../services/device/device_management_service.dart';
import '../handlers/table_event_handler.dart';

mixin TableStateMixin on GetxController implements TableEventHandler {
  // 서비스 레이어
  TableManagementService get tableService => Get.find<TableManagementService>();
  DeviceManagementService get deviceService =>
      Get.find<DeviceManagementService>();

  // 테이블 관련 getter
  RxList<TableData> get tables => tableService.tables;
  Rx<TableData?> get selectedTable => tableService.selectedTable;

  // 디바이스 관련 getter
  RxList<DeviceData> get devices => deviceService.devices;

  // 테이블 관리 메서드
  void selectTable(int tableId) {
    tableService.selectTable(tableId);
  }

  void unselectTable() {
    tableService.unselectTable();
  }

  void updateTablePosition(int tableId, Offset newPosition) {
    tableService.updateTablePosition(tableId, newPosition);
  }

  void updateTableSize(int tableId, Size newSize) {
    tableService.updateTableSize(tableId, newSize);
  }

  void updateTableSizeAndPosition(
      int tableId, Size newSize, Offset newPosition) {
    tableService.updateTableSizeAndPosition(tableId, newSize, newPosition);
  }

  void updateTableTitle(int tableId, String newTitle) {
    tableService.updateTableTitle(tableId, newTitle);
  }

  void updateTableMaxPlayerCount(int id, int newMaxPlayerCount) {
    tableService.updateTableMaxPlayerCount(id, newMaxPlayerCount);
  }

  // 디바이스 관련 메서드
  Future<void> loadDeviceDatas() => deviceService.loadDevices();

  bool isDeviceConnectedToTable(int tableId) =>
      deviceService.isDeviceConnectedToTable(tableId);

  void connectDeviceToTable({required int deviceId, required int tableId}) {
    deviceService.connectDeviceToTable(deviceId, tableId);
  }

  void disconnectDeviceFromTable(int tableId) =>
      deviceService.disconnectDeviceFromTable(tableId);

  DeviceData? getCurrentConnectedDevice(int tableId) =>
      deviceService.getConnectedDevice(tableId);

  DeviceData? getDeviceDataById(int deviceId) =>
      deviceService.getDeviceById(deviceId);

  // TableEventHandler 기본 구현
  @override
  void onTableTap(int tableId) {
    selectTable(tableId);
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
}
