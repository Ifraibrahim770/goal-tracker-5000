

class Goal {
  String? name;
  DateTime? creationDate;
  String? primaryColor;
  String? secondaryColor;
  String? duration;
  bool? isComplete;
  List<dynamic>? progress;

  Goal(this.name, this.creationDate, this.duration, this.primaryColor, this.secondaryColor,
      this.isComplete, this.progress);

  factory Goal.fromJson(Map<String, dynamic> parsedJson) {
    return Goal(
      parsedJson['name'] ?? "",
      parsedJson["creationDate"] == null ? null : DateTime.parse(parsedJson["creationDate"]),
      parsedJson['duration'] ?? "",
      parsedJson['primaryColor'] ?? "",
      parsedJson['secondaryColor'] ?? "",
      parsedJson['isComplete'] ?? "",
      parsedJson['progress'] ?? "",
    );
  }


  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "creationDate": creationDate?.toIso8601String(),
      "duration": duration,
      "primaryColor": primaryColor,
      "secondaryColor":secondaryColor,
      "isComplete": isComplete,
      "progress": progress
    };
  }


}

class Progress {
  DateTime? dateCreated;
  bool? isDone;
  bool? isManualUpdate;

  Progress(this.dateCreated, this.isDone, this.isManualUpdate);


  factory Progress.fromJson(Map<String, dynamic> parsedJson) {
    return Progress(
      parsedJson["dateCreated"] == null ? null : DateTime.parse(parsedJson["dateCreated"]),
      parsedJson['isDone'] ?? "",
      parsedJson['isManualUpdate'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "dateCreated": dateCreated?.toIso8601String(),
      "isDone": isDone,
      "isManualUpdate": isManualUpdate
    };
  }
}