class Questions {
  String question;
  int index;

  Questions({
    this.index,
    this.question,
  });

  factory Questions.fromJson(Map<String, dynamic> qsn) {
    return (Questions(question: qsn['question'], index: qsn['index']));
  }
}

class QuestionsList {
  List<Questions> qsnList;

  QuestionsList({this.qsnList});

  factory QuestionsList.fromJson(List<dynamic> questionList) {
    return (QuestionsList(
        qsnList: questionList.map((i) => Questions.fromJson(i)).toList()));
  }



}
