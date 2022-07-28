import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_flutter/models/football.dart';
import 'package:project_flutter/models/standing.dart';
import 'package:project_flutter/screens/detailsSreen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FootBallList extends StatefulWidget {
  FootBallList(
      {super.key, required this.lstFootball, required this.lstStanding});
  List<Football> lstFootball;
  List<Standing> lstStanding;
  @override
  State<FootBallList> createState() => _FootBallListState();
}

class _FootBallListState extends State<FootBallList> {
  @override
  Widget build(BuildContext context) {
    List<Standing>? listS = widget.lstFootball[0].data.standings;
    void _runFilter(String enteredKeyword) {
      List<Standing> results = listS!;
      if (enteredKeyword.isEmpty) {
        results = listS;
      } else {
        results = listS
            .where((user) => user.team.name
                .toLowerCase()
                .contains(enteredKeyword.toLowerCase()))
            .toList();
      }

      // Refresh the UI
      setState(() {
        widget.lstStanding = results;
      });
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          onChanged: (value) => _runFilter(value),
          decoration: const InputDecoration(
              labelText: 'Search', suffixIcon: Icon(Icons.search)),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Text(tr('Rank')),
              const SizedBox(
                width: 50,
              ),
              Text(tr('Name')),
              SizedBox(width: 187),
              Text(tr("Point")),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: ListView.separated(
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: widget.lstStanding.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetailsScreen(
                              name: widget.lstStanding[index].team.name,
                              href: widget.lstStanding[index].team.logo[0].href,
                              points: widget.lstStanding[index].stats![6].value,
                              goals: widget.lstStanding[index].stats![4].value,
                              ties: widget.lstStanding[index].stats![2].value,
                              wins: widget.lstStanding[index].stats![0].value,
                              loss: widget.lstStanding[index].stats![1].value,
                              rank: widget.lstStanding[index].stats![8].value,
                              goalConceded:
                                  widget.lstStanding[index].stats![5].value,
                              goalDif:
                                  widget.lstStanding[index].stats![9].value,
                              season: widget.lstFootball[0].data.season,
                            ),
                          ));
                    },
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Text('${widget.lstStanding[index].stats![8].value}'),
                          SizedBox(
                            width: 10,
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage: NetworkImage(
                                widget.lstStanding[index].team.logo[0].href),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Text(widget.lstStanding[index].team.name),
                          Expanded(
                            child: Text(
                              '${widget.lstStanding[index].stats![6].value}',
                              textAlign: TextAlign.end,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                  // Card(
                  //   child: ListTile(
                  //     onTap: () {
                  //       Navigator.pushNamed(context, '/detailsScreen');
                  //     },
                  //     title:
                  //         Text(lstFootball[0].data.standings![index].team.name),
                  //     leading: CircleAvatar(
                  //         backgroundColor: Colors.white,
                  //         backgroundImage: NetworkImage(lstFootball[0]
                  //             .data
                  //             .standings![index]
                  //             .team
                  //             .logo[0]
                  //             .href)),
                  //   ),
                  // );
                }),
          ),
        ),
      ],
    );
  }
}
