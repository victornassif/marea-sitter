import 'package:flutter/material.dart';
import 'package:marea_sitter/models/factory.model.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:intl/intl.dart';

class FactoryTile extends StatelessWidget {
  final Factory fac;
  const FactoryTile(this.fac);

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy HH:m');
    bool completo = fac.porcentagem == 100;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          border: Border.all(
            width: 3,
            color: Colors.black,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: [
                  Text(
                    'Ticket #' + fac.id.toString(),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Text(
                    'Quantidade: ' + fac.quantidadeRobos.toString(),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Row(
                children: [
                  Text(
                    'Data de Criação: ' + formatter.format(fac.dataCriacao),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(
                      Icons.watch_later,
                      color: Colors.grey,
                      size: 20,
                    ),
                  ),
                  if (!completo)
                    Text(
                      ' ' +
                          fac.dataConclusao
                              .difference(DateTime.now())
                              .inMinutes
                              .toStringAsFixed(0) +
                          'min',
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                ],
              ),
            ),
            LinearPercentIndicator(
              width: MediaQuery.of(context).size.width * 0.84,
              lineHeight: 30.0,
              percent: fac.porcentagem / 100,
              backgroundColor: Colors.grey,
              progressColor: Color(0xFF03fc07),
              center: completo
                  ? Text(
                      'OK!',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    )
                  : Text(
                      fac.porcentagem.toStringAsFixed(0) + '%',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
