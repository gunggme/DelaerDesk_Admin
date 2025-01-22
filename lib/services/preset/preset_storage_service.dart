import 'dart:convert';

import 'package:get/get.dart';
import 'package:hollet_admin/repository/preset/preset_data.dart';
import 'package:hollet_admin/utils/logger/app_logger.dart';
import 'package:http/http.dart' as http;

class PresetStorageService extends GetxService {
  final AppLogger _logger = AppLogger("PresetStorageService");

  List<PresetData> presetList = [];

  void initialize() async {
    await loadPreset();
  }

  Future<bool> savePreset(PresetData preset) async {
    // todo 실제 데이터베이스에 저장하기

    if (preset.presetName.isEmpty) {
      return false;
    }
    if (preset.timeTableDatas.isEmpty) {
      return false;
    }
    try {
      Uri uri = Uri.parse('http://127.0.0.1:8000/api/save-preset-datas');
      print("${jsonEncode(preset.toJson())}");
      final response = await http.post(uri,
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode(preset.toJson()));
      print("response: ${response.statusCode}");
      if (response.statusCode == 200) {
        _logger.info('Preset saved successfully');
        return true;
      } else {
        _logger.error('Failed to save preset: ${response.body}');
        return false;
      }
    } catch (e) {
      _logger.error('Error saving preset: $e');
      return false;
    }
  }

  Future<void> loadPreset() async {
    try {
      final response =
          await http.get(Uri.parse('http://127.0.0.1:8000/api/preset-datas'));
      if (response.statusCode == 200) {
        _logger.info('Preset loaded successfully');
        final jsonDecodeData = jsonDecode(response.body);
        final presetData = List<PresetData>.from(
            jsonDecodeData["data"].map((data) => PresetData.fromJson(data)));
        presetList = presetData;
      } else {
        _logger.error('Failed to load preset: ${response.body}');
      }
    } catch (e) {
      _logger.error('Error loading preset: $e');
    }
  }
}
