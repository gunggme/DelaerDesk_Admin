import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hollet_admin/widget/custom_scaffold/custom_scaffold.dart';
import '../../controllers/inMenu/preset_manage_controller.dart';

class PresetManageView extends GetView<PresetManageController> {
  const PresetManageView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarActions: [
        IconButton(
          onPressed: () {
            Get.toNamed('/preset_edit_manage');
          },
          icon: Icon(Icons.edit),
        ),
      ],
      child: Container(
        child: Obx(
          () => ListView.builder(
            itemCount: controller.presetList.length,
            itemBuilder: (context, index) {
              return _widgetPresetCard(index);
            },
          ),
        ),
      ),
    );
  }

  Widget _widgetPresetCard(int index) {
    final preset = controller.presetList[index];

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  preset.presetName,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {
                    // 메뉴 처리
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "바이인 가격",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          preset.buyInPrice,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    color: Colors.grey[300],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "시작 칩",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            preset.startingChips,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
