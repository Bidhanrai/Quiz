import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:quick_quiz/Constant/Constant.dart';
import 'package:quick_quiz/ViewModel/QuizViewModel.dart';

class QuizView extends StatefulWidget {
  const QuizView({Key key}) : super(key: key);

  @override
  _QuizViewState createState() => _QuizViewState();
}

class _QuizViewState extends State<QuizView> {

  QuizViewModel _quizViewModel = QuizViewModel();

  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Slider(
          value: 0.5,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Question ${_currentPage+1}/10"),
            Divider(height: 20),

            Expanded(
              child: _pageView(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _questionWidget(String question) {
    return ListView(
      padding: EdgeInsets.only(top: 10),
      children: [
        Text(
          question,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ],
    );
  }

  Widget _pageView() {
    return PageView.builder(
      itemCount: _quizViewModel.quizViewData.length,
      //physics: NeverScrollableScrollPhysics(),
      onPageChanged: (int pageNumber) {
        setState(() {
          _currentPage = pageNumber;
        });
      },
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _questionWidget(_quizViewModel.quizViewData[index]["question"])),

            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _quizViewModel.quizViewData[index]["option"].length,
              itemBuilder: (context, optionIndex) {
                return _optionWidget(index, optionIndex);
              },
            ),
          ],
        );
      },
    );
  }

  _optionWidget(int index, int optionIndex) {
    return Column(
      children: [
        ListTile(
          title: Text(
            _quizViewModel.quizViewData[index]["option"][optionIndex],
            style: TextStyle(color: Colors.black,),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          tileColor: Constant.primaryColorLight,
          trailing: Radio(
            value: 1,
            groupValue: 1,
            onChanged: (value) {},
          ),
        ),
        SizedBox(height: 10)
      ],
    );
  }
}
