import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  RoundButton({super.key, required this.title, this.onPress});

  String title;
  VoidCallback? onPress;
  

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: Colors.blue),
        height: 50,
        width: double.infinity,
        child: Center(
            child: Text(
          title,
          style: TextStyle(fontSize: 22, color: Colors.white),
        )),
      ),
    );
  }
}
