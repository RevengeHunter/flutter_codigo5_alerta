import 'package:flutter/material.dart';
import 'package:flutter_codigo5_alerta/pages/alert_page.dart';
import 'package:flutter_codigo5_alerta/pages/news_page.dart';
import 'package:flutter_codigo5_alerta/ui/general/colors.dart';
import 'package:flutter_codigo5_alerta/ui/widgets/general_widget.dart';

import '../ui/widgets/item_home_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScafoldBackGrounColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                "Home Alert",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              dividerVertical12(),
              ItemHomeWidget(
                title: "Noticias",
                image:
                    "https://images.pexels.com/photos/3408744/pexels-photo-3408744.jpeg",
                toPage: NewsPage(),
              ),
              ItemHomeWidget(
                title: "Personal",
                image:
                    "https://images.pexels.com/photos/9304002/pexels-photo-9304002.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
                toPage: NewsPage(),
              ),
              ItemHomeWidget(
                title: "Deporte",
                image:
                    "https://images.pexels.com/photos/248547/pexels-photo-248547.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
                toPage: NewsPage(),
              ),
              ItemHomeWidget(
                title: "Musica",
                image:
                    "https://images.pexels.com/photos/12332443/pexels-photo-12332443.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
                toPage: NewsPage(),
              ),
              ItemHomeWidget(
                title: "Alerta",
                image:
                    "https://images.pexels.com/photos/1543417/pexels-photo-1543417.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
                toPage: AlertPage(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
