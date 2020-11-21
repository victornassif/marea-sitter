import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:marea_sitter/components/navbar.widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:marea_sitter/models/version.model.dart';
import 'package:marea_sitter/repository/version.repository.dart';
import 'package:marea_sitter/views/dispatch.form.dart';
import 'package:marea_sitter/views/factory.list.dart';
import 'package:percent_indicator/percent_indicator.dart';

class FactoryCarousel extends StatefulWidget {
  @override
  _FactoryCarouselState createState() => _FactoryCarouselState();
}

Future<Null> _handleRefresh() async {
  await getData();
}

getData() async {
  var list = await VersionRepository().getAllVersions();
  _streamController.add(list);
}

final _streamController = StreamController<List<Version>>.broadcast();

class _FactoryCarouselState extends State<FactoryCarousel> {
  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            'fabricação',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              tooltip: 'Refresh',
              icon: Icon(Icons.refresh),
              onPressed: _handleRefresh,
            ),
          ]),
      drawer: NavBar(),
      body: StreamBuilder(
          stream: _streamController.stream,
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
              MediaQuery.of(context).size.height * 0.03,
              MediaQuery.of(context).size.width * 0.02,
              MediaQuery.of(context).size.height * 0.01),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.8,
              color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                  .withOpacity(1.0),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  Container(
                    width: 250,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      border: Border.all(
                        width: 3,
                        color: Colors.black,
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          item.title,
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Text(
                          item.description,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  CircularPercentIndicator(
                    radius: 120.0,
                    lineWidth: 13.0,
                    animation: true,
                    percent: item.percentual,
                    center: Text(
                      (item.percentual * 100).toStringAsFixed(0) + '%',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: Color(0xFF03fc07),
                    backgroundColor: Colors.white,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 18),
                    child: Text(
                      (item.numFactoryConcluido).toString() +
                          '/' +
                          (item.quantidadeTotal).toString() +
                          '' +
                          ' remessas prontas',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18.0),
                    ),
                  ),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.black),
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed('/factory-form', arguments: item);
                    },
                    color: Colors.white,
                    textColor: Colors.black,
                    child: Text(
                      "fabricar robôs",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.black),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FactoryList(version: item),
                        ),
                      );
                    },
                    color: Colors.white,
                    textColor: Colors.black,
                    child: Text(
                      "consultar fabricações",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.black),
                    ),
                    onPressed: () async {
                      var versionAtualizada =
                          await VersionRepository().getVersion(item.id);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return DispatchForm(version: versionAtualizada);
                          },
                        ),
                      );
                    },
                    color: Colors.white,
                    textColor: Colors.black,
                    child: Text(
                      "despachar remessa",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
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
