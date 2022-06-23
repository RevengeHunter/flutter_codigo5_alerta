import 'dart:convert';
import 'dart:io';

import 'package:flutter_codigo5_alerta/helpers/sp_global.dart';
import 'package:flutter_codigo5_alerta/models/alert_aux_model.dart';
import 'package:flutter_codigo5_alerta/models/incidente_model.dart';
import 'package:flutter_codigo5_alerta/models/noticia_model.dart';
import 'package:flutter_codigo5_alerta/models/user_model.dart';
import 'package:flutter_codigo5_alerta/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';

import '../models/incidente_tipo_model.dart';

class APIServices {
  SPGlobal spGlobal = SPGlobal();

  Future<UserModel?> login(String username, String password) async {
    String _path = pathApi + "/login/";
    Uri _uri = Uri.parse(_path);
    http.Response response = await http.post(
      _uri,
      headers: {
        "Content-Type": "application/json",
      },
      body: json.encode(
        {
          "username": username,
          "password": password,
        },
      ),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> userMap = json.decode(response.body);
      UserModel userModel = UserModel.fromJson(userMap["user"]);
      userModel.token = userMap["access"];
      // print(userModel.token);
      spGlobal.token = userModel.token!;
      spGlobal.isLogin = true;
      return userModel;
    }
    return null;
  }

  Future<List<NoticiaModel>> noticia() async {
    String _path = pathApi + "/noticias/";
    Uri _uri = Uri.parse(_path);
    http.Response response = await http.get(
      _uri,
    );
    if (response.statusCode == 200) {
      ///Se utiliza la decodificacion Utf8 para identificar las tildes
      String source = const Utf8Decoder().convert(response.bodyBytes);
      List<dynamic> noticias = json.decode(source);
      //print(noticias);
      List<NoticiaModel> noticiaModelList =
          noticias.map<NoticiaModel>((e) => NoticiaModel.fromJson(e)).toList();

      return noticiaModelList;
    }
    return [];
  }

  Future<NoticiaModel?> patchNews(NoticiaModel noticiaModel) async {
    print(noticiaModel.fecha.toString());
    String _path = pathApi + "/noticias/${noticiaModel.id}/";
    Uri _uri = Uri.parse(_path);
    http.Response response = await http.patch(
      _uri,
      headers: {
        "Content-Type": "application/json",
      },
      body: json.encode(
        {
          "titulo": noticiaModel.titulo,
          "link": noticiaModel.link,
          "fecha": noticiaModel.fecha.toString().substring(0, 10),
        },
      ),
    );
    //print(DateTime.parse(noticiaModel.fecha.toString()));
    if (response.statusCode == 200) {
      String source = Utf8Decoder().convert(response.bodyBytes);
      Map<String, dynamic> noticiaMap = json.decode(source);
      NoticiaModel noticiaModel = NoticiaModel.fromJson(noticiaMap);
      print("Se actualizo correctamente");
      print(response.statusCode);
      return noticiaModel;
    }
    return null;
  }

  Future<NoticiaModel?> patchNewsV2(
      NoticiaModel noticiaModel, File? imageNews) async {
    //print(imageNews!.path);
    String _path = pathApi + "/noticias/${noticiaModel.id}/";
    Uri _uri = Uri.parse(_path);
    final request = http.MultipartRequest("PATCH", _uri);

    if (imageNews != null) {
      List<String> mimeType = mime(imageNews.path)!.split("/");
      http.MultipartFile file = await http.MultipartFile.fromPath(
        "imagen",
        imageNews.path,
        contentType: MediaType(
          mimeType[0],
          mimeType[1],
        ),
      );

      request.files.add(file);
    }

    request.fields["titulo"] = noticiaModel.titulo;
    request.fields["link"] = noticiaModel.link;
    request.fields["fecha"] = noticiaModel.fecha.toString().substring(0, 10);

    http.StreamedResponse streamedResponse = await request.send();
    http.Response response = await http.Response.fromStream((streamedResponse));

    if (response.statusCode == 200) {
      String source = Utf8Decoder().convert(response.bodyBytes);
      Map<String, dynamic> noticiaMap = json.decode(source);
      NoticiaModel noticiaModel = NoticiaModel.fromJson(noticiaMap);
      print("Se actualizo correctamente");
      print(response.statusCode);
      return noticiaModel;
    }

    return null;
  }

  Future<NoticiaModel?> postNews(NoticiaModel noticiaModel, File? imageNews) async {
    //print(imageNews!.path);
    String _path = pathApi + "/noticias/";
    Uri _uri = Uri.parse(_path);
    final request = http.MultipartRequest("POST", _uri);

    if (imageNews != null) {
      List<String> mimeType = mime(imageNews.path)!.split("/");
      http.MultipartFile file = await http.MultipartFile.fromPath(
        "imagen",
        imageNews.path,
        contentType: MediaType(
          mimeType[0],
          mimeType[1],
        ),
      );

      request.files.add(file);
    }

    request.fields["titulo"] = noticiaModel.titulo;
    request.fields["link"] = noticiaModel.link;
    request.fields["fecha"] = noticiaModel.fecha.toString().substring(0, 10);

    http.StreamedResponse streamedResponse = await request.send();
    http.Response response = await http.Response.fromStream((streamedResponse));

    if (response.statusCode == 201) {
      String source = Utf8Decoder().convert(response.bodyBytes);
      Map<String, dynamic> noticiaMap = json.decode(source);
      NoticiaModel noticiaModel = NoticiaModel.fromJson(noticiaMap);
      print("Se registro correctamente");
      print(response.statusCode);
      return noticiaModel;
    }
    return null;
  }

  Future<List<IncidenteModel>> getIncidenteList() async {
    String _path = pathApi + "/incidentes/";
    Uri _uri = Uri.parse(_path);
    http.Response response = await http.get(
      _uri,
    );
    if (response.statusCode == 200) {
      ///Se utiliza la decodificacion Utf8 para identificar las tildes
      String source = const Utf8Decoder().convert(response.bodyBytes);
      List<dynamic> incidentes = json.decode(source);
      List<IncidenteModel> alertModelList =
      incidentes.map<IncidenteModel>((e) => IncidenteModel.fromJson(e)).toList();

      return alertModelList;
    }
    return [];
  }

  Future<List<IncidenteTipoModel>> getIncidenteTipoList() async {
    String _path = pathApi + "/incidentes/tipos/";
    Uri _uri = Uri.parse(_path);
    http.Response response = await http.get(
      _uri,
    );
    if (response.statusCode == 200) {
      ///Se utiliza la decodificacion Utf8 para identificar las tildes
      String source = const Utf8Decoder().convert(response.bodyBytes);
      List<dynamic> tipoIncidentes = json.decode(source);
      List<IncidenteTipoModel> alertTypeModelList =
      tipoIncidentes.map<IncidenteTipoModel>((e) => IncidenteTipoModel.fromJson(e)).toList();

      return alertTypeModelList;
    }
    return [];
  }

  Future<IncidenteModel?> postCrearIncidente(AlertAuxModel alertAuxModel) async {
    String _path = pathApi + "/incidentes/crear/";
    Uri _uri = Uri.parse(_path);
    http.Response response = await http.post(
      _uri,
      headers: {
        "Content-Type": "application/json",
        "Authorization": spGlobal.token,
      },
      body: json.encode(alertAuxModel.toJson()),
    );
    print(response.statusCode);
    if (response.statusCode == 201) {
      ///Se utiliza la decodificacion Utf8 para identificar las tildes
      String source = const Utf8Decoder().convert(response.bodyBytes);
      Map<String, dynamic> incidente = json.decode(source);
      IncidenteModel alert = IncidenteModel.fromJson(incidente);

      return alert;
    }
    return null;
  }

}
