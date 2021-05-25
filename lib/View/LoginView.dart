import 'package:flutter/material.dart';
import 'package:quick_quiz/Constant/Constant.dart';
import 'package:quick_quiz/View/Home/HomeView.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage("asset/anime.jpg"),
              radius: 60,
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.05,),

            Text("Login to Start", textAlign: TextAlign.center, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600,),),
            SizedBox(height: MediaQuery.of(context).size.height*0.01,),
            Text("And start testing your general knowledge on various topics with quick quizzes.", style: TextStyle(fontSize: 16,),),
            SizedBox(height: MediaQuery.of(context).size.height*0.05,),

            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeView()));
              },
              child: Row(
                children: [
                  Text("G", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700),),
                  SizedBox(width: 30,),
                  Text("Login With Google", style: TextStyle(color: Colors.white, fontSize: 16),),
                ],
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Constant.primaryColor),
                padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 20, horizontal: 40))
              ),
            ),

            SizedBox(height: MediaQuery.of(context).size.height*0.03,),

            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeView()));
              },
              child: Text("Continue as Guest", style: TextStyle(color: Constant.primaryColor),),
            ),
          ],
        ),
      ),
    );
  }
}
