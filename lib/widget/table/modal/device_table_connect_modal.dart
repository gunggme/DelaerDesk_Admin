import 'package:flutter/material.dart';
import 'package:hollet_admin/app/constants/app_colors.dart';

class DeviceTableConnectModal extends StatelessWidget {
  final String deviceName;
  final String currentTable;
  final String selectedTable;

  final Function() onCancel;
  final Function() onConnect;

  TextStyle get _titleTextStyle => const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      );

  TextStyle get _subTextStyle => const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w400,
      );

  const DeviceTableConnectModal({
    super.key,
    required this.deviceName,
    required this.currentTable,
    required this.selectedTable,
    required this.onCancel,
    required this.onConnect,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        width: 400,
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "기존 연결을 헤제하고 해당 테이블에 새로 연결하시겠습니까?",
              style: _titleTextStyle,
            ),
            Text(
              "디바이스는 테이블당 1대만 연결 가능합니다.",
              style: _subTextStyle,
            ),
            Text(
              "선택된 디바이스 이름 : $deviceName",
              style: _subTextStyle,
            ),
            Text(
              "현재 연결된 테이블 : $currentTable",
              style: _subTextStyle,
            ),
            Text(
              "선택된 테이블 : $selectedTable",
              style: _subTextStyle,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                      side: const BorderSide(
                        color: AppColors.black,
                      ),
                    ),
                  ),
                  onPressed: onCancel,
                  child: const Text(
                    "취소",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                      side: const BorderSide(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  onPressed: onConnect,
                  child: const Text(
                    "연결하기",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
