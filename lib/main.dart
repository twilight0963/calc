import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'buttons.dart' as w;
import 'back_end.dart' as calc_logic;

 
void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  
  @override
  
  Widget build(BuildContext context) {
    
    
    return ChangeNotifierProvider(
      create: (context) => calc_logic.BackEnd(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Calculator',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(brightness: Brightness.dark,seedColor: Colors.deepPurple),
        ),
        home: const FrontEnd(),
      ),
    );
  }
}

class FrontEnd extends StatelessWidget{
  const FrontEnd({super.key});

  @override


  Widget build(BuildContext context) {

    final MediaQueryData queryData = MediaQuery.of(context);
    final double totalX = queryData.size.width;
    final double totalY = queryData.size.height;
    final double buttonSize = totalY/25;
    var vars = context.watch<calc_logic.BackEnd>();
    var curNum = vars.nums[vars.curNum];
    var oper = vars.oper;
    TextEditingController field = TextEditingController();
    TextEditingController expr = TextEditingController();
    TextEditingController last = TextEditingController();
    last.text=vars.hist;
    field.text=curNum;
    expr.text="(${vars.nums[0]} $oper ${vars.nums[1]})";
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
        title: const Text('Calculator'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        ),
        drawer: Drawer(backgroundColor: Colors.black,
        child: ListView(
          padding: const EdgeInsets.all(12),
          children: [
          
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.deepPurple),
            padding: EdgeInsets.symmetric(vertical: totalY/40),
            child: Text('History:',style: TextStyle(color: Colors.white,fontSize: totalY/35,height: totalY/125),textAlign: TextAlign.center,)
          ),
          const Div(),
          w.calButton(onClick: () => {vars.clearHistory()},totalX/30,"Clear"), //HISTORY CLEAR BUTTON
          for (var i in vars.history)
          Container(
          padding: const EdgeInsets.only(top: 10),
          child: w.numButton(onClick: () => {vars.getHist(i)},16,"${i[0]}.   ${i[1]} ${i[2]} ${i[3]} = ${i[4]}") //HISTORY BUTTONS
          )]),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [ 
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children:[
              //Last Operation
                            
              TextField(controller: last,readOnly: true,decoration: const InputDecoration.collapsed(hintText:""),style: TextStyle(fontSize:(totalX/50+totalY/70),height: totalY/350,color: Colors.grey),textAlign: TextAlign.right,onTap: (){vars.del();},),
                            
              //Current Number
              TextField(controller: field, readOnly: true,decoration: const InputDecoration.collapsed(hintText:""),style: TextStyle(fontSize:(totalY/15),height: totalY/400,color: Colors.white),textAlign: TextAlign.right,onTap: (){vars.del();},),
                            
              //Current Expression
              TextField(controller: expr,readOnly: true,style: TextStyle(fontSize: (totalY/30),height: totalY/400,color: Colors.white24),textAlign: TextAlign.left,onTap: (){vars.del();},),]),
            
            const Div(),

            //CALCULATOR UI

            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        w.calButton(onClick: () => {vars.clear()},buttonSize,"C"),
                        w.calButton(isWhite: vars.operCol[4],onClick: () => {vars.changeOper("^")}, buttonSize, "^"),
                        w.calButton(onClick: () => {vars.changeSign(),}, buttonSize, "+/-"),
                        w.calButton(isWhite: vars.operCol[3],onClick: () => {vars.changeOper("/")}, buttonSize, "÷")
                      ],),
            const Div(),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        w.numButton(onClick: () => {vars.enterNum("7")}, buttonSize, "7"),
                        w.numButton(onClick: () => {vars.enterNum("8")},buttonSize, "8"),
                        w.numButton(onClick: () => {vars.enterNum("9")},buttonSize, "9"),
                        w.calButton(isWhite: vars.operCol[2],onClick: () => {vars.changeOper("*")}, buttonSize, "x"),
                      ]),
            const Div(),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        w.numButton(onClick: () => {vars.enterNum("4")},buttonSize, "4"),
                        w.numButton(onClick: () => {vars.enterNum("5")},buttonSize, "5"),
                        w.numButton(onClick: () => {vars.enterNum("6")},buttonSize, "6"),
                        w.calButton(isWhite: vars.operCol[1],onClick: () => {vars.changeOper("-")},buttonSize, "-"),
                      ],),
            const Div(),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        w.numButton(onClick: () => {vars.enterNum("1")},buttonSize, "1"),
                        w.numButton(onClick: () => {vars.enterNum("2")},buttonSize, "2"),
                        w.numButton(onClick: () => {vars.enterNum("3")},buttonSize, "3"),
                        w.calButton(isWhite: vars.operCol[0],onClick: () => {vars.changeOper("+")},buttonSize, "+"),
                      ],),
            const Div(),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        w.calButton(onClick: () => {vars.changeCurNum()},buttonSize/1.1, "-/-"),
                        w.numButton(onClick: () => {vars.enterNum("0")},buttonSize, "0"),
                        w.numButton(onClick: () => {vars.enterNum(".")},buttonSize, "."),
                        w.calButton(onClick: () => {vars.calc()},buttonSize, "="),
                      ],)
            ]
        ),
      ),
    );
  }


  
  }

class Div extends StatelessWidget {
  const Div({
    super.key,
  });
  
  //5px seperator

  @override
  Widget build(BuildContext context) {
    return const Padding(padding: EdgeInsets.symmetric(vertical: 1));
  }
}
