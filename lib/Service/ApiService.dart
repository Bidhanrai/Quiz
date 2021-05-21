import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quick_quiz/Model/QuizQuestionModel.dart';

class ApiService{
  String host = "https://opentdb.com/api.php?amount=10";

  // int category;
  // String difficulty = "easy";

  double progressValue = 0;
  List<int> selectedOption;

  Future<List<QuizQuestionModel>> getQuizDetails( int category, String difficulty) async{
    String url;
    if(difficulty == "any") {
      url = host+"&category=$category";
    } else {
      url = host+"&category=$category&difficulty=$difficulty";
    }
    final response = await http.get(Uri.parse(url));
    final parsedData = json.decode(utf8.decode(response.bodyBytes));
    try {
      var data = (parsedData["results"] as List).map((data) => QuizQuestionModel.fromJson(data)).toList();
      progressValue = 1/(data.length+1);
      selectedOption = List.generate(data.length, (index) => null);
      return data;
    } catch(e) {
      print(e.toString());
      return [];
    }

  }
}