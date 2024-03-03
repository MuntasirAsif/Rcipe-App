import 'package:flutter/material.dart';


class RoundButton extends StatelessWidget {
  final String inputText;
  const RoundButton({super.key, required this.inputText});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;
    return Container(
      height: height*0.06,
      width: width*0.4,
      decoration:  BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withOpacity(0.3))
      ),
      child: Center(child: Text(inputText,style: textTheme.bodyLarge!.copyWith(color: Colors.black),)),
    );
  }
}