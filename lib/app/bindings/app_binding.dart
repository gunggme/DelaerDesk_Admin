import 'package:get/get.dart';
import 'package:hollet_admin/services/device/device_management_service.dart';
import 'package:hollet_admin/services/preset/preset_storage_service.dart';
import 'package:hollet_admin/services/table/table_management_service.dart';
import 'package:hollet_admin/services/table/table_storage_service.dart';

class AppBinding implements Bindings {
  @override
  void dependencies() {
    // 여기에 전역적으로 사용할 컨트롤러들을 등록합니다
    // 예: Get.put(GlobalController());
    Get.put(TableStorageService(), permanent: true);
    Get.put(TableManagementService(), permanent: true);
    Get.put(DeviceManagementService(), permanent: true);
    Get.put(PresetStorageService(), permanent: true);

    // todo 나중에 로그인 성공시 불러오기로 변경 필요
    Get.find<TableManagementService>().initialize();
    Get.find<PresetStorageService>().initialize();
  }
}
