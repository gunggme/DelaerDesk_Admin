import 'package:get/get.dart';
import 'package:hollet_admin/controllers/inMenu/preset_manage_controller.dart';

class PresetManageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<PresetManageController>(PresetManageController());
  }
}
