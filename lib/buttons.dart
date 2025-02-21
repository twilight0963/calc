import 'package:flutter/material.dart';

Widget calButton(double size,String text,{bool isWhite=false,required Function onClick}) {
  ButtonStyle style = ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple, padding: const EdgeInsets.all(10),foregroundColor: Colors.white,textStyle: TextStyle(fontSize: size));
  if (isWhite){
    style = ElevatedButton.styleFrom(backgroundColor: Colors.white, padding: const EdgeInsets.all(10),foregroundColor: Colors.deepPurple,textStyle: TextStyle(fontSize: size));
  }
    return SizedBox(
      width: size*3,
      height:size*3,
      child: ElevatedButton(onPressed: (){ onClick(); }, style: style,child: Text(text)),
    );
}

Widget numButton(double size,String text,{required Function onClick}) {
    return SizedBox(
      width: size*3,
      height: size*3,
      child: ElevatedButton(onPressed: (){ onClick(); }, style: ElevatedButton.styleFrom(backgroundColor: const Color.fromRGBO(40, 40, 40, 1),
                                        padding: const EdgeInsets.all(10),foregroundColor: Colors.white,textStyle: TextStyle(fontSize: size)), child: Text(text)),
    );
}