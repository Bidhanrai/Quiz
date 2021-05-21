import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:quick_quiz/Constant/Constant.dart';
import 'package:quick_quiz/Model/QuizQuestionModel.dart';
import 'package:quick_quiz/Service/ApiService.dart';
import 'package:quick_quiz/View/QuizCompleteView.dart';
import 'package:html/parser.dart';

class QuizView extends StatefulWidget {
  final int category;
  final String difficulty;
  const QuizView({Key key, this.difficulty, this.category}) : super(key: key);

  @override
  _QuizViewState createState() => _QuizViewState();
}

class _QuizViewState extends State<QuizView> {
  ApiService _apiService = ApiService();
  
  int _currentPage = 0;
  PageController _pageController = PageController();

  Future<List<QuizQuestionModel>> data;

  @override
  void initState() {
    super.initState();
    data = _apiService.getQuizDetails(widget.category, widget.difficulty);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _progressBarWidget(),
      body: FutureBuilder(
        future: data,
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.done) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Question ${_currentPage + 1}/10"),
                  Divider(height: 20),
                  Expanded(
                    child: _pageView(snapshot as AsyncSnapshot<List<QuizQuestionModel>>),
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Constant.primaryColorLight),
                strokeWidth: 6,
              ),
            );
          }

        },
      ),
    );
  }

  Widget _progressBarWidget() {
    return AppBar(
      title: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: LinearProgressIndicator(
          value: _apiService.progressValue,
          minHeight: 10,
          semanticsLabel: "quiz progress bar",
          backgroundColor: Constant.primaryColorLighter,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
        ),
      ),
    );
  }

  Widget _pageView(AsyncSnapshot<List<QuizQuestionModel>> listSnapshot) {
    print(listSnapshot.data.length);
    return PageView.builder(
      itemCount: listSnapshot.data.length,
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      onPageChanged: (int pageNumber) {
        setState(() {
          _currentPage = pageNumber;
          _apiService.progressValue = ((pageNumber+1).toDouble())/(listSnapshot.data.length+1);
        });
      },
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _questionWidget(listSnapshot.data[index].question)),

            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: listSnapshot.data[index].options.length,
              itemBuilder: (context, optionIndex) {
                return _optionWidget(index, optionIndex, listSnapshot.data);
              },
            ),
          ],
        );
      },
    );
  }

  Widget _questionWidget(String question) {
    final document = parse(question);
    final String parsedString = parse(document.body.text).documentElement.text;
    return ListView(
      padding: EdgeInsets.only(top: 10),
      children: [
        Text(
          parsedString,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ],
    );
  }

  Widget _optionWidget(int index, int optionIndex, List<QuizQuestionModel> data) {
    return Column(
      children: [
        ListTile(
          title: Text(
            data[index].options[optionIndex],
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          tileColor: Constant.primaryColorLight,
          trailing: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Constant.primaryColorLight,
              border: Border.all(color: Colors.white, width: 3)
            ),
            child: _apiService.selectedOption[index] == optionIndex
                ? Icon(Icons.done_rounded, color: Colors.white, size: 20,)
                : SizedBox()
          ),
          onTap: () {
            setState(() {
              _apiService.selectedOption[index] = optionIndex;
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return _bottomSheetWidget(index,data);
                  });
            });
          },
        ),
        SizedBox(height: 10)
      ],
    );
  }

  Widget _bottomSheetWidget(int index,List<QuizQuestionModel> data) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            data[index].options[_apiService.selectedOption[index]] == data[index].correctAnswer
                ? "Good Job !"
                : "Wrong",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 20),
          TextButton(
            onPressed: () {
             if( data[index].options[_apiService.selectedOption[index]] == data[index].correctAnswer && (_pageController.page+1).toInt() == data.length) {
               Navigator.pop(context);
               Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>QuizCompleteView()));
              } else if( data[index].options[_apiService.selectedOption[index]] == data[index].correctAnswer) {
                Navigator.pop(context);
                _pageController.nextPage(duration: Duration(milliseconds: 400), curve: Curves.easeIn);
              }
              else {
                Navigator.pop(context);
              }
            },
            child: Text( data[index].options[_apiService.selectedOption[index]] == data[index].correctAnswer ?"Next !": "Try Again !", style: TextStyle(color: Colors.white,),),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all( data[index].options[_apiService.selectedOption[index]] == data[index].correctAnswer ?Constant.primaryColorLight: Colors.red),
                padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 20))
            ),
          ),
        ],
      ),
    );
  }
}


