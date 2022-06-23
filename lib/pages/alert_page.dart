import 'package:flutter/material.dart';
import 'package:flutter_codigo5_alerta/models/incidente_model.dart';
import 'package:flutter_codigo5_alerta/models/incidente_tipo_model.dart';
import 'package:flutter_codigo5_alerta/services/api_services.dart';
import 'package:flutter_codigo5_alerta/ui/general/colors.dart';
import 'package:flutter_codigo5_alerta/ui/widgets/alert_modal_widget.dart';
import 'package:intl/intl.dart';

import 'alert_map_page.dart';

class AlertPage extends StatefulWidget {
  const AlertPage({Key? key}) : super(key: key);

  @override
  State<AlertPage> createState() => _AlertPageState();
}

class _AlertPageState extends State<AlertPage> {
  APIServices apiServices = APIServices();
  List<IncidenteModel> incidentList = [];
  List<IncidenteModel> incidentListAux = [];
  List<IncidenteTipoModel> incidentTipoList = [];
  List<IncidenteTipoModel> incidentTipoList2 = [];

  int typeAlertValue = 0;
  bool isLoading = true;

  DateFormat formatter = DateFormat('d-MMMM-y', "es");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getAlerts();
  }

  _getAlerts() async {
    isLoading = true;
    setState(() {});
    incidentList = await apiServices.getIncidenteList();
    incidentListAux = incidentList;
    incidentTipoList = await apiServices.getIncidenteTipoList();
    incidentTipoList2 = incidentTipoList;
    incidentTipoList2.insert(
      0,
      IncidenteTipoModel(
        id: 0,
        value: 0,
        text: "Todos",
        titulo: "Todos",
        area: "SERENAZGO",
        nivel: "ALTA",
      ),
    );
    typeAlertValue = incidentTipoList.first.id;
    isLoading = false;
    setState(() {});
  }

  showBottomForm() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext contex) {
        return AlertModalWidget(
          typeAlerts: incidentTipoList,
          onSelected: (int? value) {},
        );
      },
    ).then((value) {
      _getAlerts();
    });
  }

  String _dateFormat(String dateTime) {
    //dateTime = dateTime.replaceAll("-", "/");
    DateTime myDate = DateFormat('d-M-y', "es").parse(dateTime);
    // List<String> newDate = dateTime.split("-");
    // String newDate2 = "";
    // for(int i = newDate.length - 1;i>=0;i--){
    //   newDate2 = newDate2 + newDate[i] + (i==0 ? "":"-");
    // }
    String formatted = formatter.format(myDate);
    //print(formatted);
    return formatted;
  }

  filterAlertType(int value) {
    incidentList = incidentListAux;
    if (value != 0) {
      incidentList = incidentList
          .where((element) => element.tipoIncidente.id == value)
          .toList();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScafoldBackGrounColor,
      floatingActionButton: FloatingActionButton(
        backgroundColor: kButtonBackGrounColor,
        onPressed: () {
          showBottomForm();
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: kScafoldBackGrounColor,
        title: Text("Alertas"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AlertMapPage(alerts:incidentList,typeAlerts: incidentTipoList,)));
            },
            icon: Icon(Icons.location_on),
          ),
        ],
      ),
      body: !isLoading
          ? Column(
              children: [
                //DROP-DOWN
                Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10.0),
                  padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 4.0),
                  decoration: BoxDecoration(
                    color: kScafoldBackGrounColor,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      isExpanded: true,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                      dropdownColor: kScafoldBackGrounColor,
                      value: typeAlertValue,
                      items: incidentTipoList2
                          .map(
                            (e) => DropdownMenuItem(
                              value: e.id,
                              child: Text(
                                e.text,
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (int? value) {
                        typeAlertValue = value!;
                        filterAlertType(value);
                        setState(() {});
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: incidentList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white.withOpacity(0.05),
                        ),
                        child: ListTile(
                          title: Text(
                            incidentList[index].tipoIncidente.titulo,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 14.0,
                            ),
                          ),
                          subtitle: Text(
                            "${incidentList[index].ciudadanoNombre} (${incidentList[index].datosCiudadano.dni})",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Colors.white70, fontSize: 13.0),
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                _dateFormat(incidentList[index].fecha),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 13.0,
                                ),
                              ),
                              Text(
                                incidentList[index].hora,
                                style: const TextStyle(
                                  color: Colors.white54,
                                  fontSize: 13.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
