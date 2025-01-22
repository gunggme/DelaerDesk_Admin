import 'dart:convert';

class PrizeArrayData {
  final String type;
  final List<PrizeArrayDataByCount> prizeArrayDataByCounts;

  PrizeArrayData({
    required this.type,
    required this.prizeArrayDataByCounts,
  });

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'prize_array_data_by_counts': jsonEncode(
          prizeArrayDataByCounts.map((data) => data.toJson()).toList()),
    };
  }

  factory PrizeArrayData.fromJson(Map<String, dynamic> json) {
    final prizeArrayDataByCounts =
        jsonDecode(json['prize_array_data_by_counts']);
    return PrizeArrayData(
      type: json['type'],
      prizeArrayDataByCounts: List<PrizeArrayDataByCount>.from(
          prizeArrayDataByCounts
              .map((data) => PrizeArrayDataByCount.fromJson(data))),
    );
  }
}

class PrizeArrayDataByCount {
  final int playerCount;
  final int prize;

  PrizeArrayDataByCount({
    required this.playerCount,
    required this.prize,
  });

  PrizeArrayDataByCount copyWith({
    int? playerCount,
    int? prize,
  }) {
    return PrizeArrayDataByCount(
      playerCount: playerCount ?? this.playerCount,
      prize: prize ?? this.prize,
    );
  }

  factory PrizeArrayDataByCount.fromJson(Map<String, dynamic> json) {
    return PrizeArrayDataByCount(
      playerCount: json['player_count'],
      prize: json['prize'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'player_count': playerCount,
      'prize': prize,
    };
  }
}
