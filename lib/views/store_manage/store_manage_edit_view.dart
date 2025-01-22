import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hollet_admin/app/constants/app_colors.dart';
import 'package:hollet_admin/controllers/inMenu/store_manage_edit_controller.dart';
import 'package:hollet_admin/models/device/device_data.dart';
import 'package:hollet_admin/repository/table/table_data.dart';
import 'package:hollet_admin/utils/logger/app_logger.dart';
import 'package:hollet_admin/widget/draggable_table_container.dart';
import 'package:hollet_admin/widget/grid_paint.dart';
import 'package:hollet_admin/widget/table/modal/device_table_connect_modal.dart';
import 'package:hollet_admin/widget/table/modal/table_is_empty_modal.dart';

class StoreManageEditView extends GetView<StoreManageEditController> {
  const StoreManageEditView({super.key});
  static final _logger = AppLogger('StoreManageEditView');

  @override
  Widget build(BuildContext context) {
    _logger.info('${Get.height}');
    _logger.info('${Get.width}');

    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      centerTitle: false,
      title: _buildAppBarTitle(),
      actions: _buildAppBarActions(),
    );
  }

  Widget _buildAppBarTitle() {
    return Container(
      padding: const EdgeInsets.only(left: 16),
      child: const Text(
        '테이블 편집',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          fontFamily: 'Pretendard',
          color: Colors.black,
        ),
      ),
    );
  }

  List<Widget> _buildAppBarActions() {
    return [
      _buildExitButton(),
      const SizedBox(width: 10),
      _buildSaveButton(),
    ];
  }

  Widget _buildExitButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: () => Get.back(),
      child: const Text('편집나가기'),
    );
  }

  Widget _buildSaveButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF18AC8D),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: () {
        if (controller.tables.isEmpty) {
          Get.dialog(const TableIsEmptyModal());
          return;
        }
        controller.saveTableLayout();
      },
      child: const Text(
        '저장',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildBody() {
    return Row(
      children: [
        Expanded(child: _buildTableLayout()),
        _buildTableEditContainer(),
      ],
    );
  }

  Widget _buildTableLayout() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          onTapDown: (_) => controller.unselectTable(),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              _buildGridBackground(constraints),
              _buildDraggableTables(constraints),
            ],
          ),
        );
      },
    );
  }

  Widget _buildGridBackground(BoxConstraints constraints) {
    return SizedBox(
      width: constraints.maxWidth,
      height: constraints.maxHeight,
      child: CustomPaint(
        painter: GridPainter(),
        size: Size(constraints.maxWidth, constraints.maxHeight),
      ),
    );
  }

  Widget _buildDraggableTables(BoxConstraints constraints) {
    return Obx(() => Stack(
          clipBehavior: Clip.none,
          children: controller.tables
              .map((table) => DraggableTableContainer(
                    table: table,
                    onDragEnd: (offset) =>
                        _handleTableDragEnd(offset, constraints, table),
                    onTap: () => controller.selectTable(table.id),
                  ))
              .toList(),
        ));
  }

  void _handleTableDragEnd(
      Offset offset, BoxConstraints constraints, TableData table) {
    final adjustedOffset = Offset(
      offset.dx.clamp(0, constraints.maxWidth - table.size.width),
      offset.dy.clamp(0, constraints.maxHeight - table.size.height),
    );
    controller.updateTablePosition(table.id, adjustedOffset);
  }

  Widget _buildTableEditContainer() {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(-3, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 28),
          _buildTableAddButton(),
          const SizedBox(height: 28),
          const Divider(),
          Obx(() => controller.selectedTable.value != null
              ? _tableEditContainer()
              : const SizedBox()),
        ],
      ),
    );
  }

  Widget _buildTableAddButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFEAF5F3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        shadowColor: Colors.transparent,
        minimumSize: const Size(240, 130),
      ),
      onPressed: () => controller.addTable("새 테이블", 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/ic_plus_round_green.svg',
            semanticsLabel: '테이블 추가',
            width: 32,
            height: 32,
          ),
          const SizedBox(height: 8),
          const Text('테이블 추가'),
        ],
      ),
    );
  }

  Widget _tableEditContainer() {
    return Container(
      child: Column(
        children: [
          _buildTableNameSection(),
          const SizedBox(height: 20),
          _buildMaxPlayersSection(),
          const SizedBox(height: 20),
          _buildDeviceConnectionSection(),
          const SizedBox(height: 20),
          _buildColorSelectionSection(),
          const SizedBox(height: 20),
          _buildDeleteTableButton(),
        ],
      ),
    );
  }

  Widget _buildTableNameSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("테이블 명"),
        const SizedBox(height: 10),
        SizedBox(
          width: 240,
          height: 40,
          child: TextField(
            controller: controller.tableTitleController,
            decoration: InputDecoration(
              hintText: '테이블 명을 입력해주세요',
              hintStyle: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                fontFamily: 'Pretendard',
                color: Colors.grey,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMaxPlayersSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("최대 플레이어 수"),
        const SizedBox(height: 10),
        _buildTableMaxPlayer(),
      ],
    );
  }

  Widget _buildDeviceConnectionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("디바이스 연결"),
        const SizedBox(height: 10),
        _buildDeviceConnectionDropdown(),
      ],
    );
  }

  Widget _buildDeviceConnectionDropdown() {
    // todo 디바이스 연결 드롭다운
    // 비활성화 상태 구현해야함 (연결된 디바이스가 0개라면)
    if (controller.devices.isEmpty) {
      return Container(
        width: 241,
        height: 55,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(5),
        ),
        child: const Center(child: Text("연결할 디바이스가 없습니다")),
      );
    }
    // ! 위험 ! Null 밸류일 가능성 높음
    DeviceData? currentConnectedDevice = controller
        .getCurrentConnectedDevice(controller.selectedTable.value!.id);
    if (currentConnectedDevice == null) {
      return SizedBox(
        width: 241,
        height: 55,
        child: DropdownButton(
          hint: const Text("연결할 디바이스를 선택해주세요"),
          items: controller.devices
              .map((device) => DropdownMenuItem(
                    value: device.deviceId.toString(),
                    child: Text(device.deviceInfo),
                  ))
              .toList(),
          onChanged: (value) => _onDeviceConnectionChanged(int.parse(value!)),
        ),
      );
    }
    print("currentConnectedDevice: ${currentConnectedDevice.deviceInfo}");
    return SizedBox(
      width: 241,
      height: 55,
      child: DropdownButton(
        hint: const Text("연결할 디바이스를 선택해주세요"),
        value: currentConnectedDevice.deviceId.toString(),
        items: controller.devices
            .map((device) => DropdownMenuItem(
                  value: device.deviceId.toString(),
                  child: Text(device.deviceInfo),
                ))
            .toList(),
        onChanged: (value) => _onDeviceConnectionChanged(int.parse(value!)),
      ),
    );
  }

  void _onDeviceConnectionChanged(int deviceId) {
    DeviceData? deviceData = controller.getDeviceDataById(deviceId);
    if (deviceData == null) return;

    print("device table id : ${deviceData.tableId}");

    if (deviceData.isDeviceConnected()) {
      print("다른 테이블에 디바이스 연결되어 있는 상태");
      // ignore: invalid_use_of_protected_member
      List<TableData> tables = controller.tables.value;
      for (var table in tables) {
        print("table id : ${table.id}");
      }
      TableData? previousTable = tables
          .firstWhereOrNull((table) => table.id == deviceData.tableId.value);
      print("previousTable : $previousTable");
      if (previousTable == null) {
        print("이전 테이블이 없거나 현재 선택된 테이블이 없습니다");
        return;
      }

      Get.dialog(DeviceTableConnectModal(
        deviceName: deviceData.deviceInfo,
        currentTable: previousTable.title,
        selectedTable: controller.selectedTable.value!.title,
        onCancel: () => Get.back(),
        onConnect: () {
          controller.connectDeviceToTable(
              deviceId: deviceId, tableId: controller.selectedTable.value!.id);
          Get.back();
        },
      ));

      return;
    }

    controller.connectDeviceToTable(
        deviceId: deviceId, tableId: controller.selectedTable.value!.id);
  }

  Widget _buildColorSelectionSection() {
    return Container(
      padding: const EdgeInsets.only(left: 20),
      width: 290,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("컬러 지정"),
          const SizedBox(height: 10),
          _buildTableColorSelect(),
        ],
      ),
    );
  }

  Widget _buildDeleteTableButton() {
    return SizedBox(
      width: 240,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ),
        onPressed: () {
          // tood Test Code
          controller.removeTable(controller.selectedTable.value!.id);
        },
        child: const Text(
          "해당 테이블 삭제",
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  Widget _buildTableMaxPlayer() {
    return Container(
      width: 240,
      decoration: BoxDecoration(
        color: const Color(0xFFE2E2E2),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          _buildCounterButton(Icons.remove, -1),
          _buildPlayerCountDisplay(),
          _buildCounterButton(Icons.add, 1),
        ],
      ),
    );
  }

  Widget _buildCounterButton(IconData icon, int value) {
    return Expanded(
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.transparent,
          splashFactory: NoSplash.splashFactory,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ),
        onPressed: () => controller.onMaxPlayerCountChange(value),
        child: Icon(icon),
      ),
    );
  }

  Widget _buildPlayerCountDisplay() {
    return Expanded(
      child: Container(
        height: 40,
        alignment: Alignment.center,
        color: Colors.white,
        child: Text(
          "${controller.selectedTable.value?.maxPlayerCount}",
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontFamily: 'Pretendard',
          ),
        ),
      ),
    );
  }

  Widget _buildTableColorSelect() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildColorButton(AppColors.primary, true),
        _buildColorButton(Colors.blue, false),
        _buildColorButton(Colors.green, false),
        _buildColorButton(Colors.yellow, false),
        const SizedBox(width: 10),
      ],
    );
  }

  Widget _buildColorButton(Color color, bool isSelected) {
    return ColorFiltered(
      colorFilter: ColorFilter.mode(
        isSelected ? color : Colors.grey,
        BlendMode.color,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 60,
            height: 40,
            decoration: BoxDecoration(
              // 만약 미선택이라면 그레이스케일 변환
              color: color,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          if (isSelected)
            SvgPicture.asset(
              'assets/images/ic_check_round.svg',
              width: 24,
              height: 24,
            ),
        ],
      ),
    );
  }
}
