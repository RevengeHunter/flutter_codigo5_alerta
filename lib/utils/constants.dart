import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_codigo5_alerta/ui/general/colors.dart';

const String pathApi = "http://alertahunter.herokuapp.com/API";
const String pathGoogleMaps = "https://www.google.com/maps/search/?";//query=36.26577,-92.54324";

enum TypeMessage{
  success,
  error,
  loginSuccess,
}

Map<TypeMessage,String> messages={
  TypeMessage.loginSuccess: "Bienvenido, tus credenciales son validas.",
  TypeMessage.success: "---",
  TypeMessage.error: "Hubo un inconveniente, por favor, intentalo nuevamente.",
};

Map<TypeMessage,Color> messageColor={
  TypeMessage.loginSuccess: kSuccessColor,
  TypeMessage.success: kSuccessColor,
  TypeMessage.error: kErrorColor,
};

Map<TypeMessage,IconData> messageIcon={
  TypeMessage.loginSuccess: Icons.check_circle_outline,
  TypeMessage.success: Icons.check_circle_outline,
  TypeMessage.error: Icons.error_outline,
};