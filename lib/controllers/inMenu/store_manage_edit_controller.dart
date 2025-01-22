import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hollet_admin/models/device/device_data.dart';
import 'package:hollet_admin/repository/table/table_data.dart';
import 'package:hollet_admin/services/table/table_management_service.dart';
import 'package:hollet_admin/services/table/table_storage_service.dart';
import 'package:hollet_admin/services/device/device_management_service.dart';
import 'package:hollet_admin/utils/logger/app_logger.dart';
import 'package:hollet_admin/widget/table/handlers/table_event_handler.dart';
import 'package:hollet_admin/widget/table/handlers/table_resize_handler.dart';
import 'package:hollet_admin/widget/table/models/resize_handler_position.dart';

class StoreManageEditController extends GetxController
    implements TableEventHandler {
  static final _logger = AppLogger('StoreManageEditController');

  final tableTitleController = TextEditingController();

  // 서비스 레이어 주입
  final TableManagementService _tableService =
      Get.find<TableManagementService>();
  final TableStorageService _storageService = Get.find<TableStorageService>();
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
    _initializeData();
    tableTitleController.addListener(_onTitleChanged);
  }

  Future<void> _initializeData() async {
    await loadTableLayout();
    await loadDeviceDatas();
  }

  @override
  void onClose() {
    tableTitleController.removeListener(_onTitleChanged);
    tableTitleController.dispose();
    saveTableLayout();
    super.onClose();
  }

  void _onTitleChanged() {
    if (selectedTable.value != null) {
      final newTitle = tableTitleController.text;
      updateTableTitle(selectedTable.value!.id, newTitle);
    }
  }

  void onMaxPlayerCountChange(int increaseValue) {
    if (selectedTable.value != null) {
      final newMaxPlayerCount =
          selectedTable.value!.maxPlayerCount + increaseValue;
      updateTableMaxPlayerCount(selectedTable.value!.id, newMaxPlayerCount);
    }
  }

  // TableEventHandler 구현
  @override
  bool get isEditMode => true;

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

  // 테이블 관리 메서드들을 서비스로 위임
  void updateTableTitle(int tableId, String newTitle) =>
      _tableService.updateTableTitle(tableId, newTitle);

  void selectTable(int tableId) {
    tableTitleController.removeListener(_onTitleChanged);
    _tableService.selectTable(tableId);
    if (selectedTable.value != null) {
      tableTitleController.text = selectedTable.value!.title;
    }
    tableTitleController.addListener(_onTitleChanged);
  }

  void unselectTable() {
    tableTitleController.removeListener(_onTitleChanged);
    _tableService.unselectTable();
    tableTitleController.clear();
    tableTitleController.addListener(_onTitleChanged);
  }

  void updateTablePosition(int tableId, Offset newPosition) =>
      _tableService.updateTablePosition(tableId, newPosition);

  void addTable(String title, int maxPlayerCount) {
    if (title.isEmpty) {
      _logger.warning("테이블 이름이 비어있습니다.");
      return;
    }

    _logger.info("새 테이블 추가: $title (최대 인원: $maxPlayerCount)");
    unselectTable();
    tableTitleController.clear();

    String tableTitle = title;
    if (tables.firstWhereOrNull((table) => table.title == tableTitle) != null) {
      _logger.warning("이미 존재하는 테이블 이름입니다.");
      tableTitle = "$tableTitle(${tables.length + 2})";
    }

    try {
      final newTable = TableData(
        id: tables[_tableService.tables.length - 1].id + 1,
        title: tableTitle,
        gameId: null,
        maxPlayerCount: maxPlayerCount,
        position: const Offset(100, 100),
      );

      _tableService.addTable(newTable);
      selectTable(newTable.id);
      _logger.debug("테이블 추가 완료: ${newTable.id}");
    } catch (e, stackTrace) {
      if (e is RangeError) {
        _logger.error("테이블 ID 생성 중 범위 오류가 발생했습니다. 테이블이 없는 경우 ID를 1로 설정합니다.");
        final newTable = TableData(
          id: 1,
          title: tableTitle,
          gameId: null,
          maxPlayerCount: maxPlayerCount,
          position: const Offset(100, 100),
        );
        _tableService.addTable(newTable);
        selectTable(newTable.id);
      } else {
        _logger.error("테이블 추가 실패: ${e.toString()}", e, stackTrace);
      }
    }
  }

  void removeTable(int tableId) {
    _tableService.removeTable(tableId);
    if (selectedTable.value?.id == tableId) {
      unselectTable();
    }
  }

  void updateTableSize(int tableId, Size newSize) =>
      _tableService.updateTableSize(tableId, newSize);

  void updateTableSizeAndPosition(
          int tableId, Size newSize, Offset newPosition) =>
      _tableService.updateTableSizeAndPosition(tableId, newSize, newPosition);

  // 저장소 관련 메서드들을 서비스로 위임
  Future<void> saveTableLayout() async {
    try {
      _logger.info("테이블 레이아웃 저장 시작");
      await _storageService.saveTableLayout(tables);
      _logger.info("테이블 레이아웃 저장 완료");
    } catch (e, stackTrace) {
      _logger.error("테이블 레이아웃 저장 실패", e, stackTrace);
    }
  }

  Future<void> loadTableLayout() async {
    try {
      _logger.info("테이블 레이아웃 로드 시작");
      final loadedTables = await _storageService.loadTableLayout();
      tables.clear();
      tables.addAll(loadedTables);
      _logger.info("테이블 레이아웃 로드 완료: ${loadedTables.length}개 테이블");
    } catch (e, stackTrace) {
      _logger.error("테이블 레이아웃 로드 실패", e, stackTrace);
    }
  }

  void updateTableMaxPlayerCount(int id, int newMaxPlayerCount) =>
      _tableService.updateTableMaxPlayerCount(id, newMaxPlayerCount);

  // 디바이스 관련 메서드들을 서비스로 위임
  Future<void> loadDeviceDatas() => _deviceService.loadDevices();

  bool isDeviceConnectedToTable(int tableId) =>
      _deviceService.isDeviceConnectedToTable(tableId);

  void connectDeviceToTable({required int deviceId, required int tableId}) {
    _logger.info("디바이스 연결 시도: Device($deviceId) -> Table($tableId)");
    try {
      _deviceService.connectDeviceToTable(deviceId, tableId);
      _logger.info("디바이스 연결 성공");
    } catch (e, stackTrace) {
      _logger.error("디바이스 연결 실패", e, stackTrace);
    }
  }

  void disconnectDeviceFromTable(int tableId) {
    _logger.info("디바이스 연결 해제 시도: Table($tableId)");
    try {
      _deviceService.disconnectDeviceFromTable(tableId);
      _logger.info("디바이스 연결 해제 성공");
    } catch (e, stackTrace) {
      _logger.error("디바이스 연결 해제 실패", e, stackTrace);
    }
  }

  DeviceData? getCurrentConnectedDevice(int tableId) =>
      _deviceService.getConnectedDevice(tableId);

  DeviceData? getDeviceDataById(int deviceId) =>
      _deviceService.getDeviceById(deviceId);
}
