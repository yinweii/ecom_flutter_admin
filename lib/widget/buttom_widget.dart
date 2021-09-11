import 'package:flutter/material.dart';

class ButtomWidget extends StatelessWidget {
  final Function onPress;
  final Color backgroundColor;
  final Color textColor;
  final String text;

  const ButtomWidget(
      {Key key,
      @required this.onPress,
      @required this.backgroundColor,
      @required this.textColor,
      @required this.text})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Text(text),
          ),
        ),
      ),
    );
  }
}
