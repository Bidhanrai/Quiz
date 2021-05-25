import 'package:flutter/material.dart';

class AboutView extends StatelessWidget {
  const AboutView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage("asset/anime.jpg"),
              radius: 60,
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.01,),

            Text("Quiz Quiz", textAlign: TextAlign.center, style: TextStyle(fontSize: 20),),

            SizedBox(height: MediaQuery.of(context).size.height*0.2,),
            Text(
              "Developed By\nBidhan Rai",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black87, fontSize: 16, fontWeight: FontWeight.w300),
            ),
          ],
        ),
      ),
    );
  }
}
