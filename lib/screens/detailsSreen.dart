import 'package:flutter/material.dart';
import 'package:project_flutter/screens/chartScreen.dart';
import 'package:easy_localization/easy_localization.dart';

class DetailsScreen extends StatefulWidget {
  final String name;
  final String href;
  final int rank;
  final int points;
  final int goals;
  final int goalConceded;
  final int goalDif;
  final int wins;
  final int loss;
  final int ties;
  final int season;
  const DetailsScreen(
      {Key? key,
      required this.name,
      required this.href,
      required this.rank,
      required this.points,
      required this.goals,
      required this.goalConceded,
      required this.goalDif,
      required this.wins,
      required this.loss,
      required this.ties,
      required this.season})
      : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr('Details Screen')),
        backgroundColor: Colors.blue[700],
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 40.0, 10.0, 0.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Center(
            child: CircleAvatar(
              backgroundImage: NetworkImage(widget.href),
              backgroundColor: Colors.white,
              radius: 70,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Center(
            child: Text(
              '${tr('Seasons')} ${widget.season}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Table(
              children: [
                TableRow(children: [
                  Text(
                    '${tr('Name')} :',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    widget.name,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ]),
                TableRow(children: [
                  Text(
                    '${tr('Rank')} :',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    '${widget.rank}',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ]),
                TableRow(children: [
                  Text(
                    '${tr('Points')} :',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    '${widget.points}',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ]),
                TableRow(children: [
                  Text(
                    '${tr('Goals')} :',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    '${widget.goals}',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ]),
                TableRow(children: [
                  Text(
                    '${tr('GoalConceded')} :',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    '${widget.goalConceded}',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ]),
                TableRow(children: [
                  Text(
                    '${tr('GoalDif')} :',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    '${widget.goalDif}',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ]),
                TableRow(children: [
                  Text(
                    '${tr('Wins')} :',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    '${widget.wins}',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ]),
                TableRow(children: [
                  Text(
                    '${tr('Loss')} :',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    '${widget.loss}',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ]),
                TableRow(children: [
                  Text(
                    '${tr('Ties')} :',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    '${widget.ties}',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ]),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => ChartScreen(
                              wins: widget.wins,
                              loss: widget.loss,
                              ties: widget.ties,
                              logo: widget.href,
                            )));
              },
              child: Container(
                child: Center(child: Text(tr("Next"))),
                height: 56,
                width: 240,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ]),
        ]),
      ),
    );
  }
}
