import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hollet_admin/app/constants/app_colors.dart';
import 'package:hollet_admin/utils/logger/app_logger.dart';
import 'package:hollet_admin/widget/custom_scaffold/custom_scaffold.dart';
import '../../controllers/inMenu/store_manage_controller.dart';
import '../../widget/table/table_widget.dart';

class StoreManageView extends GetView<StoreManageController> {
  static final _logger = AppLogger('StoreManageView');

  const StoreManageView({super.key});

  TextStyle get _appBarTitleStyle => const TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: Colors.black,
        decoration: TextDecoration.none,
      );

  @override
  Widget build(BuildContext context) {
    _logger.debug('StoreManageView 빌드 시작');
    _logger.info('${Get.height}');
    _logger.info('${Get.width}');
    return CustomScaffold(
      appBarTitle: Obx(() {
        final hasTable = controller.tables.isNotEmpty;
        _logger.debug('테이블 존재 여부: $hasTable');
        return hasTable
            ? Text("매장 관리", style: _appBarTitleStyle)
            : const SizedBox();
      }),
      appBarActions: [
        Obx(() {
          final hasTable = controller.tables.isNotEmpty;
          return hasTable
              ? IconButton(
                  onPressed: () {
                    _logger.info('테이블 편집 화면으로 이동');
                    Get.toNamed("/store_manage_edit");
                  },
                  icon: const Icon(Icons.edit),
                )
              : const SizedBox();
        })
      ],
      child: Container(
        decoration: BoxDecoration(),
        child: Obx(() {
          final hasTable = controller.tables.isNotEmpty;
          _logger.debug('테이블 상태 변경: ${hasTable ? "테이블 있음" : "테이블 없음"}');
          return hasTable ? _buildTablesBody() : _buildTableIsEmpty();
        }),
      ),
    );
  }

  Widget _buildTablesBody() {
    _logger.debug('테이블 레이아웃 빌드');
    return LayoutBuilder(
      builder: (context, constraints) {
        return Obx(() {
          final tables = controller.tables;
          _logger.debug('테이블 수: ${tables.length}');
          return Stack(
            clipBehavior: Clip.none,
            children: tables.map((table) {
              _logger.debug('테이블 렌더링: ${table.id} (${table.title})');
              return Positioned(
                left: table.position.dx,
                top: table.position.dy,
                child: TableWidget(
                  tableInfo: table,
                  isConnected: controller.isDeviceConnectedToTable(table.id),
                  isSelected: controller.selectedTable.value?.id == table.id,
                  size: table.size,
                  eventHandler: controller,
                ),
              );
            }).toList(),
          );
        });
      },
    );
  }

  Widget _buildTableIsEmpty() {
    _logger.info('빈 테이블 화면 표시');
    return Container(
      color: Colors.white,
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("아직 등록된 테이블이 없습니다.",
              style: TextStyle(
                  fontSize: 32,
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                  decoration: TextDecoration.none)),
          Text("테이블 등록 하시겠습니까?",
              style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                  decoration: TextDecoration.none)),
          SizedBox(height: 20),
          SizedBox(
            width: 200,
            height: 50,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  _logger.info('테이블 등록 화면으로 이동');
                  Get.toNamed("/store_manage_edit");
                },
                child: const Text("테이블 등록",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        decoration: TextDecoration.none))),
          )
        ],
      ),
    );
  }
}
