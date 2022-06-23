import 'package:flutter/material.dart';
import 'package:flutter_codigo5_alerta/services/api_services.dart';
import 'package:flutter_codigo5_alerta/ui/general/colors.dart';
import 'package:flutter_codigo5_alerta/ui/widgets/button_normal_widget.dart';
import 'package:flutter_svg/svg.dart';

import '../ui/widgets/general_widget.dart';
import '../ui/widgets/input_password_widget.dart';
import '../ui/widgets/input_textfield_widget.dart';
import '../utils/constants.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _dniController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  APIServices _apiServices = APIServices();

  bool isLoading = false;

  void _login() {
    if (_formKey.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      _apiServices
          .login(_dniController.text, _passwordController.text)
          .then((value) {
        if (value != null) {
          isLoading = false;
          setState(() {});
          snackBarMessage(context, TypeMessage.loginSuccess);
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => HomePage(),
          //   ),
          // );
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
              (route) => false);
        } else {
          snackBarMessage(context, TypeMessage.error);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScafoldBackGrounColor,
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        'assets/images/imagen2.svg',
                        height: 100,
                      ),
                      Text(
                        "Welcome Back!",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      dividerVertical12(),
                      Text(
                        "Please sign in to your account",
                        style: TextStyle(
                          color: Colors.white54,
                        ),
                      ),
                      dividerVertical30(),
                      InputTextFieldWidget(
                        hintText: "Nro. DNI",
                        controller: _dniController,
                        textInputType: TextInputType.number,
                        maxLength: 8,
                      ),
                      InputPasswordWidget(
                        controller: _passwordController,
                      ),
                      dividerVertical18(),
                      ButtonNormalWidget(
                        title: "Iniciar Sesion",
                        onPressed: () {
                          _login();
                        },
                      ),
                      dividerVertical18(),
                      RichText(
                        text: TextSpan(
                          text: "Don't have an Account? ",
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.white54,
                          ),
                          children: [
                            TextSpan(
                              text: "Registrate",
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff5486FF),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          isLoading
              ? Center(
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: kScafoldBackGrounColor,
                      strokeWidth: 2.3,
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
