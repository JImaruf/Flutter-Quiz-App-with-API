import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizappbymaruf/controller/quiz_controller.dart';
import 'package:quizappbymaruf/pages/quiz_page.dart';
class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    return GetBuilder<QuizController>(builder: (ctrl) {
      return Scaffold(
        appBar: AppBar(

          title: const Text('Quiz App', style: TextStyle(color: Colors.amber,),),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green, width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: FutureBuilder(future: ctrl.getHighScore(), builder: (context, snapshot) {
                        if(snapshot.hasData)
                          {
                            return Text('Highest Score : ${ctrl.highestScore}/${ctrl.totalScore}',style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w600),);
                          }
                        else
                          {
                            return const Text('Highest Score : Loading',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),);
                          }
                      },)
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20,),
              Center(
                child: Container(
                  height: size.height / 2,
                  width: size.width / 1.5,
                  child: const Image(
                   filterQuality: FilterQuality.high,
                   fit: BoxFit.cover,
                    image: AssetImage('assets/cup.png',

                  ),
                ),
                ),
              ),


              const Spacer(),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text('Welcome to Our ', style: TextStyle(color: Colors.amber,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),),
                Text('Quiz Game!', style: TextStyle(color: Colors.lightGreen,
                    fontSize: 28,
                    fontWeight: FontWeight.bold),),
              ],),
              const SizedBox(height: 20,),

              //Spacer(),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => const QuizPage());
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    alignment: Alignment.center,
                    // width: size.width - 100,
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text("Start Quiz",style: TextStyle(fontSize: 18,color: Colors.white),),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
