import 'package:quizzler/questions.dart';

class QuizBrain{
  int _questionIndex=0;
  List<Questions> _quesList = [
    new Questions(q: 'is Flutter helpful', a: true),
    new Questions(q: 'delhi is capital of India', a: true),
    new Questions(q: 'Mumbai is in Uttarpradesh', a: true)
  ];

  void nextQuestion(){
    if(_questionIndex < _quesList.length -1)
      _questionIndex++;
  }
  String getQuestion(){
    return _quesList[_questionIndex].question;
  }
  bool getAnswer (){
    return _quesList[_questionIndex].answer;
  }

  bool isLastQuesion(){
    if(_questionIndex < _quesList.length-1)
      return false;
    else return true;
  }
  void setQuitionNumer(){
    _questionIndex=0;
    getQuestion();
  }
}