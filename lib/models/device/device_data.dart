import 'package:get/get.dart';

class DeviceData {
  final int deviceId;
  final String deviceInfo;
  final Rx<int?> tableId;

  DeviceData({
    required this.deviceId,
    required this.deviceInfo,
    int? tableId,
  }) : tableId = Rx<int?>(tableId);

  bool isDeviceConnected() => tableId.value != null;
  bool isDeviceConnectedToTable(int targetTableId) =>
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
    int? tableId,
  }) {
    return DeviceData(
      deviceId: deviceId ?? this.deviceId,
      deviceInfo: deviceInfo ?? this.deviceInfo,
      tableId: tableId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'deviceId': deviceId,
      'deviceInfo': deviceInfo,
      'tableId': tableId.value,
    };
  }

  factory DeviceData.fromJson(Map<String, dynamic> json) {
    return DeviceData(
      deviceId: json['deviceId'],
      deviceInfo: json['deviceInfo'],
      tableId: json['tableId'],
    );
  }
}
