import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_codigo5_alerta/models/incidente_model.dart';
import 'package:flutter_codigo5_alerta/services/api_services.dart';
import 'package:flutter_codigo5_alerta/ui/general/colors.dart';
import 'package:flutter_codigo5_alerta/ui/widgets/general_widget.dart';
import 'package:flutter_codigo5_alerta/utils/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/incidente_tipo_model.dart';
import '../utils/map_style.dart';

class AlertMapPage extends StatefulWidget {
  List<IncidenteModel> alerts;
  List<IncidenteTipoModel> typeAlerts;
  AlertMapPage({required this.alerts, required this.typeAlerts});

  @override
  State<AlertMapPage> createState() => _AlertMapPageState();
}

class _AlertMapPageState extends State<AlertMapPage> {
  //Map<MarkerId, Marker> _markers = {};
  Set<Marker> _markers2 = {};

  final CameraPosition _cameraPosition = CameraPosition(
    target: LatLng(-12.068144, -75.210574),
    zoom: 6,
  );

  int typeAlertValue = 0;

  List<IncidenteModel> incidentList = [];
  APIServices apiServices = APIServices();

  filterAlertType(int value) {
    incidentList = widget.alerts;
    if (value != 0) {
      incidentList = incidentList
          .where((element) => element.tipoIncidente.id == value)
          .toList();

      print(_markers2);
      _markers2.clear();
      print(_markers2);

      incidentList.forEach((element) {
        MarkerId _markerId = MarkerId(_markers2.length.toString());
        Marker _marker = Marker(
          markerId: _markerId,
          position: LatLng(element.latitud, element.longitud),
          onTap: () {
            showDetailAlert(element);
          },
        );
        _markers2.add(_marker);
      });
    }
    setState(() {});
  }

  List myLocations = [
    {
      "latitude": -16.423201,
      "longitude": -71.547758,
      "text": "Marcador 1",
    },
    {
      "latitude": -16.627975,
      "longitude": -71.061622,
      "text": "Marcador 2",
    },
    {
      "latitude": -18.224637,
      "longitude": -69.404926,
      "text": "Marcador 3",
    },
  ];

  getMarkersLocation() {
    myLocations.forEach((element) {
      MarkerId _markerId = MarkerId(_markers2.length.toString());
      Marker _marker = Marker(
        markerId: _markerId,
        position: LatLng(element["latitude"], element["longitude"]),
      );
      _markers2.add(_marker);
    });
    setState(() {});
  }

  getMarkerAlerts() {
    incidentList = widget.alerts;
    incidentList.forEach((element) {
      MarkerId _markerId = MarkerId(_markers2.length.toString());
      Marker _marker = Marker(
        markerId: _markerId,
        position: LatLng(element.latitud, element.longitud),
        onTap: () {
          showDetailAlert(element);
        },
      );
      _markers2.add(_marker);
    });
    setState(() {});
  }

  showDetailAlert(IncidenteModel alerta) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: kScafoldBackGrounColor,
            contentPadding: EdgeInsets.all(16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Detalle de la Alerta",
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.white70,
                  ),
                ),
                const Divider(
                  indent: 12.0,
                  endIndent: 12.0,
                  color: Colors.white70,
                ),
                Text(
                  alerta.tipoIncidente.titulo,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                dividerVertical12(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Fecha: ${alerta.fecha}",
                      style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Hora: ${alerta.hora}",
                      style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                dividerVertical12(),
                Text(
                  alerta.ciudadanoNombre,
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                dividerVertical8(),
                Text(
                  "DNI: ${alerta.datosCiudadano.dni}",
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                dividerVertical12(),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          launchUrl(Uri.parse(
                              "${pathGoogleMaps}q=${alerta.latitud},${alerta.longitud}"));
                        },
                        icon: const Icon(Icons.location_on),
                        label: const Text(
                          "Ver Mapa",
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                          primary: Color(0xfff72585),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          bool? res = await FlutterPhoneDirectCaller.callNumber(
                              alerta.datosCiudadano.telefono);
                        },
                        icon: const Icon(Icons.call),
                        label: const Text(
                          "Llamar",
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                          primary: Color(0xff3f37c9),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getMarkersLocation();
    getMarkerAlerts();
    typeAlertValue = widget.typeAlerts.first.id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: _cameraPosition,
            compassEnabled: true,
            myLocationButtonEnabled: true,
            zoomControlsEnabled: true,
            zoomGesturesEnabled: true,
            mapType: MapType.normal,
            onMapCreated: (GoogleMapController controller) {
              controller.setMapStyle(json.encode(mapStyle));
            },
            //markers: _markers.values.toSet(),
            markers: _markers2,
            // onTap: (LatLng latLng) {
            //   MarkerId _myMarkerId = MarkerId(_markers.length.toString());
            //   Marker _myMarker = Marker(
            //     markerId: _myMarkerId,
            //     position: latLng,
            //     infoWindow: InfoWindow(
            //       title: "Hola",
            //     ),
            //     icon:
            //         BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
            //     onTap: () {
            //       print("Marker");
            //     },
            //     draggable: true,
            //     onDragStart: (LatLng position) {
            //       print("DRAG-START");
            //     },
            //     onDrag: (LatLng position) {
            //       print("DRAG");
            //     },
            //     onDragEnd: (LatLng position) {
            //       print("DRAG-END");
            //     },
            //   );
            //   _markers[_myMarkerId] = _myMarker;
            //   _markers2.add(_myMarker);
            //   setState(() {});
            // },
          ),
          //DROP-DOWN
          SafeArea(
            child: Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    offset: const Offset(4, 4),
                    blurRadius: 12,
                  ),
                ],
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  isExpanded: true,
                  value: typeAlertValue,
                  items: widget.typeAlerts
                      .map(
                        (e) => DropdownMenuItem(
                          value: e.id,
                          child: Text(
                            e.text,
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (int? value) {
                    typeAlertValue = value!;
                    filterAlertType(value);
                    print(value.toString());
                    setState(() {});
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
