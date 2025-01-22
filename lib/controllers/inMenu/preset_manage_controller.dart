import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hollet_admin/repository/preset/preset_data.dart';
import 'package:hollet_admin/services/preset/preset_storage_service.dart';
import 'package:hollet_admin/utils/logger/app_logger.dart';

class PresetManageController extends GetxController {
  final PresetStorageService presetStorageService =
      Get.find<PresetStorageService>();

  RxList<PresetData> presetList = RxList.empty();

  final AppLogger _logger = AppLogger("PresetManageController");

  @override
  void onInit() {
    super.onInit();
    loadPreset();
    _logger.info("PresetManageController onInit");
  }

  Future<void> loadPreset() async {
    await presetStorageService.loadPreset();
    presetList.value = presetStorageService.presetList;
  }
}
