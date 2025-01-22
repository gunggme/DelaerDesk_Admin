import 'package:flutter/material.dart';

class TableData {
  final int id;
  final String title;
  final String? gameId;
  final int maxPlayerCount;
  final int currentPlayerCount;
  final Offset position;
  final Size size;

  TableData({
    required this.id,
    required this.title,
    this.gameId,
    required this.maxPlayerCount,
    this.currentPlayerCount = 0,
    required this.position,
    this.size = const Size(300, 200),
  });

  TableData copyWith({
    int? id,
    String? title,
    String? gameId,
    int? maxPlayerCount,
    int? currentPlayerCount,
    Offset? position,
    Size? size,
  }) {
    return TableData(
      id: id ?? this.id,
      title: title ?? this.title,
      gameId: gameId,
      maxPlayerCount: maxPlayerCount ?? this.maxPlayerCount,
      position: position ?? this.position,
      size: size ?? this.size,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'table_title': title,
      'game_id': gameId,
      'max_player': maxPlayerCount,
      'position_x': position.dx,
      'position_y': position.dy,
      'size_width': size.width,
      'size_height': size.height,
    };
  }

  factory TableData.fromJson(Map<String, dynamic> json) {
    return TableData(
      id: json['id'],
      title: json['table_title'],
      gameId: json['game_id'],
      maxPlayerCount: json['max_player'],
      // currentPlayerCount: json['current_player_count'],
      position: Offset(
        json['position_x'].toDouble(),
        json['position_y'].toDouble(),
      ),
      size: Size(
        json['size_width'].toDouble(),
        json['size_height'].toDouble(),
      ),
    );
  }
}
