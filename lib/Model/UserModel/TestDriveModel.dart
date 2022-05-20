class TestDrive {
  List<QuestionDrive>? questionTestDrive;

  TestDrive({this.questionTestDrive});

  TestDrive.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      questionTestDrive = <QuestionDrive>[];
      json['results'].forEach((v) {
        questionTestDrive!.add(QuestionDrive.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (questionTestDrive != null) {
      data['results'] = questionTestDrive!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class QuestionDrive {
  String? sId;
  String? label;
  int? note;
  String? type;
  String? src;
  List<Answers>? answers;
  String? createdAt;

  QuestionDrive(
      {
        this.sId,
        this.label,
        this.note,
        this.type,
        this.src,
        this.answers,
        this.createdAt});

  QuestionDrive.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    label = json['label'];
    note = json['note'];
    type = json['type'];
    src = json['src'];
    if (json['answers'] != null) {
      answers = <Answers>[];
      json['answers'].forEach((v) {
        answers!.add(Answers.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = sId;
    data['label'] = label;
    data['note'] = note;
    data['type'] = type;
    data['src'] = src;
    if (answers != null) {data['answers'] = answers!.map((v) => v.toJson()).toList();}
    data['createdAt'] = createdAt;
    return data;
  }
}


class Answers {
  String? sId;
  String? label;
  bool? correct;

  Answers({this.sId, this.label, this.correct});

  Answers.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    label = json['label'];
    correct = json['correct'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = sId;
    data['label'] = label;
    data['correct'] = correct;
    return data;
  }
}

TestDrive testDriveInstance = TestDrive();
QuestionDrive questionDriveInstance = QuestionDrive();