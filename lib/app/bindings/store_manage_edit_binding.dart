import 'package:get/get.dart';
import 'package:hollet_admin/controllers/inMenu/store_manage_edit_controller.dart';

class StoreManageEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StoreManageEditController());
  }
}
