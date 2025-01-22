import 'package:get/get.dart';
import '../../controllers/inMenu/store_manage_controller.dart';

class StoreManageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StoreManageController>(() => StoreManageController());
  }
}
