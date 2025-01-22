import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hollet_admin/repository/preset/preset_data.dart';
import 'package:hollet_admin/repository/preset/prize_array_data.dart';
import 'package:hollet_admin/repository/preset/time_table_data.dart';
import 'package:hollet_admin/services/preset/preset_storage_service.dart';
import 'package:hollet_admin/utils/logger/app_logger.dart';

class PresetEditManageController extends GetxController {
  final PresetStorageService presetStorageService =
      Get.find<PresetStorageService>();

  final TextEditingController presetNameController = TextEditingController();

  final RxList<TimeTableData> presetTimeBlindSettingList = RxList.empty();
  final RxList<PresetTimeBlindSetting>
      presetTimeBlindSettingTextEditingControllerList = RxList.empty();
  final RxList<PrizeArrayDataByCount> presetPrizeArrayDataByCountList =
      RxList.empty();
  final RxList<PrizeArrayDataTextController>
      presetPrizeArrayDataTextControllerList = RxList.empty();

  int presetId = -1;

  final AppLogger _logger = AppLogger("PresetEditManageController");

  @override
  void onInit() {
    super.onInit();
  }

  void addNewPresetTimeBlindSetting() {
    _logger.info("aded new preset time blind setting");
    presetTimeBlindSettingList.add(TimeTableData(
      runningTime: 600,
      breakTime: 100,
      smallBlind: '100',
      bigBlind: '200',
      ente: 0,
    ));
    presetTimeBlindSettingTextEditingControllerList
        .add(PresetTimeBlindSetting());
    _logger.info(
        "presetTimeBlindSettingList: ${presetTimeBlindSettingList.length}");
  }

  void addNewPresetPrizeArrayData() {
    _logger.info("aded new preset prize array data");
    presetPrizeArrayDataByCountList.add(PrizeArrayDataByCount(
      playerCount: 1,
      prize: 10000,
    ));
    presetPrizeArrayDataTextControllerList.add(PrizeArrayDataTextController());
    _logger.info(
        "presetPrizeArrayDataByCountList: ${presetPrizeArrayDataByCountList.length}");
  }

  void savePreset() async {
    _logger.info("saved preset");

    for (var i = 0; i < presetTimeBlindSettingList.length; i++) {
      final controller = presetTimeBlindSettingTextEditingControllerList[i];
      presetTimeBlindSettingList[i] = presetTimeBlindSettingList[i].copyWith(
        smallBlind: controller.smallBlindController.text,
        bigBlind: controller.bigBlindController.text,
        runningTime: int.parse(controller.runningTimeController.text),
        breakTime: int.parse(controller.breakTimeController.text),
        ente: int.parse(controller.enteController.text),
      );
    }

    for (var i = 0; i < presetPrizeArrayDataByCountList.length; i++) {
      final controller = presetPrizeArrayDataTextControllerList[i];
      presetPrizeArrayDataByCountList[i] =
          presetPrizeArrayDataByCountList[i].copyWith(
        playerCount: int.parse(controller.playerCountController.text),
        prize: int.parse(controller.prizeController.text),
      );
    }

    final savePresetData = PresetData(
      id: 0,
      presetName: presetNameController.text,
      timeTableDatas: presetTimeBlindSettingList,
      prizeArrayDatas: PrizeArrayData(
          type: "const",
          prizeArrayDataByCounts: presetPrizeArrayDataByCountList),
      buyInPrice: '10000,',
      startingChips: '20000',
    );
    final result = await presetStorageService.savePreset(savePresetData);
    if (result) {
      _logger.info("preset saved successfully");
      Get.back();
      Get.snackbar("성공", "프리셋 저장 완료",
          overlayColor: Colors.green,
          colorText: Colors.white,
          backgroundColor: Colors.green);
    } else {
      _logger.error("preset save failed");
      Get.snackbar("실패", "프리셋 저장 실패",
          overlayColor: Colors.red,
          colorText: Colors.white,
          backgroundColor: Colors.red);
    }
  }

  void deletePresetTimeBlindSetting(int index) {
    _logger.info("deleted preset time blind setting");
    presetTimeBlindSettingList.removeAt(index);
  }
}

class PresetTimeBlindSetting {
  final TextEditingController smallBlindController = TextEditingController();
  final TextEditingController bigBlindController = TextEditingController();
  final TextEditingController runningTimeController = TextEditingController();
  final TextEditingController breakTimeController = TextEditingController();
  final TextEditingController enteController = TextEditingController();

  PresetTimeBlindSetting() {
    smallBlindController.text = '100';
    bigBlindController.text = '200';
    runningTimeController.text = '600';
    breakTimeController.text = '100';
    enteController.text = '0';
  }
}

class PrizeArrayDataTextController {
  final TextEditingController playerCountController = TextEditingController();
  final TextEditingController prizeController = TextEditingController();

  PrizeArrayDataTextController() {
    playerCountController.text = '1';
    prizeController.text = '10000';
  }
}
