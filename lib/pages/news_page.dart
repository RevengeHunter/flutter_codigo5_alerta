import 'package:flutter/material.dart';
import 'package:flutter_codigo5_alerta/models/noticia_model.dart';
import 'package:flutter_codigo5_alerta/services/api_services.dart';
import 'package:flutter_codigo5_alerta/ui/general/colors.dart';
import 'package:flutter_codigo5_alerta/ui/widgets/item_new_widget.dart';

import 'general_form_page.dart';

class NewsPage extends StatefulWidget {
  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  APIServices _apiServices = APIServices();
  List<NoticiaModel> noticiaModelList = [];
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNews();
  }

  getNews() {
    isLoading = true;
    setState(() {});
    _apiServices.noticia().then((value) {
      noticiaModelList = value;
      isLoading = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScafoldBackGrounColor,
      appBar: AppBar(
        backgroundColor: kScafoldBackGrounColor,
        elevation: 0,
        title: Text(
          "Noticias",
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kButtonBackGrounColor,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=> GeneralFormPage()));
        },
      ),
      body: !isLoading
          ? ListView.builder(
              itemCount: noticiaModelList.length,
              itemBuilder: (BuildContext context, int index) {
                return ItemNewWidget(
                  noticiaModel: noticiaModelList[index],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GeneralFormPage(
                          noticiaModel: noticiaModelList[index],
                        ),
                      ),
                    ).then((value) {
                      getNews();
                    });
                  },
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
