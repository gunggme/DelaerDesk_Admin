import 'package:get/get.dart';

class DeviceData {
  final int deviceId;
  final String deviceInfo;
  final Rx<String?> tableId;

  DeviceData({
    required this.deviceId,
    required this.deviceInfo,
    String? tableId,
  }) : tableId = (tableId).obs;

  bool isDeviceConnected() => tableId.value?.isNotEmpty ?? false;
  bool isDeviceConnectedToTable(String targetTableId) =>
      tableId.value == targetTableId;

  String deviceIdToString() {
    if (tableId.value == null) {
      return "$deviceInfo not connected";
    }
    return "$deviceInfo connected ${tableId.value}";
  }

  DeviceData copyWith({
    int? deviceId,
    String? deviceInfo,
    String? tableId,
  }) {
    return DeviceData(
      deviceId: deviceId ?? this.deviceId,
      deviceInfo: deviceInfo ?? this.deviceInfo,
      tableId: tableId,
    );
  }
}
