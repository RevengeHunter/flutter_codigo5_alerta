import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../general/colors.dart';

class InputPasswordWidget extends StatefulWidget {

  TextEditingController controller;
  InputPasswordWidget({required this.controller,});

  @override
  State<InputPasswordWidget> createState() => _InputPasswordWidgetState();
}

class _InputPasswordWidgetState extends State<InputPasswordWidget> {
  bool isInvisible = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 7.0,
      ),
      child: TextFormField(
        controller: widget.controller,
        obscureText: isInvisible,
        style: TextStyle(
          fontSize: 14.0,
          color: Colors.white,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: kTextFieldBackGrounColor,
          hintText: "Password",
          hintStyle: TextStyle(
            color: Colors.white38,
            fontSize: 14.0,
          ),
          counterText: "",
          suffixIcon: IconButton(
            onPressed: () {
              isInvisible = !isInvisible;
              setState(() {});
            },
            icon: Icon(
              isInvisible ? Icons.remove_red_eye : Icons.remove_red_eye_outlined,
              color: Colors.white70,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.0),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.0),
            borderSide: BorderSide.none,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18.0),
            borderSide: BorderSide.none,
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18.0),
            borderSide: BorderSide.none,
          ),
          errorStyle: const TextStyle(
            color: Color(0xffef476f),
          ),
        ),
        validator: (String? value){
          if(value!.isEmpty) return "El campo es obligatorio";
          return null;
        },
      ),
    );
  }
}
