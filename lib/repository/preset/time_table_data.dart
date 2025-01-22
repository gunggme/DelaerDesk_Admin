class TimeTableData {
  final int runningTime;
  final int breakTime;
  final String smallBlind;
  final String bigBlind;
  final int ente;

  TimeTableData({
    required this.runningTime,
    required this.breakTime,
    required this.smallBlind,
    required this.bigBlind,
    required this.ente,
  });

  factory TimeTableData.fromJson(Map<String, dynamic> json) {
    final blind = json['blind'].split('/');
    return TimeTableData(
      runningTime: json['running_time'],
      breakTime: json['break_time'],
      smallBlind: blind[0],
      bigBlind: blind[1],
      ente: json['ente'],
    );
  }

  TimeTableData copyWith({
    int? runningTime,
    int? breakTime,
    String? smallBlind,
    String? bigBlind,
    int? ente,
  }) {
    return TimeTableData(
      runningTime: runningTime ?? this.runningTime,
      breakTime: breakTime ?? this.breakTime,
      smallBlind: smallBlind ?? this.smallBlind,
      bigBlind: bigBlind ?? this.bigBlind,
      ente: ente ?? this.ente,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'running_time': runningTime,
      'break_time': breakTime,
      'blind': '$smallBlind/$bigBlind',
      'ente': ente,
    };
  }
}
