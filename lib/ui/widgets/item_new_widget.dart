import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_codigo5_alerta/models/noticia_model.dart';

class ItemNewWidget extends StatelessWidget {
  NoticiaModel noticiaModel;
  Function onTap;

  ItemNewWidget({
    required this.noticiaModel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onTap();
      },
      child: Container(
        margin:
        const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
        width: double.infinity,
        height: 260,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              noticiaModel.imagen,
              fit: BoxFit.cover,
              errorBuilder: (BuildContext context, Object error,
                  StackTrace? stackTrace) {
                return Image.network(
                  "https://images.pexels.com/photos/11513528/pexels-photo-11513528.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
                  fit: BoxFit.cover,
                );
              },
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.center,
                  colors: [
                    Colors.black.withOpacity(0.7),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 14.0, vertical: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    noticiaModel.titulo,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                    ),
                  ),
                  Text(
                    noticiaModel.fecha.toString().substring(0,10),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white54,
                      fontSize: 13.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
