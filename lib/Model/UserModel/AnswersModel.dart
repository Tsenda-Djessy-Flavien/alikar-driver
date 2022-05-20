class AnswersModel {
  String? questionId;
  String? label;
  String? note;
  String? type;
  bool? value;

  AnswersModel({this.questionId, this.label, this.note, this.type, this.value});

  AnswersModel.fromJson(Map<String, dynamic> json) {
    questionId = json['questionId'];
    label = json['label'];
    note = json['note'];
    type = json['type'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['questionId'] = questionId;
    data['label'] = label;
    data['note'] = note;
    data['type'] = type;
    data['value'] = value;
    return data;
  }
}
AnswersModel answersModelInstance = AnswersModel();
