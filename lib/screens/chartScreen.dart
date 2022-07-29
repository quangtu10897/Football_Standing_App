import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:project_flutter/indicator.dart';
import 'package:easy_localization/easy_localization.dart';

class ChartScreen extends StatefulWidget {
  final int wins;
  final int loss;
  final int ties;
  final String logo;
  const ChartScreen(
      {Key? key,
      required this.loss,
      required this.wins,
      required this.ties,
      required this.logo})
      : super(key: key);

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  int touchedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr('Stats Chart')),
        backgroundColor: Colors.blue[700],
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            CircleAvatar(
              backgroundImage: NetworkImage(widget.logo),
              backgroundColor: Colors.white,
              radius: 40,
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              tr("Win-loss ratio"),
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            Expanded(
              child: PieChart(
                PieChartData(
                    pieTouchData: PieTouchData(
                        touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      });
                    }),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    sectionsSpace: 0,
                    centerSpaceRadius: 30,
                    sections: showingSections()),
              ),
            ),
            Column(
              //mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Indicator(
                  color: Color(0xff0293ee),
                  text: 'Wins',
                  isSquare: true,
                ),
                SizedBox(
                  height: 4,
                ),
                Indicator(
                  color: Color(0xfff8b250),
                  text: 'Ties',
                  isSquare: true,
                ),
                SizedBox(
                  height: 4,
                ),
                Indicator(
                  color: Color(0xff845bef),
                  text: 'Loss',
                  isSquare: true,
                ),
                SizedBox(
                  height: 4,
                ),
                SizedBox(
                  height: 18,
                ),
              ],
            ),
            const SizedBox(
              width: 28,
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    double w = (widget.wins / 38) * 100;
    double l = (widget.loss / 38) * 100;
    double winrate = num.parse(w.toStringAsFixed(2)) as double;
    double lossrate = num.parse(l.toStringAsFixed(2)) as double;
    double t = 100 - (winrate + lossrate);
    double tiesrate = num.parse(t.toStringAsFixed(2)) as double;

    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xff0293ee),
            value: winrate,
            title: '$winrate%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: tiesrate,
            title: '$tiesrate%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xff845bef),
            value: lossrate,
            title: '$lossrate%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );

        default:
          throw Error();
      }
    });
  }
}
