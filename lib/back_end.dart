import 'package:flutter/material.dart';
import 'dart:math';

class BackEnd extends ChangeNotifier {

  //VARIABLES:

  List<bool> operCol = [false,false,false,false,false];
  List<String> nums = ["0","0"];
  int hisCount = 0;
  final history = [];
  bool shouldEmpty = false;
  bool allClear = false;
  int curNum = 0;
  String oper = "+";
  String ans = "";
  String hist = "";

  //FUNCTIONS: 


  void clear(){
    if(allClear){ //Check for two consecutive taps on clear
      nums=["0","0"];
      shouldEmpty=false;
      curNum=0;
      notifyListeners();
      return;
    }
    allClear=true;
    nums[curNum]="0"; //Otherwise only clear current
    hist="";
    notifyListeners();
  }
  void changeCurNum(){
    allClear = false;
    
    switch (curNum){
      //If selectednum is 0 make 1, if its 1 make 0
      case 0: 
          curNum = 1;
          notifyListeners();
          break;
      case 1:
          curNum = 0;
          notifyListeners();
          break;
    }
  }
  void enterNum(String digit){
    allClear = false;
    emt(curNum);
    //DECIMAL HANDLING
    if (nums[curNum]=="0" && digit!="."){
      nums[curNum]=digit;
    }else{
      //DECIMAL SHIFT
      if (digit=="." && nums[curNum].contains(".")){ 
        nums[curNum] = nums[curNum].replaceAll(".", "");
      }
    nums[curNum]=nums[curNum]+digit;
    }
    notifyListeners();
    
  }
  void changeOper(String o){
    operCol = [false,false,false,false,false];
    switch (o){
      case "+": operCol[0] = true;
      case "-": operCol[1] = true;
      case "*": operCol[2] = true;
      case "/": operCol[3] = true;
      case "^": operCol[4] = true; 
      default: operCol = [false,false,false,false,false]; 
    }
    allClear = false;
    switch (curNum){
      case 0: emt(1);
              changeCurNum();
      //CONTINUOS OPERATIONS
      case 1: if (nums[1]!="0" && oper!=o){
                calc();
                changeCurNum();}
    }
    oper = o;
    notifyListeners();
  }

  void emt(a) {
    if (shouldEmpty){
      nums[a]="0";
      shouldEmpty=false;
      notifyListeners();
    }
  }
  void changeSign(){ 
    // + -
    if (nums[curNum]!="0"){
      switch (nums[curNum][0]){
        case "-": nums[curNum]=nums[curNum].substring(1);
        default: nums[curNum]="-${nums[curNum]}";
      }
    }
    notifyListeners();
  }

  void clearHistory(){
    hisCount=0;
    history.clear();
    notifyListeners();
  }

  void getHist(var histarray){
    //history menu -> current operation
    nums[0]=histarray[1];
    oper=histarray[2];
    nums[1]=histarray[3];
    hist = "";
    notifyListeners();
  }

  void del(){
    if (nums[curNum].length<=1){
      nums[curNum]="0";
    }else{
      nums[curNum]=nums[curNum].substring(0, nums[curNum].length - 1);
    }
    notifyListeners();
  }
  void calc(){
    allClear = false;
    hisCount++;
    
    if (history.length>=10){
      history.removeLast();
    }
    var n1 = num.parse(nums[0]);
    var n2 = num.parse(nums[1]);
    switch (oper){
      case "+": ans=(n1+n2).toStringAsFixed(4);
      case "-": ans=(n1-n2).toStringAsFixed(4);
      case "*": ans=(n1*n2).toStringAsFixed(4);
      case "/": ans=(n1/n2).toStringAsFixed(4);
      case "^": ans=pow(n1, n2).toStringAsFixed(4);
      default: ans="0";
    }
    ans=num.tryParse(ans).toString();
    hist = "${nums[0]} $oper ${nums[1]} = $ans";
    history.insert(0,<String>[hisCount.toString(),nums[0],oper,nums[1],ans]);
    nums[0]=ans;
    shouldEmpty=true;
    curNum=0;
    notifyListeners();
  }
}