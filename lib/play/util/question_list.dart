import 'package:game_quizz/play//models/questions.dart';

class QuestionsList {
  int _currentQuestion = 0;
  List<Question> _questionsBank = [
    Question(
      question: 'Việt Nam nằm châu nào?',
      answer: 'Châu Á',
      choices: [
        'Châu Âu',
        'Châu Á',
        'Châu Đại Dương',
        'Châu Lục',
      ],
    ),
    Question(
      question: 'Mặt trời có màu gì?',
      answer: 'Màu Đỏ',
      choices: [
        'Màu Hồng',
        'Màu Đỏ',
        'Màu Xanh lá',
        'Màu Lục',
      ],
    ),
    Question(
      question: 'Trái đất bao nhiêu tuổi',
      answer: '4,54 tỉ năm',
      choices: [
        '1,54 trăm năm',
        '4,54 tỉ năm',
        '1,45 tỉ năm',
        '3,54 triệu năm',
      ],
    ),
     Question(
      question: 'Quiz',
      answer: 'câu đố',
      choices: [
        'đố',
        'câu',
        'câu đố',
        'khác',
      ],
    ),
  ];

//Lấy văn bản cho câu hỏi hiện tại
  String getQuestion() => _questionsBank[_currentQuestion].question;

  // lấy câu trả lời cho câu hỏi hiện tại
  String getAnswer() => _questionsBank[_currentQuestion].answer;

  // lấy đáp án cho câu hỏi hiện tại 1
  String getChoiceOne() => _questionsBank[_currentQuestion].choices[0];

  // lấy đáp án cho câu hỏi hiện tại 2
  String getChoiceTwo() => _questionsBank[_currentQuestion].choices[1];

  //  lấy đáp án cho câu hỏi hiện tại 3
  String getChoiceThree() => _questionsBank[_currentQuestion].choices[2];

  //  lấy đáp án cho câu hỏi hiện tại 4
  String getChoiceFour() => _questionsBank[_currentQuestion].choices[3];

// cập nhật số câu hỏi hiện tại, nếu câu hỏi hoàn thành giá trị sẽ đặt lại về 0
  bool nextQuestion() {
    if (_currentQuestion < 15) {
      //_questionsBank.length - 1
      _currentQuestion++;
      return true;
    } else {
      _currentQuestion = 0;
      return false;
    }
  }


  //* 50/50 
  void removTowOption() {
    
    int counter = 0;
  
    int myCoun = 0;
    for (counter = 0; counter <= 3; counter++) {
      if (_questionsBank[_currentQuestion].choices[counter] !=
              _questionsBank[_currentQuestion].answer &&
          myCoun <= 1) {
        _questionsBank[_currentQuestion].choices[counter] = '  ';
        myCoun++;
      }
    }
  }

  void replaceQuestion() {
    _currentQuestion++;
  }
}
