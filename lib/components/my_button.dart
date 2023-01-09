import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {

  final Function()? onTap;
  final String buttonText;

  MyButton({Key? key ,required this.onTap , required this.buttonText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          width: 400.0,
          padding: EdgeInsets.all(25.0),
          margin: EdgeInsets.symmetric(horizontal: 25.0),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(8.0),
          ),
        child: Center(
          child: Text(
              buttonText,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    );
  }
}
