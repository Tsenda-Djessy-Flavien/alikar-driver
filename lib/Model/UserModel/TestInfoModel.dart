class TestInfo {
  List<QuestionInfo>? questionTestInfo;

  TestInfo({this.questionTestInfo});

  TestInfo.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      questionTestInfo = <QuestionInfo>[];
      json['results'].forEach((v) {
        questionTestInfo!.add(QuestionInfo.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (questionTestInfo != null) {
      data['results'] = questionTestInfo!.map((v) => v.toJson()).toList();
    }
       return data;
  }
}

class QuestionInfo {
  String? sId;
  String? label;
  int? note;
  String? type;
  List? answers;
  String? createdAt;

  QuestionInfo(
      {
        this.sId,
        this.label,
        this.note,
        this.type,
        this.answers,
        this.createdAt});

  QuestionInfo.fromJson(Map<String, dynamic> json)
  {
    sId = json['_id'];
    label = json['label'];
    note = json['note'];
    type = json['type'];
    if (json['answers'] != null) {
      answers = [];
      json['answers'].forEach((v) {
        answers!.add(v.fromJson(v));
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
    if (answers != null)
    {
      data['answers'] = answers!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    return data;
  }
}



QuestionInfo questionTestInfoInstance = QuestionInfo();