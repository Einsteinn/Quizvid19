import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:trabalho_final/components/centered_circular_progress.dart';
import 'package:trabalho_final/components/centered_message.dart';
import 'package:trabalho_final/components/finish_dialog.dart';
import 'package:trabalho_final/components/result_dialog.dart';
import 'package:trabalho_final/controller/quiz_controller.dart';

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final _controller = QuizController();
  List<Widget> _scoreKeeper = [];

  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    await _controller.initialize();

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text(
          'QUIZVID-19',
          style: TextStyle(
            fontSize: 25.0,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 20.0,
      ),
      backgroundColor: Colors.blue[100],
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: _buildQuiz(),
        ),
      ),
    );
  }

  _buildQuiz() {
    if (_loading) return CenteredCircularProgress();

    if (_controller.questionsNumber == 0)
      return CenteredMessage(
        'Sem questões',
        icon: Icons.warning,
      );

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _buildQuestion(_controller.getQuestion()),
        _buildAnswerButton(_controller.getAnswer1()),
        _buildAnswerButton(_controller.getAnswer2()),
        _buildScoreKeeper(),
      ],
    );
  }

  _buildQuestion(String question) {
    return Expanded(
      flex: 5,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          shadowColor: Colors.blue,
          elevation: 20,
          color: Colors.white.withOpacity(0.7),
          child: Column(
            children: [
              ListTile(
                title: Text(
                    'PERGUNTA (${_scoreKeeper.length + 1}/${_controller.questionsNumber + 1}):'),
                //subtitle: ),
              ),
              Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    _controller.getQuestion(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30.0,
                      color: Colors.black,
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  _buildAnswerButton(String answer) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: GestureDetector(
          child: Container(
            padding: EdgeInsets.all(4.0),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue[800], Colors.blue[300]],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                color: Colors.blue[900],
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    bottomRight: Radius.circular(25.0),
                    topRight: Radius.circular(25.0),
                    bottomLeft: Radius.circular(25.0))),
            child: Center(
              child: AutoSizeText(
                answer,
                maxLines: 2,
                minFontSize: 10.0,
                maxFontSize: 32.0,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
          onTap: () {
            bool correct = _controller.correctAnswer(answer);
            ResultDialog.show(
              context,
              question: _controller.question,
              correct: correct,
              onNext: () {
                setState(() {
                  _scoreKeeper.add(
                    Icon(
                      correct ? Icons.check : Icons.close,
                      color: correct ? Colors.green : Colors.red,
                    ),
                  );

                  if (_scoreKeeper.length < _controller.questionsNumber) {
                    _controller.nextQuestion();
                  } else {
                    FinishDialog.show(context,
                        hitNumber: _controller.hitNumber,
                        questionNumber: _controller.questionsNumber);
                  }
                });
              },
            );
          },
        ),
      ),
    );
  }

  _buildScoreKeeper() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        child: Wrap(
          spacing: 10,
          alignment: WrapAlignment.center,
          direction: Axis.horizontal, // we need to specify the direction
          children: _scoreKeeper,
        ),
      ),
    );
  }
}
