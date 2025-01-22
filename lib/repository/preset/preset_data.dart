import 'dart:convert';

import 'package:hollet_admin/repository/preset/prize_array_data.dart';
import 'package:hollet_admin/repository/preset/time_table_data.dart';

class PresetData {
  final int id;
  final String presetName;
  final List<TimeTableData> timeTableDatas;
  final PrizeArrayData prizeArrayDatas;
  final String buyInPrice;
  final String startingChips;

  PresetData({
    required this.id,
    required this.presetName,
    required this.timeTableDatas,
    required this.prizeArrayDatas,
    required this.buyInPrice,
    required this.startingChips,
  });

  factory PresetData.fromJson(Map<String, dynamic> json) {
    final timeTableDatas = jsonDecode(json['time_table_data']);
    final timeTableData = List<TimeTableData>.from(
        timeTableDatas.map((data) => TimeTableData.fromJson(data)));

    final prizeArrayDatas = jsonDecode(json['prize_array_data']);
    final prizeArrayData = PrizeArrayData.fromJson(prizeArrayDatas);

    return PresetData(
      id: json['id'],
      presetName: json['preset_name'],
      timeTableDatas: timeTableData,
      prizeArrayDatas: prizeArrayData,
      buyInPrice: json['buy_in_price'],
      startingChips: json['starting_chip'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'preset_name': presetName,
      'time_table_data':
          jsonEncode(timeTableDatas.map((data) => data.toJson()).toList()),
      'prize_array_data': jsonEncode(prizeArrayDatas.toJson()),
      'buy_in_price': buyInPrice,
      'starting_chip': startingChips,
    };
  }
}
