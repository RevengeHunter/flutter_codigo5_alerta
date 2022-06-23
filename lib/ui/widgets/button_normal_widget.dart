import 'package:flutter/material.dart';

import '../general/colors.dart';

class ButtonNormalWidget extends StatelessWidget {

  String title;
  Function onPressed;

  ButtonNormalWidget({
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54.0,
      child: ElevatedButton(
        onPressed: () {
          onPressed();
        },
        style: ElevatedButton.styleFrom(
          primary: kButtonBackGrounColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
        ),
        child: Text(
          title,
        ),
      ),
    );
  }
}
