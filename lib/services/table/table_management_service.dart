import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:hollet_admin/services/table/table_storage_service.dart';
import '../../repository/table/table_data.dart';

class TableManagementService extends GetxService {
  final RxList<TableData> tables = <TableData>[].obs;
  final Rx<TableData?> selectedTable = Rx<TableData?>(null);

  late TableStorageService tableStorageService;

  @override
  void onInit() {
    super.onInit();
  }

  void initialize() async {
    tableStorageService = Get.find<TableStorageService>();
    tables.value = await tableStorageService.loadTableLayout();
  }

  // 테이블 추가
  Future<void> addTable(TableData table) async {
    tables.add(table);
  }

  // 테이블 제거
  Future<void> removeTable(int id) async {
    tables.removeWhere((table) => table.id == id);
    if (selectedTable.value?.id == id) {
      selectedTable.value = null;
    }
  }

  // 테이블 업데이트
  Future<void> updateTable(TableData table) async {
    final index = tables.indexWhere((t) => t.id == table.id);
    if (index != -1) {
      tables[index] = table;
      if (selectedTable.value?.id == table.id) {
        selectedTable.value = table;
      }
    }
  }

  // 테이블 선택
  void selectTable(int id) {
    final table = tables.firstWhereOrNull((table) => table.id == id);
    selectedTable.value = table;
  }

  // 테이블 선택 해제
  void unselectTable() {
    selectedTable.value = null;
  }

  // 테이블 위치 업데이트
  Future<void> updateTablePosition(int id, Offset position) async {
    final index = tables.indexWhere((table) => table.id == id);
    if (index != -1) {
      final updatedTable = tables[index].copyWith(position: position);
      await updateTable(updatedTable);
    }
  }

  // 테이블 크기 업데이트
  Future<void> updateTableSize(int id, Size size) async {
    final index = tables.indexWhere((table) => table.id == id);
    if (index != -1) {
      final updatedTable = tables[index].copyWith(size: size);
      await updateTable(updatedTable);
    }
  }

  // 테이블 크기와 위치 동시 업데이트
  Future<void> updateTableSizeAndPosition(
      int id, Size size, Offset position) async {
    final index = tables.indexWhere((table) => table.id == id);
    if (index != -1) {
      final updatedTable = tables[index].copyWith(
        size: size,
        position: position,
      );
      await updateTable(updatedTable);
    }
  }

  // 테이블 제목 업데이트
  Future<void> updateTableTitle(int id, String title) async {
    final index = tables.indexWhere((table) => table.id == id);
    if (index != -1) {
      final updatedTable = tables[index].copyWith(title: title);
      await updateTable(updatedTable);
    }
  }

  // 테이블 최대 플레이어 수 업데이트
  Future<void> updateTableMaxPlayerCount(int id, int count) async {
    final index = tables.indexWhere((table) => table.id == id);
    if (index != -1) {
      final updatedTable = tables[index].copyWith(
        maxPlayerCount: count,
        currentPlayerCount: count,
      );
      await updateTable(updatedTable);
    }
  }
}
