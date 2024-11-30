import 'dart:convert';

TimeEntries timeEntriesFromJson(String str) =>
    TimeEntries.fromJson(json.decode(str));

class TimeEntries {
  List<TimeEntry> timeEntries;

  TimeEntries({
    required this.timeEntries,
  });

  factory TimeEntries.fromJson(Map<String, dynamic> json) => TimeEntries(
        timeEntries: List<TimeEntry>.from(
            json["data"].map((x) => TimeEntry.fromJson(x))),
      );

  int get userId {
    return 1;
  }

  List<TimeEntry> get lastTimeEntries {
    return timeEntries
        .where((timeEntry) =>
            timeEntry.userId == userId && timeEntry.endTime != null)
        .toList();
  }

  List<GroupedTimeEntries> get groupedTimeEntries {
    List<GroupedTimeEntries> groupedList = [];

    for (var entry in lastTimeEntries) {
      String dateKey =
          '${entry.startTime.year}-${entry.startTime.month.toString().padLeft(2, '0')}-${entry.startTime.day.toString().padLeft(2, '0')}';

      GroupedTimeEntries? existingGroup = groupedList.firstWhere(
        (group) => group.date == dateKey,
        orElse: () => GroupedTimeEntries(date: dateKey, timeEntries: []),
      );

      if (existingGroup.timeEntries.isEmpty ||
          !groupedList.contains(existingGroup)) {
        groupedList.add(existingGroup);
      }
      existingGroup.timeEntries.add(entry);
    }

    return groupedList;
  }

  TimeEntry? get currentTimeEntry {
    return timeEntries.firstWhere(
        (timeEntry) => timeEntry.userId == userId && timeEntry.endTime == null);
  }
}

class GroupedTimeEntries {
  String date;
  List<TimeEntry> timeEntries;

  GroupedTimeEntries({
    required this.date,
    required this.timeEntries,
  });
}

class TimeEntry {
  int id;
  DateTime startTime;
  DateTime? endTime;
  String? description;
  String? clientName;
  String? projectName;
  int userId;
  String userName;

  TimeEntry({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.description,
    required this.clientName,
    required this.projectName,
    required this.userId,
    required this.userName,
  });

  factory TimeEntry.fromJson(Map<String, dynamic> json) => TimeEntry(
        id: json["id"],
        startTime: DateTime.parse(json["startTime"]),
        endTime:
            json["endTime"] == null ? null : DateTime.parse(json["endTime"]),
        description: json["description"],
        clientName: json["clientName"],
        projectName: json["projectName"],
        userId: json["userId"],
        userName: json["userName"],
      );

  String get duration {
    if (endTime == null) {
      return '';
    }
    final difference = endTime!.difference(startTime).inSeconds;
    int h, m, s;
    h = difference ~/ 3600;
    m = ((difference - h * 3600)) ~/ 60;
    s = difference - (h * 3600) - (m * 60);
    final hourLeft = h.toString().length < 2 ? '0$h' : h.toString();
    final minuteLeft = m.toString().length < 2 ? '0$m' : m.toString();
    final secondsLeft = s.toString().length < 2 ? '0$s' : s.toString();
    final result = '$hourLeft:$minuteLeft:$secondsLeft';
    return result;
  }

  String get startTimeRaw {
    return startTime.toString().substring(10, 16);
  }

  String get endTimeRaw {
    return endTime.toString().substring(10, 16);
  }
}
