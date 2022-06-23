import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../general/colors.dart';

class InputTextFieldWidget extends StatelessWidget {
  String hintText;
  int? maxLength;
  TextInputType? textInputType;
  TextEditingController controller;
  bool? isSelectDate;

  InputTextFieldWidget({
    required this.hintText,
    required this.controller,
    this.textInputType,
    this.maxLength,
    this.isSelectDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 7.0,
      ),
      child: TextFormField(
        onTap: isSelectDate != null
            ? () async {
                FocusScope.of(context).requestFocus(FocusNode());
                DateTime? datePicker = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(3000),
                );
                if(datePicker != null){
                  controller.text = datePicker.toString().substring(0,10);
                }
              }
            : null,
        controller: controller,
        keyboardType: textInputType,
        style: TextStyle(
          fontSize: 14.0,
          color: Colors.white,
        ),
        maxLength: maxLength,
        inputFormatters: maxLength != null
            ? [
                FilteringTextInputFormatter(RegExp(r'[0-9]'), allow: true),
              ]
            : [],
        decoration: InputDecoration(
          filled: true,
          fillColor: kTextFieldBackGrounColor,
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.white38,
            fontSize: 14.0,
          ),
          counterText: "",
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.0),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.0),
            borderSide: BorderSide.none,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.0),
            borderSide: BorderSide.none,
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.0),
            borderSide: BorderSide.none,
          ),
          errorStyle: const TextStyle(
            color: Color(0xffef476f),
          ),
        ),
        validator: (String? value) {
          if (value!.isEmpty) return "El campo es obligatorio";
          if (maxLength != null) {
            if (value.length < maxLength!) return "El DNI debe tener 8 digitos";
          }
          return null;
        },
      ),
    );
  }
}
