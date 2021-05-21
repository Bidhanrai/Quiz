

class QuizQuestionModel {
  final String question;
  final String correctAnswer;
  final List options;

  QuizQuestionModel({this.correctAnswer, this.options, this.question,});

  factory QuizQuestionModel.fromJson(Map<String, dynamic> json) {
    List option = (json["incorrect_answers"] as List);
    option.add(json["correct_answer"]);
    option.shuffle();
    return QuizQuestionModel(
      question: json["question"],
      correctAnswer: json["correct_answer"],
      options: option,
    );
  }
}