import 'package:flutter/material.dart';

class SquareTitle extends StatelessWidget {

  final String imagePath;
  final Function()? onTap;

  const SquareTitle({Key? key , required this.imagePath , required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(17.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(16.0),
          color: Colors.grey[200],
        ),
         child: Image.asset(imagePath , height: 50,),
      ),
    );
  }
}
