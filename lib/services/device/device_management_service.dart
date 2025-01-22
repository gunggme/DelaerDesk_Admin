import 'package:get/get.dart';
import '../../models/device/device_data.dart';

class DeviceManagementService extends GetxService {
  final RxList<DeviceData> devices = <DeviceData>[].obs;

  // 디바이스 목록 로드
  Future<void> loadDevices() async {
    // TODO: API에서 디바이스 목록을 가져오는 로직 구
    devices.clear();
    await Future.delayed(const Duration(seconds: 1));
    devices.addAll([
      DeviceData(
        deviceId: 1,
        deviceInfo: "TestDeviceInfo",
      ),
      DeviceData(
        deviceId: 2,
        deviceInfo: "TestDeviceInfo",
      ),
      DeviceData(
        deviceId: 3,
        deviceInfo: "TestDeviceInfo",
      ),
    ]);
  }

  // 테이블에 디바이스 연결
  Future<void> connectDeviceToTable(int deviceId, int tableId) async {
    if (isDeviceConnectedToTable(tableId)) {
      await disconnectDeviceFromTable(tableId);
    }

    final index = devices.indexWhere((device) => device.deviceId == deviceId);

    if (index != -1) {
      devices[index] = devices[index].copyWith(tableId: tableId);
    }
  }

  // 테이블에서 디바이스 연결 해제
  Future<void> disconnectDeviceFromTable(int tableId) async {
    final index = devices
        .indexWhere((device) => device.isDeviceConnectedToTable(tableId));

    if (index != -1) {
      devices[index] = devices[index].copyWith(tableId: null);
    }
  }

  // 테이블에 디바이스가 연결되어 있는지 확인
  bool isDeviceConnectedToTable(int tableId) {
    return devices.any((device) => device.isDeviceConnectedToTable(tableId));
  }

  // 테이블에 연결된 디바이스 가져오기
  DeviceData? getConnectedDevice(int tableId) {
    return devices
        .firstWhereOrNull((device) => device.isDeviceConnectedToTable(tableId));
  }

  // ID로 디바이스 가져오기
  DeviceData? getDeviceById(int deviceId) {
    try {
      return devices.firstWhere((device) => device.deviceId == deviceId);
    } catch (e) {
      return null;
    }
  }
}
