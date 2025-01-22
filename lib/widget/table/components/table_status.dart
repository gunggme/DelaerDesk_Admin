import 'package:flutter/material.dart';
import '../../../app/constants/app_colors.dart';

class TableStatus extends StatelessWidget {
  final int playerCount;
  final int maxPlayerCount;
  final double width;
  final bool isConnected;

  const TableStatus({
    super.key,
    required this.playerCount,
    required this.maxPlayerCount,
    required this.isConnected,
    required this.width,
  });

  TextStyle get _statusTextStyle => const TextStyle(
        fontSize: 12,
        color: Colors.black,
        decoration: TextDecoration.none,
      );

  TextStyle get _deviceConnectedStyle => TextStyle(
        fontSize: 12,
        color: isConnected ? AppColors.primary : Colors.black,
        decoration: TextDecoration.none,
      );

  @override
  Widget build(BuildContext context) {
    return _buildDeviceConnectedStatus();
  }

  Widget _buildDeviceConnectedStatus() {
    final isWideEnough = width >= 300; // 적절한 너비 기준값 설정

    final playerStatus = Text(
      '플레이어 수 $playerCount/$maxPlayerCount',
      style: _statusTextStyle,
    );

    final deviceStatus = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '디바이스 연결 ',
          style: _statusTextStyle,
        ),
        Text(
          isConnected ? "On" : "Off",
          style: _deviceConnectedStyle,
        ),
      ],
    );

    var containerWidth = width / 1.1;

    return Container(
      width: containerWidth,
      height: isWideEnough ? 35 : 50,
      color: const Color(0xFFF2F2F2),
      child: isWideEnough
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                playerStatus,
                const SizedBox(width: 40),
                deviceStatus,
                const SizedBox(width: 4),
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                playerStatus,
                const SizedBox(height: 4),
                deviceStatus,
              ],
            ),
    );
  }
}
