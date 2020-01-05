import 'package:flutter/material.dart';
import 'dart:io';
import 'quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = new QuizBrain();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scorekeeper = [];

  void checkAnswer(bool userpickedAnswer) {
    setState(() {
      if (quizBrain.getAnswer() == userpickedAnswer) {
        scorekeeper.add(Icon(
          Icons.check,
          color: Colors.green,
        ));
      } else {
        scorekeeper.add(Icon(
          Icons.close,
          color: Colors.red,
        ));
      }

      quizBrain.nextQuestion();
    });
  }
  /* List<String> questions = [
    ,
    'Approximately one quarter of human bones are in the feet.',
    'A slug\'s blood is green.'
  ];*/
  /* List<bool> answers = [false, true, true];*/

/*
  Question q1 = Question(
      q: 'You can lead a cow down stairs but not up stairs.', a: false);*/

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                //questions[Random().nextInt(2)],
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                checkAnswer(true);
                if (quizBrain.isFinished() && quizBrain.getAnswer() == true) {
                  Alert(
                      context: context,
                      title: "Thank You for Playing",
                      buttons: [
                        DialogButton(
                          onPressed: () {
                            setState(() {
                              quizBrain.reset();
                              scorekeeper.clear();
                              Navigator.pop(context);
                            });
                          },
                          child: Text("Reset"),
                        ),
                        DialogButton(
                          child: Text(
                            "Close",
                          ),
                          onPressed: () => exit(0),
                          color: Colors.red,
                        )
                      ]).show();
                }
                //The user picked true.
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkAnswer(false);
                if (quizBrain.isFinished() && quizBrain.getAnswer() == false) {
                  Alert(
                      context: context,
                      title: "Thank You for Playing",
                      buttons: [
                        DialogButton(
                          onPressed: () {
                            setState(() {
                              quizBrain.reset();
                              scorekeeper.clear();
                              Navigator.pop(context);
                            });
                          },
                          child: Text("Reset"),
                        ),
                        DialogButton(
                          child: Text(
                            "Close",
                          ),
                          onPressed: () => exit(0),
                          color: Colors.red,
                        )
                      ]).show();
                }
                //The user picked false.
              },
            ),
          ),
        ),
        Row(
          children: scorekeeper,
        )
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
