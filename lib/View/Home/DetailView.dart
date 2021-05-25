import 'package:flutter/material.dart';
import 'package:quick_quiz/Constant/Constant.dart';
import 'package:quick_quiz/View/Home/QuizView.dart';

class DetailView extends StatefulWidget {

  final int categoryNumber;
  final String category;
  final String imageUrl;
  const DetailView({Key key, this.category, this.imageUrl, this.categoryNumber}) : super(key: key);

  @override
  _DetailViewState createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
      ),
      body: Column(
        children: [
          Hero(
            tag: widget.category,
            child: Image.asset(widget.imageUrl),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 4),
              child: Wrap(
                direction: Axis.horizontal,
                spacing: 10,
                runSpacing: 10,
                children: [
                  SizedBox(height: 5),
                  _button("Any"),

                  SizedBox(height: 5),

                  _button("Easy"),

                  SizedBox(height: 5),

                  _button("Medium"),

                  SizedBox(height: 5),

                  _button("Hard"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _button(String label) {
    return TextButton(
      child: Text(label, style: TextStyle(color: Colors.white),),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Constant.primaryColorLight),
      ),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>QuizView(difficulty: label.toLowerCase(), category: widget.categoryNumber,)));
      },
    );
  }
}
