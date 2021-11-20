import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:quizzler/questions.dart';
import 'package:quizzler/quizbrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = new QuizBrain();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  const Quizzler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Quizpage(),
          ),
        ),
      ),
    );
  }
}

class Quizpage extends StatefulWidget {
  const Quizpage({Key? key}) : super(key: key);

  @override
  _QuizpageState createState() => _QuizpageState();
}

class _QuizpageState extends State<Quizpage> {
  List<Icon> iconList = [
    // Icon(Icons.check, color: Colors.green,),
    // Icon(Icons.close, color: Colors.red,)
  ];

  /*List<String> qutionsList= [
    'is Flutter helpful',
    'delhi is capital of India',
    'Mumbai is in Uttarpradesh'
  ];*/
  int QuetionIndex = 0;
  void showAlert(){
    Alert(context:context, title: 'Completed',desc: 'Congratulation, you have successfully completed the course',
      buttons: [
        DialogButton(child: Text(
          'Done',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white
          ),
        ), onPressed:(){
          Navigator.pop(context);
        }, width: 120,),
      ]
    ).show();
  }
  void getAnswer(bool userAnswer){
    bool answer= quizBrain.getAnswer();
    if (answer == userAnswer)
      iconList.add(Icon(
        Icons.check,
        color: Colors.green,
      ));
    else
      iconList.add(Icon(Icons.close, color: Colors.red));
    setState(() {
      if(!quizBrain.isLastQuesion())
          quizBrain.nextQuestion();
      else {
        showAlert();
        iconList.clear();
        quizBrain.setQuitionNumer();
      }
    });
  }

  //List<bool> answerList=[true,true,true];
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Center(
              child: Container(
                child: Text(
                  //qutionsList[QuetionIndex],
                  //quizBrain.quesList[QuetionIndex].question,
                  quizBrain.getQuestion(),
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.green,
                  alignment: Alignment.center,
                ),
                onPressed: () {
                  getAnswer(true);
                },
                child: Text(
                  'True',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                )),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.red),
              child: Text(
                'False',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
                // if (!quizBrain.getAnswer())
                //   iconList.add(Icon(
                //     Icons.check,
                //     color: Colors.green,
                //   ));
                // else
                //   iconList.add(Icon(
                //     Icons.close,
                //     color: Colors.red,
                //   ));
                // setState(() {
                //   quizBrain.nextQuestion();
                // });
                getAnswer(false);
              },
            ),
          ),
        ),
        Row(
          // children: <Widget>[
          //   Icon(Icons.check,color: Colors.green,),
          //   Icon(Icons.close, color: Colors.red,)
          // ],
          children: iconList,
        )
      ],
    );
  }
}
