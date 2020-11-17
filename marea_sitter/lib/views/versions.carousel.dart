import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:marea_sitter/components/navbar.widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:marea_sitter/models/version.model.dart';
import 'package:marea_sitter/repository/version.repository.dart';

class VersionCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fábrica'),
        centerTitle: true,
      ),
      drawer: NavBar(),
      body: FutureBuilder(
          future: VersionRepository().getAllVersions(),
          builder: (ctx, snp) {
            if (snp.hasData) {
              return carousel(snp.data);
            } else {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.blue[100],
                ),
              );
            }
          }),
    );
  }
}

Widget carousel(List<Version> versions) {
  final List<Widget> slides = versions
      .map((item) => Container(
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                child: Stack(
                  children: <Widget>[
                    Container(
                      color:
                          Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                              .withOpacity(1.0),
                      height: 700,
                    )
                  ],
                )),
          ))
      .toList();

  return Container(
    child: CarouselSlider(
      options: CarouselOptions(
        autoPlay: false,
        aspectRatio: 2.0,
        enlargeCenterPage: true,
        enlargeStrategy: CenterPageEnlargeStrategy.height,
      ),
      items: slides,
    ),
  );
}
