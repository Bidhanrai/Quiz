import 'package:flutter/material.dart';
import 'package:quick_quiz/Constant/Constant.dart';
import 'package:quick_quiz/View/HomeView.dart';

class QuizCompleteView extends StatelessWidget {
  const QuizCompleteView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: LinearProgressIndicator(
            value: 1,
            minHeight: 10,
            semanticsLabel: "quiz progress bar",
            backgroundColor: Constant.primaryColorLighter,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Congrats! You completed\nthe quiz.",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 20),
            Image.asset("asset/congrats.gif"),
            SizedBox(height: 20),

            TextButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeView()), (route) => false);
               },
              child: Text("Mark Complete", style: TextStyle(color: Colors.white),),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green),
                padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 20)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
