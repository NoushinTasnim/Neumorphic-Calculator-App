import 'dart:math';

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

Color myCustomColor = const Color.fromRGBO(235, 235, 245, 1);
const LinearGradient buttonGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Color(0xFF20B5F5),
    Color(0xFFFA3999),
  ],
);
const LinearGradient grad1 = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Color(0xFFF3F3F3),
    Color(0xFFF3F3F3),
  ],
);
const LinearGradient grad2 = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Color(0xFF232323),
    Color(0xFF232323),
  ],
);

var buttonGradientMain = grad1;
var buttonGradientMain2 = grad2;
var col1= Colors.black;
var col2 = Colors.white;

void main() {
  runApp(const MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget{
  const MyApp({Key? key}): super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  var input = "";
  var output = '';
  var operation = '';
  var hideInput = false;
  var outputSize = 34.0;
  var islog = 0;
  bool _switchValue = false;
  var textCol = Colors.black;
  var textCol2 = Colors.white;
  var bgCol = Color(0xFFF3F3F3);

  onButttonClick(value){
    if(value == "AC"){
      input = '';
      output = '';
    }
    else if(value == "CLR"){
      if(input.isNotEmpty)
        input = input.substring(0, input.length-1);
    }
    else if(value == "="){
      if(input.isNotEmpty){
        try {
          var userInput = input.replaceAll("x", "*");
          print(userInput);
          userInput = userInput.replaceAll("π", "3.14159");
          userInput = userInput.replaceAll("inv", "^-1");
          userInput = userInput.replaceAll("√", "sqrt");
          userInput = userInput.replaceAll("exp", "*10^");
          print(userInput);
          Parser p = Parser();
          Expression expression = p.parse(userInput);
          ContextModel cm = ContextModel();
          var finalValue = expression.evaluate(EvaluationType.REAL, cm);
          output = finalValue.toStringAsFixed(8);
          if (output.endsWith(".00000000")) {
            output = output.substring(0, output.length - 3);
          }
          input = output;
          hideInput = true;
          outputSize = 48;
        } catch (e) {
          output = 'Error: Invalid input';
        }
      }
    }
    else{
    
      // Append '*' if the last character is a number
      if(!isNumber(value) && input.isNotEmpty){
        bool isLastCharacterNumber = isNumber(input[input.length - 1]);
        if(isLastCharacterNumber){
          if(!(value=="+" || value=="-" ||value=="x" || value=="/" || value=="exp"|| value =="^" || value=="%" || value =="inv"))
          input = input + "*";
        }
      }
      input = input + value;
      hideInput = false;
      outputSize = 34;
    }

    setState(() {
      
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10,20,10,50), 
      color:  bgCol,
      child: Scaffold(
        backgroundColor: bgCol,
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 40), // Set the desired margin
              child: Container(
                width: 80,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: col2 ,
                      offset: Offset(-4, -4),
                      blurRadius: 2,
                      spreadRadius: 1,
                    ),
                    BoxShadow(
                      color: col1.withOpacity(0.25),
                      offset: const Offset(4, 4),
                      blurRadius: 2,
                      spreadRadius: -1,
                    ),
                  ],
                ),
                child:NeumorphicSwitch(
                  value: _switchValue,
                  height: 30,
                  style: const NeumorphicSwitchStyle(
                    activeThumbColor: Color(0xFF232323),
                    activeTrackColor: Color(0xFFF3F3F3),
                    thumbShape: NeumorphicShape.flat,
                    thumbDepth: 20,
                    inactiveThumbColor: Color(0xFFF3F3F3),
                    inactiveTrackColor: Color(0xFF232323),
                  ),
                  onChanged: (bool value) {
                    setState(() {
                      _switchValue = value;
                      if(value){
                        buttonGradientMain = grad2;
                        buttonGradientMain2 = grad1;
                        textCol=Colors.white;
                        textCol2=Colors.black;
                        bgCol = Color(0xFF232323);
                        col1 = Colors.white;
                        col2 = Colors.black;
                      }
                      else{
                        buttonGradientMain = grad1;
                        buttonGradientMain2 = grad2;
                        textCol=Colors.black;
                        textCol2=Colors.white;
                        bgCol=Color(0xFFF3F3F3);
                        col2 = Colors.white;
                        col1 = Colors.black;
                      }
                    });
                  },
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(10,20,10,30),
                child:Neumorphic(
                  style: NeumorphicStyle(
                    shape: NeumorphicShape.concave,
                    boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)), 
                    depth: -5,
                    intensity: .9,
                    surfaceIntensity: .1,
                    lightSource: LightSource.topLeft,
                    color: bgCol,
                  ),
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                     Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        hideInput ? '' : input,
                        style: TextStyle(
                          fontSize: 48,
                          color: textCol,
                          fontFamily: 'MyFont',
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        output,
                        style: TextStyle(
                          fontSize: outputSize,
                          color: textCol,
                          fontFamily: 'MyFont2',
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
                ),
              ),
            ),
            Row(
                children: [
                  button(text: "AC", tcolor: textCol2, buttonBg: buttonGradientMain2),
                  button(text: "CLR", tcolor: textCol2, buttonBg: buttonGradientMain2),
                ],
              ),
            Row(
                children: [
                  button(text: "sin", tcolor: textCol2, buttonBg: buttonGradient),
                  button(text: "cos", tcolor: textCol2, buttonBg: buttonGradient),
                  button(text: "tan", tcolor: textCol2, buttonBg: buttonGradient),
                  button(text: "exp", tcolor: textCol2, buttonBg: buttonGradient),
                ],
              ),
            Row(
                children: [
                  button(text: "(", tcolor: textCol, buttonBg: buttonGradientMain),
                  button(text: ")", tcolor: textCol, buttonBg: buttonGradientMain),
                  button(text: "inv", tcolor: textCol, buttonBg: buttonGradientMain),
                  button(text: "%", tcolor: textCol, buttonBg: buttonGradientMain),
                  button(text: "/", tcolor: textCol2, buttonBg: buttonGradient),
                ],
              ),
            Row(
                children: [
                  button(text: "1",tcolor: textCol, buttonBg: buttonGradientMain),
                  button(text: "2",tcolor: textCol, buttonBg: buttonGradientMain),
                  button(text: "3",tcolor: textCol, buttonBg: buttonGradientMain),
                  button(text: "^",tcolor: textCol, buttonBg: buttonGradientMain),
                  button(text: "x", tcolor: textCol2, buttonBg: buttonGradient),
                ],
              ),
            Row(
                children: [
                  button(text: "4",tcolor: textCol, buttonBg: buttonGradientMain),
                  button(text: "5",tcolor: textCol, buttonBg: buttonGradientMain),
                  button(text: "6",tcolor: textCol, buttonBg: buttonGradientMain),
                  button(text: "√",tcolor: textCol, buttonBg: buttonGradientMain),
                  button(text: "-", tcolor: textCol2, buttonBg: buttonGradient),
                ],
              ),
            Row(
                children: [
                  button(text: "7",tcolor: textCol, buttonBg: buttonGradientMain),
                  button(text: "8",tcolor: textCol, buttonBg: buttonGradientMain),
                  button(text: "9",tcolor: textCol, buttonBg: buttonGradientMain),
                  button(text: "!",tcolor: textCol, buttonBg: buttonGradientMain),
                  button(text: "+", tcolor: textCol2, buttonBg: buttonGradient),
                ],
              ),
            Row(
                children: [
                  button(text: "π",tcolor: textCol, buttonBg: buttonGradientMain),
                  button(text: "0",tcolor: textCol, buttonBg: buttonGradientMain),
                  button(text: ".",tcolor: textCol, buttonBg: buttonGradientMain),
                  button(text: "e",tcolor: textCol, buttonBg: buttonGradientMain),
                  button(text: "=", tcolor: textCol2, buttonBg: buttonGradient),
                ],
              ),
          ],
        )
      )
    );
  }

  Widget button({
      text, tcolor=Colors.black, buttonBg=grad1
    }) {
    return Expanded(
      child: Container(
        height: 50,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          gradient: buttonBg,
          borderRadius: BorderRadius.circular(12),
          
        ),
        child: NeumorphicButton(
          style: NeumorphicStyle(
            shape: NeumorphicShape.concave,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)), 
            depth: 2.5,
            lightSource: LightSource.topLeft,
            color: Colors.transparent,
          ),
          onPressed: () => onButttonClick(text),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'MyFont2',
                color: tcolor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
  
  bool isNumber(String character) {
    return int.tryParse(character) != null;
  }
}