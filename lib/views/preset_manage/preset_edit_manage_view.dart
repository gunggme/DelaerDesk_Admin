import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hollet_admin/controllers/inMenu/preset_edit_manage_controller.dart';
import 'package:hollet_admin/widget/custom_scaffold/custom_scaffold.dart';

class PresetEditManageView extends GetView<PresetEditManageController> {
  const PresetEditManageView({super.key});

  TextStyle get _appBarTitleStyle => const TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: Colors.black,
        decoration: TextDecoration.none,
      );

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarTitle: Text('프리셋 편집', style: _appBarTitleStyle),
      appBarActions: [
        IconButton(
          icon: Icon(Icons.save),
          onPressed: () {
            controller.savePreset();
          },
        ),
      ],
      child: Container(
        child: Row(
          children: [
            _namePrizeWidget(),
            VerticalDivider(color: Colors.grey),
            _timeBlindSettingContainer(),
          ],
        ),
      ),
    );
  }

  Widget _namePrizeWidget() {
    return Expanded(
      child: Container(
        child: Column(
          children: [
            Expanded(
              child: _nameWidget(),
            ),
            Divider(),
            _prizeSetWidget(),
          ],
        ),
      ),
    );
  }

  Expanded _prizeSetWidget() {
    return Expanded(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('상금 설정', style: _appBarTitleStyle),
              IconButton(
                icon: Icon(Icons.add_circle_outline),
                onPressed: () {
                  controller.addNewPresetPrizeArrayData();
                },
              ),
            ],
          ),
          Expanded(
            child: Obx(
              () => ListView.separated(
                itemCount: controller.presetPrizeArrayDataByCountList.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  return _prizeSetItem(index);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _prizeSetItem(int index) {
    final controllerValue =
        controller.presetPrizeArrayDataTextControllerList[index];
    return Container(
      child: Column(
        children: [
          _timeBlindSettingItemTimeField(
              "플레이어 수", index, 300, controllerValue.playerCountController),
          _timeBlindSettingItemTimeField(
              "상금", index, 300, controllerValue.prizeController),
        ],
      ),
    );
  }

  Widget _nameWidget() {
    return SizedBox(
      width: 300,
      child: Column(
        children: [
          Text('프리셋 이름', style: _appBarTitleStyle),
          Material(
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4),
              ),
              child: TextField(
                controller: controller.presetNameController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _timeBlindSettingContainer() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '시간/블라인드 설정',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                    color: Colors.black,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline),
                  onPressed: () {
                    controller.addNewPresetTimeBlindSetting();
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Obx(
                () => ListView.separated(
                  itemCount: controller.presetTimeBlindSettingList.value.length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) {
                    return _timeBlindSettingItem(index);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _timeBlindSettingItem(int index) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _timeBlindSettingItemTimeField(
                  '진행 시간',
                  index,
                  300,
                  controller.presetTimeBlindSettingTextEditingControllerList
                      .value[index].runningTimeController),
              const SizedBox(width: 10),
              _timeBlindSettingItemTimeField(
                  '쉬는 시간',
                  index,
                  300,
                  controller.presetTimeBlindSettingTextEditingControllerList
                      .value[index].breakTimeController),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _timeBlindSettingItemTimeField(
                  '스몰 블라인드',
                  index,
                  300,
                  controller.presetTimeBlindSettingTextEditingControllerList
                      .value[index].smallBlindController),
              const SizedBox(width: 10),
              _timeBlindSettingItemTimeField(
                  '빅 블라인드',
                  index,
                  300,
                  controller.presetTimeBlindSettingTextEditingControllerList
                      .value[index].bigBlindController),
            ],
          ),
          _timeBlindSettingItemTimeField(
              '엔티',
              index,
              610,
              controller.presetTimeBlindSettingTextEditingControllerList
                  .value[index].enteController),
        ],
      ),
    );
  }

  Widget _timeBlindSettingItemTimeField(
      String title, int index, double width, TextEditingController controller) {
    const TextStyle textStyle = TextStyle(
      color: Colors.black,
      fontSize: 14,
      fontWeight: FontWeight.bold,
      decoration: TextDecoration.none,
    );

    return SizedBox(
      width: width,
      height: 70,
      child: Column(
        children: [
          Text(title, style: textStyle),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Material(
              color: Colors.transparent,
              child: TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
