
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:quizappbymaruf/models/quiz_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
class QuizController extends GetxController{
  bool permitted=false;
  var seconds = 20;
  bool timerFtime=true;
  int currentScore=0;
  int totalScore=0;
  int highestScore=0;
  Timer? timer;
  List<Questions> allQuestionData=[];
  late Map optionsMap;
  var optionList = [];
  var data1;
  var optionListNumber = [];
  var currentIndex = 0;
  bool isCliked = false;
  var optionsColor = [
    Colors.amber,
    Colors.amber,
    Colors.amber,
    Colors.amber,
  ];
  String apiLink = "https://herosapp.nyc3.digitaloceanspaces.com/quiz.json";



  getData()
  {
    optionsMap =data1["questions"][currentIndex]["answers"] as Map;
    optionListNumber=optionsMap.keys.toList();
    optionList=optionsMap.values.toList();
    if(timerFtime)
    {
      timerFtime=false;
      startTimer();
    }
  }

  Future<List<Questions>>fetchData () async {

    final response =await http.get(Uri.parse(apiLink));
    if(response.statusCode==200)
      {
        allQuestionData.clear();
        print("Success");
        var data = jsonDecode(response.body)["questions"] as List;
        data1 = jsonDecode(response.body.toString());
        for(Map i in data){
          allQuestionData.add(Questions.fromJson(i));
        }
        getTotalScore();

      }
    // if(timerFtime)
    //   {
    //     timerFtime=false;
    //     startTimer();
    //   }
    permitted=true;
    return allQuestionData;
  }
  @override
  void onInit() {
     fetchData();
    // TODO: implement onInit
    super.onInit();
  }
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();

  }
  @override
  void onClose() {
    timer?.cancel();
    // TODO: implement onClose
    super.onClose();
  }

  resetColors() {
    optionsColor = [
      Colors.amber,
      Colors.amber,
      Colors.amber,
      Colors.amber,
    ];
  }
  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (seconds > 0) {
          seconds--;
          update();
        } else {
          totalScore=totalScore+allQuestionData[currentIndex].score!.toInt();
          gotoNextQuestion();
        }

    });
  }
  gotoNextQuestion() {
    if (currentIndex < allQuestionData.length - 1) {
      currentIndex++;
      resetColors();
      timer!.cancel();
      seconds = 20;
      startTimer();
      isCliked=false;

    } else {
      timer!.cancel();
      if(currentScore>highestScore){
        highestScore=currentScore;
        storeHighScoreData();
      }
      resetAll();
      Get.back();
      //here you can do whatever you want with the results
    }
  }
  resetAll(){
    isCliked=false;
    timer?.cancel();
    seconds = 20;
    currentScore=0;
    currentIndex=0;
    resetColors();
    update();
  }

  storeHighScoreData() async {
   var prefs = await SharedPreferences.getInstance();
   prefs.setInt("highestScore", highestScore);
  }
  getTotalScore(){
    totalScore=0;
    for(int i=0; i<allQuestionData.length;i++)
      {
        totalScore=totalScore+allQuestionData[i].score!.toInt();
      }
    storeTotalScore();
  }
  Future<int> getHighScore() async {
   var prefs = await SharedPreferences.getInstance();
   int? getValueofHighest = prefs.getInt("highestScore");
   int? getValueofTotal = prefs.getInt("totalScore");
   highestScore = getValueofHighest ?? 0;
   totalScore = getValueofTotal ?? 0;
   return highestScore;
  }
  storeTotalScore()
  async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setInt("totalScore", totalScore);
  }


}