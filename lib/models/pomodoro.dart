class Pomodoro {
  final String userId;
  final DateTime startTime;
  final DateTime endTime;
  final int durationInSeconds;
  Pomodoro({
    required this.userId,
    required this.startTime,
    required this.endTime,
    required this.durationInSeconds,
  });

  Pomodoro copyWith({
    String? userId,
    DateTime? startTime,
    DateTime? endTime,
    int? durationInSeconds,
  }) {
    return Pomodoro(
      userId: userId ?? this.userId,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      durationInSeconds: durationInSeconds ?? this.durationInSeconds,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'duration': durationInSeconds,
    };
  }

  factory Pomodoro.fromMap(Map<String, dynamic> map) {
    return Pomodoro(
      userId: map['userId'] as String,
      startTime: DateTime.parse(map['startTime']),
      endTime: DateTime.parse(map['endTime']),
      durationInSeconds: map['duration'],
    );
  }

  @override
  String toString() {
    return 'Pomodoro(userId: $userId, startTime: $startTime, endTime: $endTime, durationInSeconds: $durationInSeconds)';
  }

  @override
  bool operator ==(covariant Pomodoro other) {
    if (identical(this, other)) return true;

    return other.userId == userId &&
        other.startTime == startTime &&
        other.endTime == endTime &&
        other.durationInSeconds == durationInSeconds;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        startTime.hashCode ^
        endTime.hashCode ^
        durationInSeconds.hashCode;
  }
}
