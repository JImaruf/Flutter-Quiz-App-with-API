// ListView.builder(
// shrinkWrap: true,
// scrollDirection: Axis.vertical,
// itemCount: ctrl.optionListNumber.length,
// itemBuilder: (context, index) {
// var correctAnswer = ctrl
//     .allQuestionData[ctrl.currentIndex]
//     .correctAnswer;
//
// return GestureDetector(
//
// onTap: () {
// if (!ctrl.isCliked) {
// if (correctAnswer.toString() ==
// ctrl.optionListNumber[index]) {
// ctrl.optionsColor[index] = Colors.green;
// ctrl.timer!.cancel();
// ctrl.currentScore = ctrl.currentScore + ctrl.allQuestionData[ctrl.currentIndex].score!.toInt();
// ctrl.update();
// } else {
// int a = ctrl.optionListNumber.indexOf(correctAnswer);
// ctrl.optionsColor[a] = Colors.green;
// ctrl.optionsColor[index] = Colors.red;
// ctrl.timer!.cancel();
// ctrl.update();
// }
// ctrl.totalScore = ctrl.totalScore +
// ctrl.allQuestionData[ctrl.currentIndex]
//     .score!
//     .toInt();
// Future.delayed(const Duration(seconds: 2),
// () {
// ctrl.gotoNextQuestion();
// ctrl.update();
// });
// ctrl.isCliked = true;
// }
// },
// child: Container(
// margin: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
// alignment: Alignment.center,
// padding: const EdgeInsets.all(15),
// decoration: BoxDecoration(color: ctrl.optionsColor[index],
// borderRadius: BorderRadius.circular(12),
// ),
// child: Text(
// ctrl.optionList[index] ?? "Null",
// style: TextStyle(color: Colors.white, fontSize: 17),
// ),
// ),
// );
// },
// ),