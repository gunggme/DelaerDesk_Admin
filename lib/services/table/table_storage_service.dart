import 'dart:convert';
import 'dart:ui';

import 'package:get/get.dart';
import 'package:hollet_admin/utils/logger/app_logger.dart';
import '../../repository/table/table_data.dart';
import 'package:http/http.dart' as http;

class TableStorageService extends GetxService {
  final AppLogger _logger = AppLogger("TableStorageService");

  /// 테이블 정보를 JSON으로 저장
  Future<void> saveTableLayout(List<TableData> tables) async {
    try {
      final uri = Uri.parse('http://127.0.0.1:8000/api/save-table-datas');
      final tablesJson =
          jsonEncode(tables.map((table) => table.toJson()).toList());
      final headers = {
        'Content-Type': 'application/json',
      };
      final response = await http.post(uri, body: tablesJson, headers: headers);
      if (response.statusCode == 200) {
        _logger.info('Table layout saved successfully');
      } else {
        final responseBody = jsonDecode(response.body);
        _logger.error('response: ${response.statusCode}');
        _logger.error('Error saving table layout: ${responseBody}');
        throw Exception('Error saving table layout: ${responseBody}');
      }

      await loadTableLayout();
    } catch (e) {
      _logger.error('Error saving table layout: $e');
    }
  }

  /// JSON 파일에서 테이블 정보 로드
  Future<List<TableData>> loadTableLayout() async {
    try {
      // 일단 빈 값 반환
      final uri = Uri.parse('http://localhost:8000/api/table-datas');
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        // 테이블 정보는 리스트로 넘어옴
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        final List<dynamic> tableDataList =
            responseBody['data'] as List<dynamic>;
        final List<TableData> tables = tableDataList
            .map((json) => TableData.fromJson(json as Map<String, dynamic>))
            .cast<TableData>()
            .toList();
        return tables;
      }
      _logger.error('Error loading table layout: ${response.body}');
      return [];
    } catch (e) {
      _logger.error('Error loading table layout: $e');
      return [];
    }
  }
}
