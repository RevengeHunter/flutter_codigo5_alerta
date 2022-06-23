
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_codigo5_alerta/utils/constants.dart';

SizedBox dividerVertical8() => const SizedBox(height: 8,);
SizedBox dividerVertical12() => const SizedBox(height: 12,);
SizedBox dividerVertical18() => const SizedBox(height: 18,);
SizedBox dividerVertical24() => const SizedBox(height: 24,);
SizedBox dividerVertical30() => const SizedBox(height: 30,);

void snackBarMessage(BuildContext context, TypeMessage typeMessage){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      backgroundColor: messageColor[typeMessage],
      content: Row(
        children: [
          Icon(
            messageIcon[typeMessage],
            color: Colors.white,
          ),
          dividerVertical8(),
          Expanded(
            child: Text(
              messages[typeMessage]!,
            ),
          ),
        ],
      ),
    ),
  );
}