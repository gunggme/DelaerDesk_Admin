import 'package:get/get.dart';
import 'package:hollet_admin/controllers/login/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }
}
