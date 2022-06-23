import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_codigo5_alerta/models/alert_aux_model.dart';
import 'package:flutter_codigo5_alerta/models/incidente_tipo_model.dart';
import 'package:flutter_codigo5_alerta/services/api_services.dart';

import '../general/colors.dart';
import 'button_normal_widget.dart';
import 'general_widget.dart';

class AlertModalWidget extends StatefulWidget {
  List<IncidenteTipoModel> typeAlerts;
  Function(int?) onSelected;

  AlertModalWidget({
    required this.typeAlerts,
    required this.onSelected,
  });


  @override
  State<AlertModalWidget> createState() => _AlertModalWidgetState();
}

class _AlertModalWidgetState extends State<AlertModalWidget> {
  int typeAlertValue = 0;
  APIServices apiService = APIServices();
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    typeAlertValue = widget.typeAlerts.first.id;
  }

  registerAlert() {
    isLoading = true;
    setState(() {});
    print("Va a registrar la alerta");
    AlertAuxModel alertAuxModel = AlertAuxModel(
      latitud: -11.971582,
      longitud: -75.253327,
      tipoIncidente: typeAlertValue,
      estado: "Abierto",
    );
    apiService.postCrearIncidente(alertAuxModel).then((value) {
      print("Se registro la alerta");
      print(value.toString());
      if (value != null) {
        Navigator.pop(context);
      }
      isLoading = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Stack(
      children:[
        Container(
          height: height * 0.27,
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(15.0),
              topLeft: Radius.circular(15.0),
            ),
          ),
          child: Column(
            children: [
              Container(
                height: 4,
                width: 100,
                decoration: BoxDecoration(
                  color: kButtonBackGrounColor,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              dividerVertical8(),
              const Text(
                "Porfavor selecciona y envia la alerta correspondiente",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15.0,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    value: typeAlertValue,
                    items: widget.typeAlerts
                        .map((e) => DropdownMenuItem(
                      value: e.id,
                      child: Text(
                        e.text,
                      ),
                    ))
                        .toList(),
                    onChanged: (int? value) {
                      typeAlertValue = value!;
                      setState(() {});
                    },
                  ),
                ),
              ),
              dividerVertical8(),
              ButtonNormalWidget(
                title: "Enviar Alerta",
                onPressed: () {
                  registerAlert();
                },
              ),
              dividerVertical8(),
            ],
          ),
        ),
        isLoading ? Container(
          height: height * 0.27,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.6),
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(26),
              topLeft: Radius.circular(26),
            ),
          ),
          alignment: Alignment.center,
          child: const CircularProgressIndicator(),
        ) : const SizedBox(),
      ] ,
    );
  }
}
