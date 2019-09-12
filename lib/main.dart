import 'package:flutter/material.dart';

void main() => runApp(Calculator());

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CloneCalculator(),
    );
  }
}

class CloneCalculator extends StatefulWidget {
  @override
  _CloneCalculatorState createState() => _CloneCalculatorState();
}

class _CloneCalculatorState extends State<CloneCalculator> {

  dynamic text ='0';
  double numOne = 0;
  double numTwo = 0;

  dynamic result = '';
  dynamic finalResult = '';
  dynamic opr = '';
  dynamic preOpr = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                  child: Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 60.0,
                ),
                textAlign: TextAlign.right,
              ))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              btnShape("C", Color(0xffa5a5a5), Colors.black),
              btnShape("+/-", Color(0xffa5a5a5), Colors.black),
              btnShape("%", Color(0xffa5a5a5), Colors.black),
              btnShape("/", Colors.orange, Colors.black),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              btnShape("7", Color(0xff333333), Colors.white),
              btnShape("8", Color(0xff333333), Colors.white),
              btnShape("9", Color(0xff333333), Colors.white),
              btnShape("*", Colors.orange, Colors.black),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              btnShape("4", Color(0xff333333), Colors.white),
              btnShape("5", Color(0xff333333), Colors.white),
              btnShape("6", Color(0xff333333), Colors.white),
              btnShape("-", Colors.orange, Colors.black),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              btnShape("1", Color(0xff333333), Colors.white),
              btnShape("2", Color(0xff333333), Colors.white),
              btnShape("3", Color(0xff333333), Colors.white),
              btnShape("+", Colors.orange, Colors.black),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              btnShapeZero("0", Color(0xff333333), Colors.white),
              btnShape(".", Color(0xff333333), Colors.white),
              btnShape("=", Colors.orange, Colors.black),
            ],
          )
        ],
      ),
    );
  }

  Widget btnShape(btnText, Color color, Color txtColor) {
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: RaisedButton(
        onPressed: () {
          calculation(btnText);
        },
        color: color,
        child: Text(
          btnText,
          style: TextStyle(
            fontSize: 30.0,
            color: txtColor,
          ),
        ),
        padding: EdgeInsets.all(25.0),
        shape: CircleBorder(),
      ),
    );
  }

  Widget btnShapeZero(btnText, Color color, Color txtColor) {
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: RaisedButton(
        onPressed: () {
          calculation(btnText);
        },
        color: color,
        child: Text(
          btnText,
          style: TextStyle(fontSize: 30.0, color: txtColor),
        ),
        padding:
            EdgeInsets.only(right: 80.0, left: 80.0, top: 25.0, bottom: 25.0),
        shape: StadiumBorder(),
      ),
    );
  }

  void calculation(btnText) {
    if (btnText == 'C') {
      text = '0';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '';
      opr = '';
      preOpr = '';
    } else if (opr == '=' && btnText == '=') {
      if (preOpr == '+') {
        finalResult = add();
      } else if (preOpr == '-') {
        finalResult = sub();
      } else if (preOpr == '*') {
        finalResult = mul();
      } else if (preOpr == '/') {
        finalResult = div();
      }
    } else if (btnText == '+' ||
        btnText == '-' ||
        btnText == '*' ||
        btnText == '/' ||
        btnText == '=') {
      if (numOne == 0) {
        numOne = double.parse(result);
      } else {
        numTwo = double.parse(result);
      }

      if (opr == '+') {
        finalResult = add();
      } else if (opr == '-') {
        finalResult = sub();
      } else if (opr == '*') {
        finalResult = mul();
      } else if (opr == '/') {
        finalResult = div();
      }
      preOpr = opr;
      opr = btnText;
      result = '';
    } else if (btnText == '%') {
      result = numOne / 100;
      finalResult = doesContainDecimal(result);
    } else if (btnText == '.') {
      if (!result.toString().contains('.')) {
        result = result.toString() + '.';
      }
      finalResult = result;
    } else if (btnText == '+/-') {
      result.toString().startsWith('-')
          ? result = result.toString().substring(1)
          : result = '-' + result.toString();
      finalResult = result;
    } else {
      result = result + btnText;
      finalResult = result;
    }

    setState(() {
      text = finalResult;
    });
  }

  String add() {
    result = (numOne + numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String sub() {
    result = (numOne - numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String mul() {
    result = (numOne * numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String div() {
    result = (numOne / numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String doesContainDecimal(dynamic result) {

    if(result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if(!(int.parse(splitDecimal[1]) > 0))
        return result = splitDecimal[0].toString();
    }
    return result;
  }
}
