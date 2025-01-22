import 'package:flutter/material.dart';
import 'package:hollet_admin/app/constants/app_colors.dart';

class PresetEmptyModal extends StatelessWidget {
  final Function() onNewPreset;
  final Function() onCancel;

  const PresetEmptyModal({
    required this.onNewPreset,
    required this.onCancel,
  });

  final TextStyle titleTextStyle = const TextStyle(
    fontSize: 16,
    decoration: TextDecoration.none,
    color: Colors.black,
  );
  final TextStyle descriptionTextStyle = const TextStyle(
    fontSize: 13,
    decoration: TextDecoration.none,
    color: Color(0xFFA2A2A2),
  );

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        width: 241,
        height: 170,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("프리셋이 없습니다.", style: titleTextStyle),
            Text("프리셋을 생성해주세요.", style: descriptionTextStyle),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 130,
                  child: ElevatedButton(
                    onPressed: onNewPreset,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Text("프리셋 생성"),
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 130,
                  child: ElevatedButton(
                    onPressed: onCancel,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child:
                        Text("취소", style: TextStyle(color: Color(0xFFA2A2A2))),
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
