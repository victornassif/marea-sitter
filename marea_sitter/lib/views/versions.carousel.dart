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
              return carousel(snp.data, context);
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

Widget carousel(List<Version> versions, context) {
  final List<Widget> slides = versions
      .map(
        (item) => Container(
          margin: EdgeInsets.fromLTRB(
              MediaQuery.of(context).size.width * 0.02,
              MediaQuery.of(context).size.height * 0.07,
              MediaQuery.of(context).size.width * 0.02,
              MediaQuery.of(context).size.height * 0.07),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
            child: Container(
              width: 1000,
              height: 1000,
              color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                  .withOpacity(1.0),
              child: Column(
                children: [
                  Text('iae'),
                  Text('iae'),
                  Text('iae'),
                ],
              ),
            ),
          ),
        ),
      )
      .toList();

  return Container(
    child: CarouselSlider(
      options: CarouselOptions(
        autoPlay: false,
        aspectRatio: 2.0,
        enlargeCenterPage: true,
        height: MediaQuery.of(context).size.height * 0.85,
        enlargeStrategy: CenterPageEnlargeStrategy.height,
      ),
      items: slides,
    ),
  );
}


Card cardInfo() {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
      elevation: 0,
      margin: new EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 6.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
        ),
        child: Column(
          children: <Widget>[
            //titulo
            Text(
              'Teste',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            //content
            // Container(
            //   margin: EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 30),
            //   child: buildListViewInfo(info.conteudo),
            // )
          ],
        ),
      ),
    );
  }
