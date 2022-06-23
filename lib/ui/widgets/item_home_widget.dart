import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../pages/news_page.dart';

class ItemHomeWidget extends StatelessWidget {
  String title;
  String image;
  Widget toPage;

  ItemHomeWidget({
    required this.title,
    required this.image,
    required this.toPage,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> toPage));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        width: double.infinity,
        height: 100.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          // color: Colors.red,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
                image),
          ),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Colors.black.withOpacity(0.7),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 10.0,
              bottom: 10.0,
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
