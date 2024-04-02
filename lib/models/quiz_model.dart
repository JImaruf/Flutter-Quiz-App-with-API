class QuizModel {
  List<Questions>? questions;

  QuizModel({this.questions});

  QuizModel.fromJson(Map<String, dynamic> json) {
    if (json['questions'] != null) {
      questions = <Questions>[];
      json['questions'].forEach((v) {
        questions!.add(new Questions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.questions != null) {
      data['questions'] = this.questions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Questions {
  String? question;
  Answers? answers;
  String? questionImageUrl;
  String? correctAnswer;
  int? score;

  Questions(
      {this.question,
        this.answers,
        this.questionImageUrl,
        this.correctAnswer,
        this.score});

  Questions.fromJson(Map<dynamic, dynamic> json) {
    question = json['question'];
    answers =
    json['answers'] != null ? new Answers.fromJson(json['answers']) : null;
    questionImageUrl = json['questionImageUrl'];
    correctAnswer = json['correctAnswer'];
    score = json['score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question'] = this.question;
    if (this.answers != null) {
      data['answers'] = this.answers!.toJson();
    }
    data['questionImageUrl'] = this.questionImageUrl;
    data['correctAnswer'] = this.correctAnswer;
    data['score'] = this.score;
    return data;
  }
}

class Answers {
  String? a;
  String? b;
  String? c;
  String? d;

  Answers({this.a, this.b, this.c, this.d});

  Answers.fromJson(Map<String, dynamic> json) {
    a = json['A'];
    b = json['B'];
    c = json['C'];
    d = json['D'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['A'] = this.a;
    data['B'] = this.b;
    data['C'] = this.c;
    data['D'] = this.d;
    return data;
  }
}