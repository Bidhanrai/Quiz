import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage("asset/politics.jpg"),
              radius: 50,
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.02,),

            Text("Bidhan Rai", textAlign: TextAlign.center, style: TextStyle(fontSize: 20),),
            Text("bidhanrai424@gmail.com", textAlign: TextAlign.center, style: TextStyle(fontSize: 16,),),

            SizedBox(height: MediaQuery.of(context).size.height*0.15,),

            Text("0", textAlign: TextAlign.center, style: TextStyle(fontSize: 30),),
            Text("Quizzes Completed", textAlign: TextAlign.center, style: TextStyle(),),

            SizedBox(height: MediaQuery.of(context).size.height*0.15,),

            TextButton(
              onPressed: () {},
              child: Text("Logout", style: TextStyle(color: Colors.white),),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
                padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 20,),)
              ),
            ),
          ],
        ),
      ),
    );
  }
}
