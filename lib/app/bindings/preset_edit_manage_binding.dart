import 'package:get/get.dart';
import 'package:hollet_admin/controllers/inMenu/preset_edit_manage_controller.dart';

class PresetEditManageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PresetEditManageController());
  }
}
