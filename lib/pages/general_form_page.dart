import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_codigo5_alerta/models/noticia_model.dart';
import 'package:flutter_codigo5_alerta/services/api_services.dart';
import 'package:flutter_codigo5_alerta/ui/general/colors.dart';
import 'package:flutter_codigo5_alerta/ui/widgets/general_widget.dart';
import 'package:flutter_codigo5_alerta/ui/widgets/input_textfield_widget.dart';
import 'package:flutter_codigo5_alerta/utils/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_native_image/flutter_native_image.dart';

import '../ui/widgets/button_normal_widget.dart';

class GeneralFormPage extends StatefulWidget {
  NoticiaModel? noticiaModel;
  GeneralFormPage({this.noticiaModel});

  @override
  State<GeneralFormPage> createState() => _GeneralFormPageState();
}

class _GeneralFormPageState extends State<GeneralFormPage> {
  final APIServices _apiServices = APIServices();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final ImagePicker _imagePicker = ImagePicker();
  XFile? imageNews;

  final TextEditingController _txtTitulo = TextEditingController();
  final TextEditingController _txtLink = TextEditingController();
  final TextEditingController _dtpFecha = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.noticiaModel != null) {
      _txtTitulo.text = widget.noticiaModel!.titulo;
      _txtLink.text = widget.noticiaModel!.link;
      _dtpFecha.text = widget.noticiaModel!.fecha.toString().substring(0, 10);
    }
  }

  getImageGallery() async {
    XFile? imageXFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    imageNews = imageXFile;
    setState(() {});
  }

  _update() async {
    if (_formKey.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      NoticiaModel noticiaModel = NoticiaModel(
        id: widget.noticiaModel!.id,
        link: _txtLink.text,
        titulo: _txtTitulo.text,
        fecha: DateTime.parse(_dtpFecha.text),
        imagen: "",
      );

      File? _image = imageNews == null ? null : File(imageNews!.path);
      if (_image != null) {
        _image = await FlutterNativeImage.compressImage(
          _image.path,
          quality: 50,
        );
        print(_image.lengthSync());
      }

      _apiServices.patchNewsV2(noticiaModel, _image).then((value) {
        if (value != null) {
          snackBarMessage(context, TypeMessage.success);
          Navigator.pop(context);
        } else {
          isLoading = false;
          snackBarMessage(context, TypeMessage.error);
          setState(() {});
        }
      });
    }
  }

  _insert() async {
    if (_formKey.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      NoticiaModel noticiaModel = NoticiaModel(
        link: _txtLink.text,
        titulo: _txtTitulo.text,
        fecha: DateTime.parse(_dtpFecha.text),
        imagen: "",
      );

      File? _image = imageNews == null ? null : File(imageNews!.path);
      if (_image != null) {
        _image = await FlutterNativeImage.compressImage(
          _image.path,
          quality: 50,
        );
        print(_image.lengthSync());
      }

      _apiServices.postNews(noticiaModel, _image).then((value) {
        if (value != null) {
          snackBarMessage(context, TypeMessage.success);
          Navigator.pop(context);
        } else {
          isLoading = false;
          snackBarMessage(context, TypeMessage.error);
          setState(() {});
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScafoldBackGrounColor,
      appBar: AppBar(
        backgroundColor: kScafoldBackGrounColor,
        title: Text(
          "Form",
        ),
        actions: [
          IconButton(
            onPressed: () {
              getImageGallery();
            },
            icon: Icon(
              Icons.image,
            ),
          ),
        ],
      ),
      body: !isLoading
          ? SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 14.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      InputTextFieldWidget(
                        hintText: "Titulo",
                        controller: _txtTitulo,
                      ),
                      InputTextFieldWidget(
                        hintText: "Link",
                        controller: _txtLink,
                      ),
                      InputTextFieldWidget(
                        hintText: "Fecha",
                        controller: _dtpFecha,
                        isSelectDate: true,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 12.0),
                        width: double.infinity,
                        height: 300.0,
                        child: ClipRRect(
                          child: imageNews == null
                              ? Container(
                                  child: Image.asset(
                                    "assets/images/LandScape.png",
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Image.file(
                                  File(imageNews!.path),
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      dividerVertical12(),
                      ButtonNormalWidget(
                        title: "Guardar",
                        onPressed: () {
                          if(widget.noticiaModel != null){
                            _update();
                          }else{
                            _insert();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
