
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizappbymaruf/controller/quiz_controller.dart';
import 'package:quizappbymaruf/pages/main_menu.dart';
class QuizPage extends StatelessWidget {
  const QuizPage({super.key});
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GetBuilder<QuizController>(builder: (ctrl) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent.shade200,
          title: Text(
            'Play Quiz',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              if (ctrl.currentScore > ctrl.highestScore) {
                ctrl.highestScore = ctrl.currentScore;
                ctrl.storeHighScoreData();
              }
              ctrl.resetAll();
              Get.offAll(() => MainMenu());
            },
            icon: Icon(
              Icons.cancel_outlined,
              size: 40,
              color: Colors.white,
            ),
          ),
        ),
        body: Padding(
          padding:  EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                FutureBuilder(
                  future: ctrl.getQuiz,
                  builder: (context, snapshot) {

                     if (snapshot.hasData && ctrl.getData())
                   {
                      return Column(

                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Text(ctrl.seconds.toString(),
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)),
                              SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                width: 50,
                                height: 50,
                                child: CircularProgressIndicator(
                                  value: ctrl.seconds / 10,
                                  valueColor: const AlwaysStoppedAnimation(
                                      Colors.redAccent),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            height: size.height / 4,
                            width: size.width / 1.5,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border:
                                Border.all(color: Colors.green, width: 4),
                                color: Colors.transparent),
                            child: Image(
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset('assets/quizloading.gif',);
                              },
                              height: size.height / 4,
                              width: size.width / 1.5,
                              image: NetworkImage(ctrl
                                  .allQuestionData[ctrl.currentIndex]
                                  .questionImageUrl
                                  .toString()),
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            padding: EdgeInsets.all(8),
                            margin: EdgeInsets.only(left: 12, right: 12),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.green, width: 2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "No of Q:${ctrl.currentIndex + 1} of ${ctrl.allQuestionData.length}",
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    Text(
                                      'Q Score:${ctrl.allQuestionData[ctrl.currentIndex].score}',
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      'Score:${ctrl.currentScore}/${ctrl.totalScore}',
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Card(
                              margin: EdgeInsets.only(left: 14, right: 14),
                              shadowColor: Colors.blue,
                              color: Colors.blueAccent,
                              elevation: 4,
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text(
                                          ctrl
                                              .allQuestionData[
                                                  ctrl.currentIndex]
                                              .question
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white)),
                                    ],
                                  ))),
                          SizedBox(
                            height: 20,
                          ),

                          GridView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: ctrl.optionListNumber.length,

                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                              childAspectRatio: 3,
                              mainAxisSpacing: 6,
                              crossAxisSpacing: 5,
                                  ),
                            itemBuilder: (context, index) {
                              var correctAnswer = ctrl
                                  .allQuestionData[ctrl.currentIndex]
                                  .correctAnswer;
                              return GestureDetector(
                                onTap: () {
                                  if (!ctrl.isCliked) {
                                    if (correctAnswer.toString() ==
                                        ctrl.optionListNumber[index]) {
                                      ctrl.optionsColor[index] = Colors.green;
                                      ctrl.timer!.cancel();
                                      ctrl.currentScore = ctrl.currentScore + ctrl.allQuestionData[ctrl.currentIndex].score!.toInt();
                                      ctrl.update();
                                    } else {
                                      int a = ctrl.optionListNumber.indexOf(correctAnswer);
                                      ctrl.optionsColor[a] = Colors.green;
                                      ctrl.optionsColor[index] = Colors.red;
                                      ctrl.timer!.cancel();
                                      ctrl.update();
                                    }
                                    Future.delayed(const Duration(seconds: 2),
                                            () {
                                          ctrl.gotoNextQuestion();
                                        });
                                    ctrl.isCliked = true;
                                  }
                                },
                                child: Container(
                                 // margin: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
                                  alignment: Alignment.center,
                                  //padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(color: ctrl.optionsColor[index],
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    ctrl.optionList[index] ?? "Null",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: Colors.white, fontSize: 16),
                                  ),
                                ),
                              );
                            },),

                        ],
                      );
                    } else {
                      return Center(
                        heightFactor: 2,
                        child: Container(
                          height: 300,
                            width: 300,
                            child: Image.asset('assets/quizloading.gif')),
                      );

                    }
                  },
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
